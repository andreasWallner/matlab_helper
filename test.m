%% test
clc
clear
close all

length = 21 ;
fs = 48e3;
fc = 1e3;

kernel = fir_filter( length, fc/fs, hamming(length), 'l');
freq_resp_fir( kernel, 5);

kernel = kernel * 32786;

factors = int16(kernel);
write_vector_c( factors, 'short', 'filter', '\\VENUS\AEE10$\WaAndr\1st term\DSP\01_initialization\filter', true)
