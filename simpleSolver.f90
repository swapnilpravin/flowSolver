program simpleSolver
	use cfd
	use mylib
	implicit none
	
	! Variables
	!~double precision :: LENGTH = 1
	!~double precision :: WIDTH = 1
	!~integer :: Nx = 100
	!~integer :: Ny = 100
	!~double precision, dimension(:,:), allocatable :: Ux
	!~double precision, dimension(:,:), allocatable :: Uy
	
	integer, parameter :: N = 100
	double precision, dimension(N) :: T = 0
	double precision, dimension(N) :: a = 0
	double precision, dimension(N) :: b = 0
	double precision, dimension(N) :: c = 0
	double precision, dimension(N) :: d = 0
	integer :: i
	
	! set BC
	T(1) = 0
	T(N) = 1
	
	! when T(1) is given
	a(1) = 1
	b(1) = 0
	c(1) = 0
	d(1) = T(1)
	
	! when T(N) is given
	a(N) = 1
	b(N) = 0
	c(N) = 0
	d(N) = T(N)
	
	! Set coefficients according to discretized eqn.
	do i=2,N-1
		a(i) = 2
		b(i) = 1
		c(i) = 1
	enddo
	
	call TDMA(a, b, c, d, T)
	
	! write T to file
	call write1DArrayToFile("T.dat", T)
end program simpleSolver

