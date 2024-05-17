#include <stdio.h>

#define TILE_SIZE 16

__global__ void mysgemm(int m, int n, int k, const float *A, const float *B, float* C) {

    /********************************************************************
     *
     * Compute C = A x B
     *   where A is a (m x k) matrix
     *   where B is a (k x n) matrix
     *   where C is a (m x n) matrix
     *
     * Use shared memory for tiling
     *
     ********************************************************************/

    /*************************************************************************/
    // INSERT KERNEL CODE HERE
    int Row = blockIdx.y*blockDim.y+threadIdx.y;
    int Col = blockIdx.x*blockDim.x+threadIdx.x;
    if ((Row < m) && (Col < n)) {
        float Pvalue = 0;
        // each thread computes one element of the block sub-matrix
        for (int i = 0; i < k; ++i) {
            Pvalue += A[Row*k+i]*B[i*n+Col];
        }
        C[Row*n+Col] = Pvalue;
    }
    
    
        
    /*************************************************************************/
}

void basicSgemm(int m, int n, int k, const float *A, const float *B, float *C)
{
    // Initialize thread block and kernel grid dimensions ---------------------

    const unsigned int BLOCK_SIZE = TILE_SIZE;
	
    /*************************************************************************/
    //INSERT CODE HERE
    dim3 DimGrid((n-1)/BLOCK_SIZE+1, (m-1)/BLOCK_SIZE+1, 1);
    dim3 DimBlock(BLOCK_SIZE, BLOCK_SIZE, 1);

    /*************************************************************************/

    // Invoke CUDA kernel -----------------------------------------------------

    /*************************************************************************/
    //INSERT CODE HERE
    mysgemm<<<DimGrid, DimBlock>>>(m,n,k,A,B,C);
	
    /*************************************************************************/
}


