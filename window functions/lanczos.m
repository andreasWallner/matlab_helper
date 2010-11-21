function [ win ] = lanczos(length)
%LANCZOS creates lanczos window with length 'length'
    n = 0 : N;
        
    win = sinc( 2 * n / N - 1);
end
