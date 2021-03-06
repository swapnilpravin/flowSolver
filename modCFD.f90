module CFD
CONTAINS
	subroutine TDMA(a, b, c, d, T)
	! dummy vars
	double precision, dimension(:) :: T
	double precision, dimension(:) :: a
	double precision, dimension(:) :: b
	double precision, dimension(:) :: c
	double precision, dimension(:) :: d
	
	! local vars
	integer :: N
	double precision, dimension(:), allocatable :: P
	double precision, dimension(:), allocatable :: Q
	integer :: i
	
	N = size(T)
	allocate(P(N))
	allocate(Q(N))
	
	P(1) = b(1)/a(1)
	Q(1) = d(1)/a(1)
	
	do i = 2,N
		P(i) = b(i) / ( a(i) - c(i) * P(i-1) )
		Q(i) = ( d(i) + c(i) * Q(i-1) ) / ( a(i) - c(i) * P(i-1) )
	enddo
	
	T(N) = Q(N)
	
	do i = N-1,1,-1
		T(i) = P(i) * T(i+1) + Q(i)
	enddo
	
	deallocate(P)
	deallocate(Q)
	
	end subroutine TDMA

! ***********************************************************
	subroutine Gauss_Seidel(aP, aN, aS, aE, aW, d, T, conv_degree)
		! dummy vars
		double precision, dimension(:,:) :: aP
		double precision, dimension(:,:) :: aN
		double precision, dimension(:,:) :: aS
		double precision, dimension(:,:) :: aE
		double precision, dimension(:,:) :: aW
		double precision, dimension(:,:) :: d
		double precision, dimension(:,:) :: T
		double precision :: conc_degree

		! local vars
		integer i, j, k
		integer :: Nx
		integer :: Ny
		double precision :: Max_residual
		double precision, dimension(:,:), allocatable:: T_previous

		Nx = size(T,1)
		Ny = size(T,2)
		
		allocate( T_previous(Nx,Ny) )
		T_previous = T

		Max_residual = 1.0
		k = 1
		do while ( Max_residual > conv_degree )
			do i=2,Nx-1
				do j=2,Ny-1
					T(i,j) = ( aN(i,j) * T(i,j+1) &
							 + aS(i,j) * T(i,j-1) &
							 + aE(i,j) * T(i+1,j) &
							 + aW(i,j) * T(i-1,j) ) / aP(i,j)
				enddo
			enddo
			Max_residual = maxval( T - T_previous ) / maxval(T_previous)
			T_previous = T
			print *, Max_residual
			k = k + 1
			print *, k
		enddo

		print *, "Convergence reached in ", k, " iterations."

		deallocate( T_previous )
	end subroutine Gauss_Seidel

end module CFD
