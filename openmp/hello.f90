program hello_world
    USE OMP_LIB
    implicit none
    integer :: thread_id
    
    print *, "Number of processors: ", OMP_GET_NUM_PROCS()
    !$OMP PARALLEL PRIVATE(thread_id)
        thread_id = OMP_GET_THREAD_NUM()
        print *, "Hello from process:   ", thread_id
    !$OMP END PARALLEL
        
end program hello_world