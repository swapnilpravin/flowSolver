simpleSolver:
	gfortran -c mylib.f90
	gfortran -c modCFD.f90
	gfortran simpleSolver.f90 mylib.f90 modCFD.f90 -o simpleSolver

testing:
	gfortran -c mylib.f90
	gfortran -c modCFD.f90
	gfortran testing.f90 mylib.f90 modCFD.f90 -o testing
