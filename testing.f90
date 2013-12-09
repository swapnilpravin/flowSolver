program testing
	use mylib
	implicit none
	
	double precision, dimension(3) :: T =1.0
	
	double precision, dimension(4,3) :: A = 1.0
	
	call write1DArrayToFile("testT.dat", T)
	
	call write2DArrayToFile("testA.dat", A)
	


end program