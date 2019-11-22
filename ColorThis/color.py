import keras
from keras.preprocessing import image
from keras.engine import Layer
from keras.layers import Conv2D, Conv3D, UpSampling2D, InputLayer, Conv2DTranspose, Input, Reshape, merge, concatenate
from keras.layers import Activation, Dense, Dropout, Flatten
from keras.layers.normalization import BatchNormalization
from keras.callbacks import TensorBoard
from keras.models import Sequential, Model
from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img
from keras.utils import multi_gpu_model
from skimage.color import rgb2lab, lab2rgb, rgb2gray, gray2rgb
from skimage.transform import resize
from skimage.io import imsave
from skimage import img_as_ubyte
import time
import numpy as np
import os
import random
import tensorflow as tf
from PIL import Image, ImageFile

import matplotlib
from matplotlib import pyplot as plt
import matplotlib.image as mpimg

# General path
PATH = '/content/gdrive/My Drive/Coloring/'

TRAINING_PATH = PATH + 'Train/Data256/'
TESTING_PATH = PATH + 'Train/Test256/'
WEIGHTS_PATH = PATH + 'data/'
RESULTS_PATH = PATH + 'Results/Results256/'

# Get the total number of images to train the network
NO_IMAGES = 7000
NO_EPOCHS = 1000
BATCH_SIZE = 64
TARGET_SIZE = (224,224)

def construct_decoder():
    #Encoder
    encoder_input = Input(shape = (7, 7, 512,))

    # #Decoder
    decoder_output = Conv2D(filters=256, kernel_size=(3,3),
                            activation='relu', padding='same')(encoder_input)
    decoder_output = Conv2D(filters=128, kernel_size=(3,3),
                            activation='relu', padding='same')(decoder_output)
    decoder_output = UpSampling2D((2, 2))(decoder_output)
    decoder_output = Conv2D(filters=64, kernel_size=(3,3),
                            activation='relu', padding='same')(decoder_output)
    decoder_output = UpSampling2D((2, 2))(decoder_output)
    decoder_output = Conv2D(filters=32, kernel_size=(3,3),
                            activation='relu', padding='same')(decoder_output)
    decoder_output = UpSampling2D((2, 2))(decoder_output)
    decoder_output = Conv2D(filters=16, kernel_size=(3,3),
                            activation='relu', padding='same')(decoder_output)
    decoder_output = UpSampling2D((2, 2))(decoder_output)
    decoder_output = Conv2D(filters=2, kernel_size=(3, 3),
                            activation='tanh', padding='same')(decoder_output)
    decoder_output = UpSampling2D((2, 2))(decoder_output)

    model = Model(inputs = encoder_input, outputs = decoder_output)
    model.summary()
    model.compile(optimizer='Adam', loss='mse' , metrics=['accuracy'])

    return model

def construct_encoder():
    # Download VGG16 model to use as transfer learning for the encoder
    vggmodel = keras.applications.vgg16.VGG16()
    newmodel = Sequential()

    # The last layers of the VGG16 are pooling layers so we create a new model
    # to get rid of them and just end up with a new model with already pre-defined
    # weigths that outputs an image of 7x7 with 512 filters
    for i, layer in enumerate(vggmodel.layers):
        if i < 19:
          newmodel.add(layer)
    newmodel.summary()
    for layer in newmodel.layers:
      # Set the layers to trainable false in order to not change the pre-defined
      # weights
      layer.trainable = False
    return newmodel

def train(training_path, no_images, no_epochs, batch_size, target_size, weights_path):
    newmodel = construct_encoder()

    # Create a generator that will normalize all the images between -1 and 1
    # and it will also perform some data augmentation
    data = ImageDataGenerator(rescale = 1. / 255,
                              shear_range = 0.2,
                              zoom_range = 0.2,
                              rotation_range = 20,
                              horizontal_flip = True
                              )

    # Generator that will only generate new batches of the training data
    train_datagen = ImageDataGenerator()

    # Get the images from the training directory and resize all of them into images
    # of 224x224 because that is the size that VGG16 takes as input
    train = data.flow_from_directory(training_path,
                                     target_size = target_size,
                                     batch_size = no_images,
                                     shuffle = True,
                                     class_mode = None)

    X =[]
    Y =[]
    print("Finished gathering images...")
    print("Pre-processing the images...")
    for i,img in enumerate(train[0]):
      # Convert rgb into lab image, a lab image is a color space that separates
      # the lightness from color
      lab = rgb2lab(img)
      # Add L (Lightness) channel to X
      X.append(lab[:,:,0])
      # Add ab (red/green and yellow/blue) channel to Y and divide Y by 128
      #because the range of values of ab channel is between (-127, 128)
      Y.append(lab[:,:,1:] / 128)
      if i == 3:
        imsave(PATH + 'original.jpg', img);
        imsave(PATH + 'l.jpg', lab);
        imsave(PATH + 'l_layer.jpg', lab[:,:,0])
        imsave(PATH + 'a_layer.jpg', lab[:,:,1])
        imsave(PATH + 'b_layer.jpg', lab[:,:,2])

    X = np.array(X)
    Y = np.array(Y)
    # Reshape X so that Y and X have the same dimensions
    X = X.reshape(X.shape+(1,))
    print(X.shape)
    print(Y.shape)
    print("Finished pre-processing the images...")

    print("Using VGG16 to predict...")
    vggfeatures = []
    for i, sample in enumerate(X):
      # Turn X (Lightness layer) to black and white
      sample = gray2rgb(sample)
      # Reshape the 256x256 into images of 224x224 with 1 filter and 3 channels
      sample = sample.reshape((1,224,224,3))
      # Predict sample with VGG16
      prediction = newmodel.predict(sample)
      prediction = prediction.reshape((7,7,512))
      vggfeatures.append(prediction)
    vggfeatures = np.array(vggfeatures)
    print(vggfeatures.shape)

    # Create the network
    model = construct_decoder()

    # Replicates the model from the CPU to all of our GPUs, thereby obtaining
    # single-machine multi-GPU data parallelism
    # Divide the models inputs into multiple sub-batches
    # Apply a model copy on each sub-batch. Every model copy is executed on a dedicated GPU
    # Concatenate the results into one big batch in the CPU
    # If batch_size is 64 and you use GPU = 2, then we will divide the input into 2 sub-batches
    # of 32 samples, process each sub-batch on one GPU then return the full batch of 64
    # processed samples
    try:
     model = multi_gpu_model(model, cpu_relocation = True)
     print("Training using multiple GPUs")
    except ValueError:
     print("Training using single GPU or CPU")


    """ In case of wanting to use a specific number of GPUs:
    with tf.device('/cpu:0'):
        model = Model(inputs=encoder_input, outputs=decoder_output)
        parallel_model = multi_gpu_model(model, gpus=2)
        parallel_model.compile(optimizer='Adam', loss='mse', metrics=['accuracy'])
    """

    history = model.fit_generator(train_datagen.flow(vggfeatures, Y, batch_size = BATCH_SIZE),
                        epochs = no_epochs,
                        steps_per_epoch = no_images // batch_size,
                        workers = 1, use_multiprocessing = False
                        )

    # Save the final weights
    model.save(weights_path + 'model2.h5')

    acc = history.history['acc']
    loss = history.history['loss']
    epochs = range(1, len(acc) + 1)
    plt.plot(epochs, acc, 'b', label='Training acc')
    plt.plot(epochs, loss, 'r', label='Training loss')
    plt.title('Training Accuracy and Loss')
    plt.legend()
    plt.figure()
    plt.show()

def test(test_path, target_size, weights_path, results_path):
    newmodel = construct_encoder()
    model = construct_decoder()
    model.load_weights(weights_path + 'model2.h5')
    # Get the images in the testing directory
    files = os.listdir(test_path)
    for idx, file in enumerate(files):
      # Convert them into an array and resize them into 224x224 and normalize them
      test = img_to_array(load_img(test_path+file))
      test = resize(test, target_size, anti_aliasing=True)
      test *= 1.0/255
      # Turn the images into lab images
      lab = rgb2lab(test)
      # get l layer and and turn it to black and white and reshape it
      l = lab[:,:,0]
      L = gray2rgb(l)
      L = L.reshape((1,224,224,3))
      # Pass the images through the VGG16 and encoder
      vggpred = newmodel.predict(L)
      # Pass the images through the decoder
      ab = model.predict(vggpred)
      # multiply ab values * 128 to change all the values to rgb ranges
      ab = ab * 128
      # Allocate space for new image
      cur = np.zeros((224, 224, 3))
      # Add the L  and ab layer to position 0 of the new image
      cur[:,:,0] = l
      cur[:,:,1:] = ab
      # Pass image from lab to rgb
      image = lab2rgb(cur)
      # Save the image
      imsave(results_path + '/result'+str(idx)+".jpg", img_as_ubyte(image))


if __name__ == "__main__":
    # Get start time
    start_time = time.time()
    print("Starting...")
    train(TRAINING_PATH, NO_IMAGES, NO_EPOCHS, BATCH_SIZE, TARGET_SIZE, WEIGHTS_PATH)
    test(TESTING_PATH, TARGET_SIZE, WEIGHTS_PATH, RESULTS_PATH)
    print("Finished")
    # Print the total of time training
    print("--- %s seconds ---" % (time.time() - start_time))
