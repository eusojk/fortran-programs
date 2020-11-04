! A multiply-add: single-precision a*x + y aka saxpy
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

        !$omp parallel do
            do iter = 1, n
                z(iter) = a * x(iter) + y
            end do
    
    end subroutine saxpy
end program main