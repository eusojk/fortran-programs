program exo3_1
    implicit none

    ! a) defines an array to have 100 elements
    integer, dimension(100) :: array, temp_array
    integer :: index, start, end
    
    ! b) assigns to the elements the values 1,2,3,...100
    do index = 1, 100
        array(index) = index
    end do
    
    ! c) reads two integer values in the range 1 to 100
    write(6, '(a)', advance='no') "Enter  first integer value (1-100): "
    read(5, '(i3)') start
    write(6, '(a)', advance='no') "Enter second integer value (1-100): "
    read(5, '(i3)') end

    ! - reverses the order of the elements of the array in the range specified by the two values
    temp_array = array
    do index = start, end 
        array(index) = temp_array(end - index + start)
    end do 

    print *, "     Before       After"
    do index = 1, 100
        print *, temp_array(index), array(index)
    end do
    
end program exo3_1