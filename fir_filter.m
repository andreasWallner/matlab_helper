function [ h ] = fir_filter(taps, fn, win, type)
%FIR_FILTER creates a windowed-sinc filter with the given parameters
%   A sinc (Impulse responce of ideal filter, not causal because it
%   extends from -inf to +inf) is weighted with the user supplied window to
%   create a causal filter
%   
%   Parameters:
%     taps  number of taps the filter should have
%     fn    normalized cutoff frequency (fc / fs -> range: 0 : 0.5)
%     win   window function (supplied as array with length = length(taps))
%     type  'l' for lowpass , 'h' for highpass
    if fn > 0.5 || fn < 0
        error('invalid value for fn (normalized sampling freq.');
    end
    if taps ~= size(win,2)
        error('filter length and window length do not match');
    end
    switch(type)
        case 'l'
        case 'h'
        otherwise
            error('invalid filter type for fir_filter');
    end
            
    n = -(taps - 1) / 2 : (taps - 1) / 2;
    h = 2 * fn * sinc(2*n*fn) .* win; % <- warning, matlab defines sinc(x) as sin(pi*x)/(pi*x)
    
    % convert lowpass filter in highpass if neccesary
    if type == 'h'
        if mod(taps,2) == 1
            h0 = h((taps-1)/2);
            h0 = 1-h0;
        end
        h = -h;
        if mod(taps,2) == 1
            h((taps-1)/2) = h0;
        end
    end
end
