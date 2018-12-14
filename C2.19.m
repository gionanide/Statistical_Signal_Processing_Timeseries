whitegaussiannoise = wgn(64,1,0);%generates an array 64x1 elements with 0 power (white gaussian noise with variance(power) 1 watt so 0 dB)
fprintf('Variance of the signal: %f\n', var(whitegaussiannoise))
%Sigma (standard deviation) uses the same formula as when calculating the RMS value 
%of a voltage or current with no dc content. Inspect the two formula and see. 
%Sigma squared is therefore a measure of power.
time = 1:64;%make times axis for 64 samples, one sample per second


%generate our custom signal
N = 64;% where t = 0....N-1 the samples from the time domain
t = (1:N);
y = 10*sin(0.2*pi*t) + 5*sin((0.2 + 1/N)*2*pi*t);

%calculate the periodogram of the signal by applying fourier transform
periodogram = real(fft(y));

%determine the frequency array
frequencyArray = 2*pi*t/N;


%DETERMINE ZERO PADDINGGG!!!!!!!!

%zero padding N
zero_paddedSignalN = [y zeros(1,N)];

%extend the time
zero_paddingTimeN = (1:2*N);

%calculate padded periodogram
zero_paddedPeriodogramN = real(fft(zero_paddedSignalN));

%determine frequencies
zero_paddingFrequencyArrayN = 2*pi*zero_paddingTimeN/(2*N);




%zero padding 3N
zero_paddedSignal3N = [y zeros(1,3*N)];

%extend the time
zero_paddingTime3N = (1:4*N);

%calculate padded periodogram
zero_paddedPeriodogram3N = real(fft(zero_paddedSignal3N));

%determine frequencies
zero_paddingFrequencyArray3N = 2*pi*zero_paddingTime3N/(4*N);




%zero padding 5N
zero_paddedSignal5N = [y zeros(1,5*N)];

%extend the time
zero_paddingTime5N = (1:6*N);

%calculate padded periodogram
zero_paddedPeriodogram5N = real(fft(zero_paddedSignal5N));

%determine frequencies
zero_paddingFrequencyArray5N = 2*pi*zero_paddingTime5N/(6*N);




%zero padding 7N
zero_paddedSignal7N = [y zeros(1,7*N)];

%extend the time
zero_paddingTime7N = (1:8*N);

%calculate padded periodogram
zero_paddedPeriodogram7N = real(fft(zero_paddedSignal7N));

%determine frequencies
zero_paddingFrequencyArray7N = 2*pi*zero_paddingTime7N/(8*N);



%plots
figure(1)
subplot(4,1,1)
plot(time,whitegaussiannoise)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('White Gaussian noise')
subplot(4,1,2)
plot(time,y)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('y(t)')
subplot(4,1,3)
plot(frequencyArray,periodogram);
ylim([-200,400]);  % static limits
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') % The power spectral density (PSD) of the signal describes the power present in 
%the signal as a function of frequency, per unit frequency
title('Periodogram of y(t)')
subplot(4,1,4)
plot(frequencyArray(1:32),periodogram(1:32))
ylim([-200,400]);  % static limits
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of y(t) non-symmetric')

%figure 2 in order to plot the padded signals
figure(2)
subplot(4,1,1)
plot(time,whitegaussiannoise)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('White Gaussian noise')
subplot(4,1,2)
plot(zero_paddingTimeN,zero_paddedSignalN)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('zero padded N y(t)')
subplot(4,1,3)
plot(zero_paddingFrequencyArrayN,zero_paddedPeriodogramN);
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded N y(t)')
subplot(4,1,4)
plot(zero_paddingFrequencyArrayN(1:N),zero_paddedPeriodogramN(1:N))
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded N y(t) non-symmetric')


%figure 2 in order to plot the padded signals
figure(3)
subplot(4,1,1)
plot(time,whitegaussiannoise)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('White Gaussian noise')
subplot(4,1,2)
plot(zero_paddingTime3N,zero_paddedSignal3N)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('zero padded 3N y(t)')
subplot(4,1,3)
plot(zero_paddingFrequencyArray3N,zero_paddedPeriodogram3N);
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded 3N y(t)')
subplot(4,1,4)
plot(zero_paddingFrequencyArray3N(1:(2*N)),zero_paddedPeriodogram3N(1:(2*N)))
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded 3N y(t) non-symmetric')


%figure 2 in order to plot the padded signals
figure(4)
subplot(4,1,1)
plot(time,whitegaussiannoise)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('White Gaussian noise')
subplot(4,1,2)
plot(zero_paddingTime5N,zero_paddedSignal5N)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('zero padded 5N y(t)')
subplot(4,1,3)
plot(zero_paddingFrequencyArray5N,zero_paddedPeriodogram5N);
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded 5N y(t)')
subplot(4,1,4)
plot(zero_paddingFrequencyArray5N(1:(3*N)),zero_paddedPeriodogram5N(1:(3*N)))
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded 5N y(t) non-symmetric')


%figure 2 in order to plot the padded signals
figure(5)
subplot(4,1,1)
plot(time,whitegaussiannoise)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('White Gaussian noise')
subplot(4,1,2)
plot(zero_paddingTime7N,zero_paddedSignal7N)
xlabel('Time (sec)')
ylabel('Amplitude') 
title('zero padded 7N y(t)')
subplot(4,1,3)
plot(zero_paddingFrequencyArray7N,zero_paddedPeriodogram7N);
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded 7N y(t)')
subplot(4,1,4)
plot(zero_paddingFrequencyArray7N(1:(4*N)),zero_paddedPeriodogram7N(1:(4*N)))
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]') 
title('Periodogram of zero padded 7N y(t) non-symmetric')
               
               
                            
                            