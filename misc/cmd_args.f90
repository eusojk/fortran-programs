program cmd_args
    implicit none
    character(len=32)           :: arg_matrix_size_str ! matrix size
    integer                     :: arg_matrix_size

    if ( command_argument_count() .ne. 1 ) then
        write(*,*) 'Error, only one argument is required for matrix size. Aborting'
        stop
    endif

    ! retrieve the argument and convert to string
    call get_command_argument(1, arg_matrix_size_str)
    read(arg_matrix_size_str, *) arg_matrix_size

    WRITE(*,'(a,i0)') 'Matrix size is: ', arg_matrix_size                        

end program cmd_args