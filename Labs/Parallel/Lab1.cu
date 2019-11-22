/* ITESM QRO
 Mariana Perez Garcia A01206747
 Lab 1 */

#include "cuda_runtime.h"
#include <stdio.h>

#define MAX 100000 // max size
#define TPB 512 // threads per block

// Calculates PI parallely (Riemann Sum) using the GPU.
__global__ void pi(double *res, long max){
  int index = threadIdx.x + blockIdx.x * blockDim.x;
  double width = 1.0 / max;
  int id = index;
  double mid;
  // All the values are added into their corresponding place in the res array
  while(id < max){
    mid = (id + 0.5) * width;
    res[id] = (4.0 / (1.0 + mid * mid)) * width;

    id = id + blockDim.x * gridDim.x;
  }
}

int main(){
  double *res; // cpu variable
  double *d_res; // gpu variable

  // Allocate memory of a double array in the cpu
  res = (double*) malloc(sizeof(double) * MAX); // Result Array

  // Allocate memory of a double array in the gpu
  cudaMalloc((void**)&d_res, sizeof(double) * MAX);

  // Call function pi in the gpu
  pi<<< (MAX / TPB), TPB>>>(d_res, MAX);

  // Copy resulting array from gpu to cpu
  cudaMemcpy(res, d_res, MAX * sizeof(double), cudaMemcpyDeviceToHost);
  double sum = 0.0;

  // Add all the values in the array to the final result
  for (long i = 0; i < MAX; i++) {
    sum += res[i];
  }

  // Print result
  printf("Pi: %f\n", sum);

  // Free cpu memory
  free(res);

  // Free cpu memory
  cudaFree(d_res);

  return 0;
}
