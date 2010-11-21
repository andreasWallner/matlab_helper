% calculates half a sine wave and exports it as a VHDL ROM
% result is scaled etc.

% parameters
resolution = 7;
precision = 8;

% calculation
x = 0 : (pi/2) / (2^resolution) : (pi/2) - (pi/2) / (2^resolution);
values = sin(x);
values = (2^precision - 1) * values;
values = int32(values);
write_vector_vhdl_rom( values, 'unsigned', precision, 'quarter_sine_rom', 'rtl');
