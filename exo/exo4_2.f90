program exo4_2
    ! Calculate and print a defined number of the Fibonacci sequence
    implicit none
    integer :: limit, index

    write(6, '(a)', advance='no') "Enter the limit of the Fibonacci sequence: "
    read(5, '(i3)') limit
    write(6, '(a, i3, a)') 'The first ', limit, ' Fibonacci number(s) are: '

    do index = 0, limit-1
        write(6, '(a, i3, a, i3)') 'Fib(', index, ') = ', fibonacci(index)
    end do

contains
    recursive integer function fibonacci(n) result(fib)
        integer, intent(in) :: n
        if ( n .eq. 0 .or. n .eq. 1 ) then
            fib = 1
        else
            fib = fibonacci(n-2) + fibonacci(n-1)
        end if 
    end function fibonacci

end program exo4_2