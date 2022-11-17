
    
    N = 00000;      % filter order redacted
    % below code is used to generate hilbert impulse func
    nn = (1:N)';
    g = 3*(cos(pi*nn/10)).^2./ (pi*nn);
    g = [-g(N:-1:1);0;g];
    hw = hamming(2*N+1); %hamming window
    h = g.*hw(:);
    h=h';% windowed coefficients

xhat = filter(h,1,output); %resultant from Hilbert Transform H(w);
hold on
%plot(xhat)
%plot(x-mean(x))
plot(output/4) %just scaling the amplitudes so its easy to compare.

%hilbert filter - imag and real comps
real = output(1:length(output)-N);
imag = xhat(1+N:length(xhat));

%angle between imag and real
phase = atan2(imag,real);


plot(phase)
yline(0)
%plot(angle(hilbert(output)))
xlim([10000 15000])
