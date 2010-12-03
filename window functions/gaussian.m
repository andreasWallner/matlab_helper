function [ win ] = gaussian(length, sigma)
%GAUSSIAN creates gaussian window with length 'length'
	N = length - 1;
    n = 0 : N;
        
    win = exp(-0.5 * ((n-N/2)/(sigma*N/2)).^2);
end
