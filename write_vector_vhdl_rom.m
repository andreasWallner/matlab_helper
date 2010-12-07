function [ success message ] = write_vector_vhdl_rom( vector, value_type, value_width, entity_name, architecture_name )
%WRITE_VECTOR_C write a 1 dimensional vector to a VHDL file (as a ROM)
% The vector will be written to the file in the exact manner it is put into
% this function, so if integer values are needed, the input vector should
% be casted to integer values. 
% Warning: if the given filename already exists, the file will be
% overridden
%
%   Parameters:
%     vector             vector that should be written
%     value_type         type that the ROM values should have
%     value_width        width of the ROM values
%     entity_name        name of the created entity
%     architecture_name  name of the created architecture
%   Return Value:
%     success       is set to 1 if writing was successfull, otherwise 0
%     message       error message
%
% Output will look like: write_vector_vhdl_rom( [ 1 2 3 ], 'unsigned', 4, 'test', 'rtl' )
%  
%  test.vhd:
%   library ieee;
%   use ieee.std_logic_1164.all;
%   use ieee.numeric_std.all;
%   entity test is
%   port (
%   clk : in std_ulogic;
%   en : in std_ulogic;
%   addr : in unsigned(2 - 1 downto 0);
%   data : out unsigned(4 - 1 downto 0);
%   );
%   end entity
%
%   architecture rtl of test is
%   type rom_type is array(0 to 4 - 1) of unsigned(constant ROM : rom_type := (
%     to_unsigned( 1, 4),
%     to_unsigned( 2, 4),
%     to_unsigned( 3, 4)
%   );
%   begin
%     process(clk)
%     begin
%       if clk'event and clk = '1' then
%         if en = '1' then
%           data <= ROM(to_integer(addr));
%         end if;
%       end if;
%     end process;
%   end architecture

    success = 0;
    message = '';
    vector_size = size(vector);
    vector_size = vector_size(2);
    if vector_size == 0
        message = 'Can''t write empty vector to file';
        error(message);
    end
    
    if (strcmp(value_type, 'signed') ~= 0) && (strcmp(value_type, 'unsigned') ~= 0)
        message = 'unknown type';
        error(message);
    end

    [ handle message ] = fopen(strcat(entity_name, '-m.vhd'), 'w');
    if handle <= 0
        message = strcat('can''t write vector to file: ', message);
        error(message);
    end
    address_width = ceil(log2(vector_size));
    
    % write entity
    fprintf( handle, 'library ieee;\n');
    fprintf( handle, 'use ieee.std_logic_1164.all;\n');
    fprintf( handle, 'use ieee.numeric_std.all;\n');
    fprintf( handle, 'entity %s is\n', entity_name);
    fprintf( handle, 'port (\n');
    fprintf( handle, 'clk : in std_ulogic;\n');
    fprintf( handle, 'en : in std_ulogic;\n');
    fprintf( handle, 'addr : in unsigned(%d - 1 downto 0);\n', address_width);
    fprintf( handle, 'data : out %s(%d - 1 downto 0)\n', value_type, value_width);
    fprintf( handle, ');\n');
    fprintf( handle, 'end entity;\n\n');
    
    % write arch
    fprintf( handle, 'architecture %s of %s is\n', architecture_name, entity_name);
    fprintf( handle, 'type rom_type is array(0 to %d - 1) of %s(%d - 1 downto 0);\n', 2^address_width, value_type, value_width);
    
    % write values
    fprintf( handle, 'constant ROM : rom_type := (\n');
    
    for foo = 1 : vector_size
        if strcmp(value_type, 'unsigned')
            if foo ~= vector_size
                fprintf( handle, '  to_unsigned( %d, %d),\n', vector(foo), value_width);
            else
                fprintf( handle, '  to_unsigned( %d, %d)\n', vector(foo), value_width);
            end
        elseif strcmp(value_type, 'signed')
            if foo ~= vector_size
                fprintf( handle, '  to_signed( %d, %d),\n', vector(foo), value_width);
            else
                fprintf( handle, '  to_signed( %d, %d)\n', vector(foo), value_width);
            end
        else
            message = 'unknown type';
            error(message);
        end
    end
    fprintf( handle, ');\n');
    
    % write output process
    fprintf( handle, 'begin\n');
    fprintf( handle, '  process(clk)\n');
    fprintf( handle, '  begin\n');
    fprintf( handle, '    if clk''event and clk = ''1'' then\n');
    fprintf( handle, '      if en = ''1'' then\n');
    fprintf( handle, '        data <= ROM(to_integer(addr));\n');
    fprintf( handle, '      end if;\n');
    fprintf( handle, '    end if;\n');
    fprintf( handle, '  end process;\n');
    fprintf( handle, 'end architecture;');
    fclose(handle);
    
    success = 1;
end
