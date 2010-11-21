function [ win ] = bartlett(length)
%BARTLETT creates barlett window with length 'length'
%   Barlett window characteristics:
%     Peak Side-Lobe Amplitude (Relative): -25dB
%     Approximate Width of Main Lobe     : 8 * pi / length
%     Peak Approximation Error           : -25dB
%     Equivalent Kaiser Window           : beta = 1.33
%     Transition Width of eq. Kaiser Win : 2.37 * pi / length
    N = length - 1;
    n = 0 : N;
        
    win = 2/N * (N/2 - abs(n-N/2));
end
