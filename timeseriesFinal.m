%%
%load data and optional clear
clear all;
clear;
clc;

%%
%load the data
load C:\Users\gionanide\Desktop\artic.txt

%change the path in order to run in another pc ---------------------------------------------------------------> load artic.txt

%seperate each column 
years = artic(:,1);
month = artic(:,2);
day = artic(:,3);
%data with trend
temperature_with_trend = artic(:,4);

%use the detrended data
temperature = detrend(temperature_with_trend);

%sampling frequency
fs = 1;

%determine the length
L = length(temperature);

%PSD frequencies
fVals=fs*(0:L/2-1)/L; 
%%
%Plotting the data first, for visualization

%find local maximum, and define some distance between the peaks
[max_peaks, max_locations] = findpeaks(temperature_with_trend,'MinPeakDistance',200);

%we can find local minima by 'inverting' the elements of the matrix(make the positive negative and the opposite) and search for the picks
temperature_inv = -temperature_with_trend;
[min_peaks, min_locations] = findpeaks(temperature_inv,'MinPeakDistance',200);


%plot horizontal lines in the first peaks
ground_truth_winter = max_peaks(1)
ground_truth_summer = -min_peaks(1)

%in this plot we just chose two points in the beggining of the metrics just
%to show the difference between the older and the recent metrics

%plots
figure(1)
%yline(y_min)
plot(temperature_with_trend)
hlinew = refline([0 ground_truth_winter])
hlinew.Color=[0 0 0.8];
hlines = refline([0 ground_truth_summer])
hlines.Color ='r'; 
hold on
plot(max_locations,temperature_with_trend(max_locations),'bo','MarkerFaceColor','b')
hold on  
plot(min_locations,temperature_with_trend(min_locations),'ro','MarkerFaceColor','r')
yticklabels({'0','2','4','8','10','12','14','16','16','18','20'})
xticklabels({'1970','1975','1980','1985','1990','1995','2000','2005','2010','2020'})
grid on
legend('See ice','Maximum Winter value','Lower wrinter value','Winter-peaks','Summer-peaks')
xlabel('Years')
ylabel('Sea Ice Extend[10^6 km^2]') 
title('Artic Sea Extend 1972-2019/2/13')

%%
%Periodogram
%We start our approach for finding the periodicity of the data with the non
%parametric techniques, in specific with the Periodogram
phi = periodogram(temperature_with_trend);

%windowed periodogram using hamming window
phi_w = periodogram(detrend(temperature_with_trend),hamming(length(temperature_with_trend)));

figure(2)
subplot(2,1,1)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
title('Periodogram method')
subplot(2,1,2)
plot(fVals,10*log10(phi_w(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
title('Periodogram method using data without trend')

%%
%Welch
%Using another one non-Parametric tecnhique we are taking the
%Welch estimator which is applyign a window in the autocorrelation
%function
%determine the length of the windows, the overlap and the length of the fft
window = 500;
noverlap = 100;
%determine the length because we need the same length as the frequencies
nfft = 16802;

%calculate psd
phi_welch = pwelch(temperature_with_trend,window,noverlap,nfft);

%plot
figure(3)
plot(fVals,10*log10(phi_welch(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
line([0.01 0.01],[0 150],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
title('Welch method using data with trend')
%%
%use Modified Yule Walker to find if the data are periodically 

%define the order of the ARMA model
m = 4;
n = 4;
M = 7;

%The modified Yule-Walker ARMA method for log data
%Here where we want to calcualte PSD we use the detrend command in order to
%vanish the trend from the data
[a,gamma]=mywarma(temperature,n,m,M);
%do the same procedure to the data with trend
[a_trend,gamma_trend]=mywarma(temperature_with_trend,n,m,M);
%H=freqz(b,a,256,'whole');
%calc phi
phi_yw = argamse(gamma,a,L);
%with trend
phi_yw_trend = argamse(gamma_trend,a_trend,L);


%plot
figure(4)
subplot(2,1,1)
plot(fVals,10*log10(phi_yw(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
line([0.005 0.005],[0 150],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
caption = sprintf('The modified Yule-Walker ARMA method (n = %d, m = %d, M = %d) applied to the data without trend',n,m,M);
title(caption, 'FontSize', 10); 
subplot(2,1,2)
plot(fVals,10*log10(phi_yw_trend(1:L/2)),'b','LineSmoothing','on','LineWidth',1);  
line([0.01 0.01],[0 150],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
caption = sprintf('The modified Yule-Walker ARMA method (n = %d, m = %d, M = %d) applied to the data with trend',n,m,M);
title(caption, 'FontSize', 10); 

%%
%in this chapter we are using Capon's method to search for periodicity in
%our data
%determine the length of the filter
filter_length=1;
%it is also know that Capon's method has the biggest overllaping, it is
%iterating point by point
%Capon
phi_capon_trend = capon(temperature_with_trend,filter_length,L);

phi_capon = capon(temperature,filter_length,L);

%plot
figure(5)
subplot(2,1,1)
plot(fVals,10*log10(phi_capon(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
line([0.01 0.01],[0 150],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
caption = sprintf('The modified Yule-Walker ARMA method (m = %d) applied to the data without trend',filter_length);
title(caption, 'FontSize', 10); 
subplot(2,1,2)
plot(fVals,10*log10(phi_capon_trend(1:L/2)),'b','LineSmoothing','on','LineWidth',1);  
line([0.01 0.01],[0 180],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
caption = sprintf('The modified Yule-Walker ARMA method (m = %d) applied to the data with trend',filter_length);
title(caption, 'FontSize', 10); 

%%
%RFB method by choosing the number of Slepian factors

%return the first K slepian filter
slepian_filters=2;
%Capon
phi_rfb_trend = rfb(temperature_with_trend,slepian_filters,L);
%plot
%Capon
phi_rfb = rfb(detrend(temperature_with_trend),slepian_filters,L);


figure(6)
subplot(2,1,1)
plot(fVals,10*log10(phi_rfb_trend(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
line([0.01 0.01],[0 180],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
caption = sprintf('The RFB method (Slepian filters = %d)',slepian_filters);
title(caption, 'FontSize', 10); subplot(2,1,1)
subplot(2,1,2)
plot(fVals,10*log10(phi_rfb(1:L/2)),'b','LineSmoothing','on','LineWidth',1);
line([0.01 0.01],[0 180],'Color','red')
xlabel('Frequency (Hz)')
ylabel('PSD [V**2/Hz]')
caption = sprintf('The RFB method (Slepian filters = %d)',slepian_filters);
title(caption, 'FontSize', 10);
