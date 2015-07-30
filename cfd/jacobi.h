#include <stdio.h>
#include <stdlib.h>


void jacobi(double* T, double* aP, double* aN, double* aS, double* aE, double* aW, double* b, int NROWS, int NCOLS, int MAXITER, double TOL)
{
	int i,j, k;
	int row, col;
	int SIZE;
	int iN, iS, iE, iW;
	double e;

	double* T_new;
	
	printf("Begin Jacobi solver\n");

	
	SIZE = NROWS*NCOLS;
	T_new = (double*) malloc(SIZE*sizeof(double));
	

	printf("ITERATIONS \t ERROR\n");
	k = 0;
	do 
	{
		// One Iteration
		e = 0;
		for(i=0; i<SIZE; i++)
		{
			if (i>=NCOLS && i<=SIZE-NCOLS && i%NCOLS>0 && i%NCOLS<NCOLS-1)
			{
				iN = i-NCOLS;
				iS = i+NCOLS;
				iE = i+1;
				iW = i-1;
				
				T_new[i] = (aN[i]*T[iN] + aS[i]*T[iS] + aE[i]*T[iE] + aW[i]*T[iW])/aP[i];

				if (T_new[i] - T[i] > e)
					e = T_new[i] - T[i];
			}
		}

		for(i=0; i<SIZE; i++)
		{
			T[i] = T_new[i];
		}

		k++;
		if(k%1 == 0)
		{
			printf("%d \t %f\n", k,e);
		}
	} while(e>TOL && k<MAXITER);

	printf("Converged in %d iterations\n", k);
	printf("End Jacobi solver\n\n\n");

	free(T_new);
}
