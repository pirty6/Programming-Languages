/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 2 */

 #include "cuda_runtime.h"
 #include <stdio.h>

// Device function that multiplies two matrices
 __global__ void matrixMultiplication(float* a, float* b, float* c, int r1, int c1, int r2, int c2) {
   // get row
   int row = blockIdx.y * blockDim.y + threadIdx.y;
   // get col
   int col = blockIdx.x * blockDim.x + threadIdx.x;

   float temp =  0;

   if(row < r1 && col < c2) {
     // each thread computes one element of the block
     for(int i = 0; i < c1; i++) {
       temp += a[row * c1 + i] * b[i * c2 + col];
     }
   }
   c[row * r1 + col] = temp;
 }


// Function that will fill the matrix where i is the number that will be in m[0,0]
 void fill_array_test(float* array, int rows, int cols, int i) {
   for(int j = 0; j < rows; j++) {
     for(int k = 0; k < cols; k++) {
       if (((j + k *rows) + i) >= 10) {
         array[j + k * rows] = (float)((j + k *rows) + i) - 10;
       } else {
         array[j + k * rows] = (float)((j + k *rows) + i);
       }
     }
   }
 }

// Function that displays the matrix
 void display_array(const char *text, float *array, int rows, int cols) {
   printf("%s", text);
  for(int i = 0; i < rows * cols; i++) {
    if(i % cols == 0) {
      printf("\n");
    }
    printf("%.2f ", array[i]);
  }
}

// Host function that will be in charge of sending the data to the device
int multiply(int num_test, int rows1, int cols1, int rows2, int cols2, int start1, int start2) {
  // if the matrices are not compatible return an error
  if(rows1 != cols2) {
    printf("Error: Cannot perform matrix multiplication");
    return -1;
  }
  float* a, *b, *c, *d_a, *d_b, *d_c;
  // get number of threads per block
  int tpb = rows1;
  // get number of blocks
  int numBlocks = (tpb + (rows1 * cols2)) / tpb;
  printf("Test %i: \n", num_test);

  // Allocate memory for the matrices
  a = (float*)malloc(sizeof(float) * rows1 * cols1);
  b = (float*)malloc(sizeof(float) * rows2 * cols2);
  c = (float*)malloc(sizeof(float) * rows1 * cols2);

  // fill the matrices
  fill_array_test(a, rows1, cols1, start1);
  fill_array_test(b, rows2, cols2, start2);

  // display matrices
  display_array("Matrix A:", a, rows1, cols1);
  printf("\n");
  display_array("Matrix B:", b, rows2, cols2);
  printf("\n");

  // Allocate memory in the GPU
  cudaMalloc((void**)&d_a, sizeof(float) * rows1 * cols1);
  cudaMalloc((void**)&d_b, sizeof(float) * rows2 * cols2);
  cudaMalloc((void**)&d_c, sizeof(float) * rows1 * cols2);

  // Copy the values from CPU matrices to GPU matrices
  cudaMemcpy(d_a, a, rows1 * cols1 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, rows2 * cols2 * sizeof(float), cudaMemcpyHostToDevice);

  // declare the number of blocks
  dim3 blocks(numBlocks,numBlocks);
  // declare the number of threads
  dim3 threads(tpb,tpb);

  // call GPU function
  matrixMultiplication<<<blocks, threads>>>(d_a, d_b, d_c, rows1, cols1, rows2, cols2);

  cudaMemcpy(c, d_c, rows1 * cols2 * sizeof(float), cudaMemcpyDeviceToHost);

  // Display resulting array
  display_array("Resulting Matrix:", c, rows1, cols2);
  printf("\n\n");

  // free CPU
  free(a);
  free(b);
  free(c);

  // free GPU
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);
  return 0;
}

 int main() {
   /* -------------------------------------------------------
                        TEST 1
   -------------------------------------------------------
   Test1:
   Matrix A:
   1.00 2.00
   3.00 4.00
   Matrix B:
   4.00 5.00
   6.00 7.00
   Resulting Matrix:
   16.00 19.00
   36.00 43.00 */

   /*Multiply function that takes as parameters (no_of_test_case, no_of_rows_for_matrix1,
   no_of_cols_for_matrix1, no_of_rows_for_matrix2, no_of_cols_for_matrix2, start_of_matrix1,
   start_of_matrix2) */
   multiply(1,2,2,2,2,1,4);
   /* -------------------------------------------------------
                        TEST 2
   ---------------------------------------------------------
   Test 2:
   Matrix A:
   1.00 2.00 3.00
   4.00 5.00 6.00
   Matrix B:
   6.00 7.00
   8.00 9.00
   0.00 1.00
   Resulting Matrix:
   22.00 28.00
   64.00 79.00 */

   /*Multiply function that takes as parameters (no_of_test_case, no_of_rows_for_matrix1,
   no_of_cols_for_matrix1, no_of_rows_for_matrix2, no_of_cols_for_matrix2, start_of_matrix1,
   start_of_matrix2) */
   multiply(2,2,3,3,2,1,6);

   /* -------------------------------------------------------
                        TEST 3
   ---------------------------------------------------------
   Test 3:
   Matrix A:
   1.00 2.00
   3.00 4.00
   5.00 6.00
   Matrix B:
   6.00 7.00 8.00
   9.00 0.00 1.00
   Resulting Matrix:
   24.00 7.00 10.00
   54.00 21.00 28.00
   84.00 35.00 46.00 */

   /*Multiply function that takes as parameters (no_of_test_case, no_of_rows_for_matrix1,
   no_of_cols_for_matrix1, no_of_rows_for_matrix2, no_of_cols_for_matrix2, start_of_matrix1,
   start_of_matrix2) */
   multiply(3,3,2,2,3,1,6);

   return 0;

 }
