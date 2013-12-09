simpleSolver_1D_Heat_eqn: simpleSolver_1D_Heat_eqn.f90 mylib.f90 modCFD.f90
	gfortran -c mylib.f90
	gfortran -c modCFD.f90
	gfortran simpleSolver_1D_Heat_eqn.f90 mylib.f90 modCFD.f90 -o simpleSolver_1D_Heat_eqn

simpleSolver_2D_Heat_eqn: simpleSolver_2D_Heat_eqn.f90 mylib.f90 modCFD.f90
	gfortran -c mylib.f90
	gfortran -c modCFD.f90
	gfortran simpleSolver_2D_Heat_eqn.f90 mylib.f90 modCFD.f90 -o simpleSolver_2D_Heat_eqn

testing: testingf90 mylib.f90 modCFD.f90
	gfortran -c mylib.f90
	gfortran -c modCFD.f90
	gfortran testing.f90 mylib.f90 modCFD.f90 -o testing

modules: mylib.f90 modCFD.f90
	gfortran -c mylib.f90
	gfortran -c modCFD.f90

