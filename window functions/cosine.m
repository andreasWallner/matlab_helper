function [ win ] = cosine(length)
%COSINE creates cosine window with length 'length'
    N = length - 1;
    n = 0 : N;
        
    win = cos( pi * n / N - pi/2);
end
