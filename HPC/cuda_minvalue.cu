    #include <cuda.h>
    #include <stdio.h>
    #include <time.h>

    #define SIZE 100

    __global__ void max(int *a , int *c)	// kernel function definition
    {
    int i = threadIdx.x;					// initialize i to thread ID

    *c = a[55];

            if(a[i] < *c)
                    {
                    *c = a[i];
                    }

    }

    int main()
    {
    int i;
    srand(time(NULL));		//makes use of the computer's internal clock to control the choice of the seed

    int a[SIZE];
    int c;

    int *dev_a, *dev_c;		//GPU / device parameters

    cudaMalloc((void **) &dev_a, SIZE*sizeof(int));		//assign memory to parameters on GPU from CUDA runtime API
    cudaMalloc((void **) &dev_c, SIZE*sizeof(int));

    

    for( i = 0 ; i < SIZE ; i++)
    {
    	a[i] = rand();			// input the numbers
    }
    for( i = 0 ; i < SIZE ; i++)
    {
    	printf("%d", a[i]);			// input the numbers
    }
    
    cudaMemcpy(dev_a , a, SIZE*sizeof(int),cudaMemcpyHostToDevice);		//copy the array from CPU to GPU
    max<<<1,SIZE>>>(dev_a,dev_c);										// call kernel function <<<number of blocks, number of threads
    cudaMemcpy(&c, dev_c, SIZE*sizeof(int),cudaMemcpyDeviceToHost);		// copy the result back from GPU to CPU

    printf("\nmin =  %d ",c);

    cudaFree(dev_a);		// Free the allocated memory
    cudaFree(dev_c);
    printf("");

    return 0;
    }
