program exo4_3
    
    ! A program which reads an integer value limit and 
    ! prints the coefficients of the first limit lines of this Pascal triangle.
    implicit none
    integer :: limit, k, n, iter_n, iter_k

    write(6, '(a)', advance='no') "Pascal triangle - Numbe of rows: "
    read(5, '(i3)') limit
    do iter_n = 0, limit-1
        n = iter_n
        do iter_k = 0, n
            k = iter_k
            write(6, '(i3)', advance='no') pascal_rule(n, k)
        end do
        print *, ''
    end do
    
contains
    recursive integer function factorial(number) result(facto)
        integer, intent(in) :: number
        if ( number .eq. 0 .or. number .eq. 1 ) then
            facto = 1
        else
            facto = number * factorial(number-1)
        end if 
    end function factorial

    ! This function implements "n choose k" => nCk = n! / ((n - k)!k!)
    integer function pascal_rule(n, k) result(binomial_coefficient)
        integer, intent(in) :: n,k
        binomial_coefficient = factorial(n) / (factorial(n-k) * factorial(k))
    end function pascal_rule   

end program exo4_3