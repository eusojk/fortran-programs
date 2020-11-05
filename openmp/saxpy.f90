! A multiply-add: single-precision a*x + y aka saxpy
! using a parallel do construct
program main
    implicit none
   
contains
    subroutine saxpy(z, x, y, a, n)
        use omp_lib
        implicit none
        integer             :: iter
        integer, intent(in) :: n
        real, intent(in)    :: a, y, x(n)
        real, intent(out)   ::  z(n)

        !$omp parallel do private(iter) ! In Fortran, all index of interation (i.e. iter) are implicitly private by default
            do iter = 1, n
                z(iter) = a * x(iter) + y
            end do
        !$omp end parallel do
    end subroutine saxpy
end program main