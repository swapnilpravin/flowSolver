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

end module CFD
