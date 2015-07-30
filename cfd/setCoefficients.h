void setCoefficients(double *T, double *aP, double *aN, double *aS, double *aE, double *aW, double *b, BC *myBC)
{
	double T_LEFT, T_RIGHT, T_TOP, T_BOTTOM;
	int i;
	int SIZE;

	SIZE = NROWS*NCOLS;

	if (myBC->leftType == "dirichlet")
	{
		T_LEFT = myBC->leftValue;
	}
	if (myBC->rightType == "dirichlet")
	{
		T_RIGHT = myBC->rightValue;
	}
	if (myBC->topType == "dirichlet")
	{
		T_TOP = myBC->topValue;
	}
	if (myBC->bottomType == "dirichlet")
	{
		T_BOTTOM = myBC->bottomValue;
	}

	// Set up coefficients (Includes BC)
	for(i=0;i<SIZE;i++)
	{
		if (i>=0 && i<NCOLS) // Top boundary
		{
			aP[i] = 1;
			aN[i] = 0;
			aS[i] = 0;
			aE[i] = 0;
			aW[i] = 0;
			b[i] = T_TOP;
		}
		else if (i%NCOLS == 0)	// Left boundary
		{
			aP[i] = 1;
			aN[i] = 0;
			aS[i] = 0;
			aE[i] = 0;
			aW[i] = 0;
			b[i] = T_LEFT;
		}
		else if (i%NCOLS == NCOLS-1)	// Right boundary
		{
			aP[i] = 1;
			aN[i] = 0;
			aS[i] = 0;
			aE[i] = 0;
			aW[i] = 0;
			b[i] = T_RIGHT;
		}
		else if (i>=SIZE-NCOLS)		// Bottom boundary
		{
			aP[i] = 1;
			aN[i] = 0;
			aS[i] = 0;
			aE[i] = 0;
			aW[i] = 0;
			b[i] = T_BOTTOM;
		}
		else	// Internal points
		{
			aN[i] = K*dx/dy;
			aS[i] = K*dx/dy;
			aE[i] = K*dy/dx;
			aW[i] = K*dy/dx;
			b[i] = (RHO*C*dx*dy/dt)*T[i];

			aP[i] = aN[i] + aS[i] + aE[i] + aW[i] + (RHO*C*dx*dy/dt);
		}
	}
}