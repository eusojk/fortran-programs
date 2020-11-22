program main
    use mpi
    implicit none

    integer, parameter :: manager = 0, MAX_ROWS = 1000, MAX_COLS = 1000
    integer :: rank, numprocs, ierr, status(MPI_STATUS_SIZE)
    integer :: i, j, row, rows, cols, numsent, sender, anstype
    double precision :: A(MAX_ROWS,MAX_COLS), B(MAX_COLS), C(MAX_ROWS), buffer(MAX_COLS)
    double precision :: ans

    rows = 100
    cols = 100

    call MPI_INIT(ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

    
    

end program main