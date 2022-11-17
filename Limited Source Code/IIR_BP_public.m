pointer = 0; 
bands = 30000;
%x = downsample(eeg30000Hz, 10); %30kHz uses factor of 10 for downsampling
x = downsample(eeg, 6); %20kHz --> factor of 6 to match samp. freq of 3kHz.
%cLen = length(h2);
fs = 3000;
bp = bandpass(x, [6 10], fs);


[b,a] = sos2tf(SOS,G); %SOS and G are IIR filter coeffs. SOS and G matrices are redacted.


output = filter(b,a,x);
%hilbby = filter(coeffs, 1, output);

%u = 0:1/3000:2000 * pi;
%sinwave = 100 * (sin(2 * pi * 10 * u) + sin(2 * pi * 20 * u));
%outputSin = sosfilt(SOS, sinwave);

subplot(3,1,1)
hold on
%plot(output, 'Color', 'k')
%plot(x)
plot(x-mean(x))
%plot(sinwave);
%plot(outputSin);
legend('Original EEG')
title('My IIR Bandpass Filter @ 3 kHz Sampling Rate Cheby II; 4 taps')
xlabel('Samples')
ylabel('Magnitude')
xlim([pointer, pointer+bands])
%ylim([-200 200])

subplot(3,1,2)
hold on
plot(bp)
plot(output(400:length(output)))

legend('MATLAB bandpass()', 'My IIR Filter')
title('MATLAB Baseline with IIR Output Overlay')
xlabel('Samples')
ylabel('Magnitude')
xlim([pointer pointer+bands])
%ylim([-200 200])

subplot(3,1,3)
hold on
plot(angle(hilbert(output(400:length(output)))), 'Color', 'k')
plot(angle(hilbert(bp(1:length(bp)-400+1))), 'Color','c')
title('MATLAB Baseline + Mine OVERLAY - PHASE')
legend('My IIR Filter','MATLAB')
xlabel('Samples')
ylabel('Magnitude')
xlim([pointer pointer+bands])
ylim([-4 4])

output=output(400:length(output));
