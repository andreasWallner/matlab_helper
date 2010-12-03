function [ win ] = tukey(length, alpha)
%TUKEY creates tukey window with length 'length'
	N = length - 1;
    rising_n = 0 : (alpha * N) / 2;
    falling_n = N* ( 1 - alpha/2) : N;
    stable_length = length - size(rising_n,2) - size(falling_n,2);

    rising = 0.5*(1+cos(pi*((2*rising_n/(alpha*N))-1)));
    stable = ones(1,stable_length);
    falling = 0.5*(1+cos(pi*((2*falling_n/(alpha*N))-(2/alpha)+1)));
    
    win = [ rising stable falling ];
end
