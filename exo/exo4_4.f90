program exo4_4

    !  A program which reads an alphabetic variable of length 80 and sorts the letters into
    !  alphabetic order, and prints out the frequency of occurrence of each letter.
    character (80)              :: char_input
    integer, dimension(80)      :: frequency_array
    character, dimension(80)    :: char_input_array, output_array_sorted
    integer                     :: iter

    write(6, '(a)', advance='no') 'Enter a string value: '
    read(5, '(a)') char_input


end program exo4_4