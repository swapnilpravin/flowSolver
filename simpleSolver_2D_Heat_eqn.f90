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
	
	integer, parameter :: Nx = 100
	integer, parameter :: Ny = 100

	double precision :: dx = 1.0
	double precision :: dy = 1.0

	double precision, parameter :: T_left = 1.0
	double precision, parameter :: T_right = 0.0
	double precision, parameter :: T_up = 0.0
	double precision, parameter :: T_down = 0.0
	
	double precision, dimension(Nx,Ny) :: T = 0.0
	double precision, dimension(Nx,Ny) :: aP = 0.0
	double precision, dimension(Nx,Ny) :: aN = 0.0
	double precision, dimension(Nx,Ny) :: aS = 0.0
	double precision, dimension(Nx,Ny) :: aE = 0.0
	double precision, dimension(Nx,Ny) :: aW = 0.0
	double precision, dimension(Nx,Ny) :: d = 0.0 ! source term
	
	integer :: i
	integer :: j
	
	! set BC
	T(:,1) = T_left
	T(1,:) = T_up
	T(Nx,:) = T_down
	T(:,Ny) = T_right
	
	! when T_left is given
	aP(:,1) = 1
	aN(:,1) = 0
	aS(:,1) = 0
	aE(:,1) = 0
	aW(:,1) = 0
	d(:,1) = T_left
	
	! when T_right is given
	aP(:,Ny) = 1
	aN(:,Ny) = 0
	aS(:,Ny) = 0
	aE(:,Ny) = 0
	aW(:,Ny) = 0
	d(:,Ny) = T_right

	! when T_up is given
	aP(1,:) = 1
	aN(1,:) = 0
	aS(1,:) = 0
	aE(1,:) = 0
	aW(1,:) = 0
	d(1,:) = T_up
	
	! when T_down is given
	aP(Nx,:) = 1
	aN(Nx,:) = 0
	aS(Nx,:) = 0
	aE(Nx,:) = 0
	aW(Nx,:) = 0
	d(Nx,:) = T_down

	! Set coefficients according to discretized eqn.
	do i=2,Nx-1
		do j=2,Ny-1
			aP(i,j) = 2 * (dx**2 + dy**2)
			aN(i,j) = dx**2
			aS(i,j) = dx**2
			aE(i,j) = dy**2
			aW(i,j) = dy**2
		enddo
	enddo
	
	call Gauss_Seidel(aP, aN, aS, aE, aW, d, T, 2000)
	
	! write T to file
	call write2DArrayToFile("T.dat", T)
end program simpleSolver

