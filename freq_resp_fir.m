function [ fig_handle ] = freq_resp_fir( taps, accuracy )
%FREQ_RESP_FIR calculates and displays frequency response of FIR filter
%   The impulse response of the filter is fourier transformed,
%   and the result is displayed as a bode plot
%   
%   Parameters:
%     taps      array of the impulse response of the filter
%     accuracy  integer from 0...inf that specifies the frequency
%               resolution of the printed spectrum
%               resolution is 2/(length * 2^accuracy) (normalized frequency)
    if accuracy < 0
        error('accuracy has to be positive');
    end
    
    len = size(taps); len = len(2);
    fft_multiple = 2^ceil(accuracy);
    
    spectrum = fftshift(fft( [ taps zeros( 1, (fft_multiple-1) * len)]));
    spec_len = size(spectrum); spec_len = spec_len(2);
    
    half_spec_start = ceil((spec_len - 1) / 2) + 1;
    f = linspace( 0, 0.5, spec_len - half_spec_start + 1);
    
    fig_handle = gcf();
    subplot( 2, 1, 1);
    plot( f, 20*log10(abs(spectrum(half_spec_start:end))));
    title('Power Spectrum');
    xlabel('normalized frequency');
    ylabel('|Y(z)| [dB]');
    grid on

    subplot( 2, 1, 2);
    plot( f, unwrap(atan2( imag(spectrum(half_spec_start:end)), real(spectrum(half_spec_start:end))) * 180 / pi));
    title('Phase shift');
    xlabel('normalized frequency');
    ylabel('arg(Y(z)) [deg]');
    grid on
end

