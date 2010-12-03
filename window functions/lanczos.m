function [ win ] = lanczos(length)
%LANCZOS creates lanczos window with length 'length'
	N = length - 1;
    n = 0 : N;
        
    win = sinc( 2 * n / N - 1);
end
