program exo4_5
    !  A program which reads an integer value limit and print the first limit prime numbers, by any method.
    implicit none
    integer :: limit, limit_counter = 0, number = 2

    write(6, '(a)', advance='no') "Number of primes: "
    read(5, '(i3)') limit
    if ( limit .eq. 0 ) stop '`limit` must be at least 1'
    write(6, '(a, i3, a)') 'The first ', limit, ' prime number(s) are: '

    do 
        if ( is_prime(number) .eqv. .true. ) then
            limit_counter = limit_counter + 1
            write(6, '(i5, a)', advance='no') number, ' '
        end if

        if ( limit_counter .eq. limit ) then
            write(6, '(a)') ' '
            exit
        end if

        number = number + 1
    end do

contains

    logical function is_prime(n)
        integer, intent(in) :: n
        integer             :: iter_i
        is_prime  = .true.
        do iter_i = 2, int( sqrt( real(n) ) ) 
            if ( modulo(n, iter_i) .eq. 0 ) then
                is_prime  = .false.
                exit
            end if
        end do
    end function is_prime

end program exo4_5