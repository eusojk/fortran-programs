! A program for estimating PI integrating the following formula
! f(a) = 4.d0 / (1.d0 + a*a)

program main
    use mpi
    implicit none
    integer :: num_rects, rank, numprocs, i, ierr
    double precision :: local_sum, estimated_pi, interval, sum_i, x, f, a
    double precision, parameter :: PI25DT = 3.141592653589793238462643d0

    f(a) = 4.d0 / (1.d0 + a*a)

    call MPI_INIT(ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

    do 
        if ( rank .eq. 0 ) then
            write(*, '(a)', advance='no') 'Enter the number of intervals: '
            read(*,*) num_rects
        endif

        ! sends value to all other processes
        call MPI_BCAST(num_rects, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)

        if (num_rects .le. 0) exit

        sum_i= 0.0d0
        interval = 1.0d0 / num_rects

        do i = rank+1, num_rects, numprocs
            x = interval * (dble(i) - 0.5d0)
            sum_i = sum_i+ f(x)
            ! print *, 'h: ', interval, 'rank: ', rank, ', x: ', x, ', sum:', sum_i
        enddo
        local_sum = interval * sum_i
        ! print *, 'rank: ', rank, ', local_sum: ', local_sum

        call MPI_REDUCE(local_sum, estimated_pi, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
         
        if (rank .eq. 0) then
            print *, 'Estimated PI: ', estimated_pi, 'Error: ', abs(estimated_pi - PI25DT)
            print *, ' '
        endif

    end do

    call MPI_FINALIZE(ierr)
     
end program main