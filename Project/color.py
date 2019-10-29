import os
import time
import numpy as np

from keras.models import Sequential
from keras.layers import Conv2D, Conv2DTranspose, InputLayer, UpSampling2D
from keras.layers import Flatten, BatchNormalization, Dense, Activation, Dropout
from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img

from skimage.io import imsave
from skimage.color import rgb2lab, lab2rgb, rgb2gray, xyz2lab

DATASET_PATH = './Train/foxes.jpg'
BATCH_SIZE = 1
IMAGE_SHAPE = (400, 400, 3)
EPOCHS = 1000

def load_dataset(dataset_path):
    image = img_to_array(load_img(dataset_path))
    image = np.array(image, dtype=float)
    X = rgb2lab(1.0/255*image)[:,:,0]
    Y = rgb2lab(1.0/255*image)[:,:,1:]
    Y /= 128
    X = X.reshape(1, 400, 400, 1)
    Y = Y.reshape(1, 400, 400, 2)
    return X, Y

def construct_generator():
    model = Sequential()
    model.add(InputLayer(input_shape=(None, None, 1)))
    model.add(Conv2D(8, (3, 3), activation='relu', padding='same', strides=2))
    model.add(Conv2D(8, (3, 3), activation='relu', padding='same'))
    model.add(Conv2D(16, (3, 3), activation='relu', padding='same'))
    model.add(Conv2D(16, (3, 3), activation='relu', padding='same', strides=2))
    model.add(Conv2D(32, (3, 3), activation='relu', padding='same'))
    model.add(Conv2D(32, (3, 3), activation='relu', padding='same', strides=2))
    model.add(UpSampling2D((2, 2)))
    model.add(Conv2D(32, (3, 3), activation='relu', padding='same'))
    model.add(UpSampling2D((2, 2)))
    model.add(Conv2D(16, (3, 3), activation='relu', padding='same'))
    model.add(UpSampling2D((2, 2)))
    model.add(Conv2D(2, (3, 3), activation='tanh', padding='same'))
    return model

def train_model(batch_size, epochs, image_shape, dataset_path):
    generator = construct_generator()
    generator.compile(optimizer = 'rmsprop', loss = 'mse')
    X, Y = load_dataset(DATASET_PATH)
    generator.fit(x = X, y = Y, batch_size = batch_size, epochs = epochs)
    print(generator.evaluate(X, Y, batch_size = batch_size))
    output = generator.predict(X)
    output *= 128

    cur = np.zeros(image_shape)
    cur[:,:,0] = X[0][:,:,0]
    cur[:,:,1:] = output[0]
    imsave('./Results/img_result.png', lab2rgb(cur))
    imsave('./Results/img_gray_version.png', rgb2gray(lab2rgb(cur)))

if __name__ == '__main__':
    train_model(BATCH_SIZE, EPOCHS, IMAGE_SHAPE, DATASET_PATH)
