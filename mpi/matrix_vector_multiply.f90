program main
    use mpi
    implicit none

    integer, parameter :: manager = 0, MAX_ROWS = 1000, MAX_COLS = 1000
    integer :: rank, numprocs, ierr, status(MPI_STATUS_SIZE)
    integer :: i, j, row, rows, cols, numsent, sender, row_tag, end_signal_tag
    double precision :: A(MAX_ROWS, MAX_COLS), B(MAX_COLS), C(MAX_ROWS), buffer(MAX_COLS)
    double precision :: dot_product

    rows = 100
    cols = 100
    dot_product = 0.0d0
    end_signal_tag = 0

    call MPI_INIT(ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

    if ( rank .eq. manager ) then

        ! 1. Initialize A, B, C
        call random_seed()
        call random_number(A)
        call random_number(B)
        C = 0.0d0

        ! 2. Send vector B to all workers
        call MPI_BCAST(B, cols, MPI_DOUBLE_PRECISION, manager, MPI_COMM_WORLD, ierr)
        
        ! 3. send a tagged row to each worker process
        numsent = 0
        do i = 1, min(numprocs - 1, rows)
            ! create the row
            do j = 1, cols
                buffer(j) = A(i, j)
            end do

            call  MPI_SEND(buffer, cols, MPI_DOUBLE_PRECISION, i, i, MPI_COMM_WORLD, ierr)
            numsent = numsent + 1
        end do

        ! 4. Receive dot product dot_productwer from workers
        do i = 1, rows
            call MPI_RECV(dot_product, 1, MPI_DOUBLE_PRECISION, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
            
            ! since row is tagged, row == tag
            row_tag = status(MPI_TAG)
            C(row_tag) = dot_product
            sender  = status(MPI_SOURCE)

            ! Send next row
            if ( numsent .lt. rows ) then

                do j = 1, cols
                    buffer(j) = A(numsent+1, j)
                end do

                call MPI_SEND(buffer, cols, MPI_DOUBLE_PRECISION, sender, numsent+1, MPI_COMM_WORLD, ierr)
                numsent = numsent + 1
            
            ! Or send the end signal when no more work to do
            else
                call MPI_SEND(MPI_BOTTOM, 0, MPI_DOUBLE_PRECISION, sender, end_signal_tag, MPI_COMM_WORLD, ierr)
            end if
        
        end do

        ! 5. Print the results of C
        do i = 1, cols
            print *, "C(", i, ") = ", C(i)
        end do

    else

        ! Receive row from manager and compute the dot product 
        call MPI_BCAST(B, cols, MPI_DOUBLE_PRECISION, manager, MPI_COMM_WORLD, ierr)

        do
            call MPI_RECV(buffer, cols, MPI_DOUBLE_PRECISION, manager, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)

            ! check for end signal, i.e. the tag is 0
            if (status(MPI_TAG) .eq. 0) exit

            ! otherwise, carry on the task at hand
            row = status(MPI_TAG)
            do i = 1, cols
                dot_product = dot_product+buffer(i)*b(i)
            end do

            call MPI_SEND(dot_product, 1, MPI_DOUBLE_PRECISION, manager, row, MPI_COMM_WORLD, ierr)
        end do

    end if
    
    call MPI_FINALIZE(ierr)

end program main