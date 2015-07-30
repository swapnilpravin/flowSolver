#include <stdio.h>

#include "jacobi.h"


#define NROWS 10
#define NCOLS 10
#define dx 1
#define dy 1
#define dt 1
#define K 1 	// Thermal conductivity
#define RHO 1
#define C 1

typedef struct BC
{
	char *leftType;
	double leftValue;
	char *rightType;
	double rightValue;
	char *topType;
	double topValue;
	char *bottomType;
	double bottomValue;
} BC;



#include "setCoefficients.h"

int main()
{
	double *T, *aP, *aN, *aS, *aE, *aW, *b;
	int SIZE;
	int i;
	BC myBC;

	SIZE = NROWS*NCOLS;
	T = (double*) malloc(SIZE*sizeof(double));
	aP = (double*) malloc(SIZE*sizeof(double));
	aN = (double*) malloc(SIZE*sizeof(double));
	aS = (double*) malloc(SIZE*sizeof(double));
	aE = (double*) malloc(SIZE*sizeof(double));
	aW = (double*) malloc(SIZE*sizeof(double));
	b = (double*) malloc(SIZE*sizeof(double));


	// Define BCs
	myBC.leftType = "dirichlet";
	myBC.leftValue = 1;
	myBC.rightType = "dirichlet";
	myBC.rightValue = 0;
	myBC.topType = "dirichlet";
	myBC.topValue = 0;
	myBC.bottomType = "dirichlet";
	myBC.bottomValue = 0;


	// Initial conditions
	for(i=0;i<SIZE;i++)
	{
		T[i] = 0;
	}

	setCoefficients(T, aP, aN, aS, aE, aW, b, &myBC);


	// Timesteps
	for(i=0;i<5;i++)
	{
		printf("Timestep: %d\n", i);
		jacobi(T, aP, aN, aS, aE, aW, b, NROWS, NCOLS, 500, 1e-4);
		setCoefficients(T, aP, aN, aS, aE, aW, b, &myBC);
	}
	


	
	// clean up memory
	free(T);
	free(aP);
	free(aN);
	free(aS);
	free(aE);
	free(aW);
	free(b);

    return 0;
}
