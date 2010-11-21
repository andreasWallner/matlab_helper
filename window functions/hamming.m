function [ win ] = hamming(length)
%HAMMING creates hamming window with length 'length'
%   Hamming window characteristics:
%     Peak Side-Lobe Amplitude (Relative): -41dB
%     Approximate Width of Main Lobe     : 8 * pi / length
%     Peak Approximation Error           : -53dB
%     Equivalent Kaiser Window           : beta = 4.86
%     Transition Width of eq. Kaiser Win : 6.27 * pi / length
    N = length - 1;
    n = -(N/2) : (N/2);
    win = 0.54 + 0.46 * cos( 2*pi*n/N);
end
