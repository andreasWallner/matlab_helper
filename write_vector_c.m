function [ success message ] = write_vector_c( vector, array_type, array_name, file_name, write_header )
%WRITE_VECTOR_C write a 1 dimensional vector to a C file (as an array)
% The vector will be written to the file in the exact type it is put into
% this function, so if integer values are needed, the input vector should
% be casted to integer values. 
% Warning: if the given filename already exists, the file will be
% overridden
%
%   Parameters:
%     vector        vector that should be written
%     array_type    C type of the array (e.g. short, int, etc.)
%     array_name    name of the array inside the file
%     file_name     file name _without_ extension (can also be a
%                   relative/absolute path)
%     write_header  determines wheter a header file should also be written 
%   Return Value:
%     success       is set to 1 if writing was successfull, otherwise 0
%     message       error message
%
% Output will look like: write_vector_c( [ 1 2 3 ], 'short', 'test', 'myfile', true)
%  
%  myfile.c:
%    short test[] = { 
%      1, 
%      2, 
%      3
%    };
%  myfile.h:
%    #ifndef myfile_h_
%    #define myfile_h_
%    extern short test[];
%    #endif // myfile_h_
    success = 0;
    message = '';
    vector_size = size(vector);
    vector_size = vector_size(2);    
    
    if vector_size == 0
        message = 'Can''t write empty vector to file';
        error(message);
    end

    [ handle message ] = fopen(strcat(file_name, '.c'), 'w');
    if handle <= 0
        message = strcat('can''t write vector to file: ', message);
        error(message);
    end
    fprintf( handle, 'const short %s_length = %d;\n', array_name, vector_size);
    fprintf( handle, 'const %s %s[] = {\n', array_type, array_name);
    for foo = 1 : vector_size
        if isinteger(vector)
            fprintf( handle, '  %d', vector(foo));
        else
            fprintf( handle, '  %f', vector(foo));
        end
        
        if foo ~= vector_size
            fprintf( handle, ',\n');
        else
            fprintf( handle, '\n');
        end
    end 
    fprintf( handle, '};\n');
    fclose(handle);
    
    if write_header == true
        [ handle message ] = fopen(strcat(file_name, '.h'), 'w');
        if handle <= 0
            message = strcat('can''t write vector to file: ', message);
            error(message);
        end
        esc_file_name = regexprep( file_name, '[\\ \$]', '_');
        fprintf( handle, '#ifndef %s_h_\n', esc_file_name);
        fprintf( handle, '#define %s_h_\n', esc_file_name);
        fprintf( handle, '#define %s_LENGTH %d\n', upper(array_name), vector_size);
        fprintf( handle, 'const extern %s %s[];\n', array_type, array_name);
        fprintf( handle, 'const extern short %s_length;\n', array_name);
        fprintf( handle, '#endif // %s_h_\n', esc_file_name);
        fclose(handle);
    end
    success = 1;
end