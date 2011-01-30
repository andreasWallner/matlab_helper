function [ x ] = discretize( x, count )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    delta = abs(max(x) - min(x));
    dv = delta / count;
    x = quant( x, dv);
end

