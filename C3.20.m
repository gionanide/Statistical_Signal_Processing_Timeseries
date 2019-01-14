%% optional clear;
clear;
clc;
close all;
%% load the dataset and set parameters
load C:\Users\MANOS\Desktop\lynxdata.mat

y=lynx;
fs=1;
L=256;
yl=log10(lynx);
%2 sets of parameters
  %n m M
i=[8 8 16;
   10 10 20;];
%% AR and ARMA
for k=1:2
%set parameters
n=i(k,1);
m=i(k,2);
M=i(k,3);


%AR Least squares
[a,sig2]=lsar(y,n);
H=freqz(1,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
figure;
subplot(4,2,1)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Least-Squares AR method lynxdata (n = %d)',n);
title(caption, 'FontSize', 10); 


%AR  Least squares for log data
[a,sig2]=lsar(yl,n);
H=freqz(1,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L; 
subplot(4,2,3)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Least-Squares AR method (log lynxdata) (n = %d)',n);
title(caption, 'FontSize', 10); 


%AR Yule-Walker method
[a,sig2]=yulewalker(y,n);
H=freqz(1,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(4,2,5)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Yule-Walker AR method lynxdata (n = %d)',n);
title(caption, 'FontSize', 10); 


%AR  Yule-Walker method for log data
[a,sig2]=yulewalker(yl,n);
H=freqz(1,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L; 
subplot(4,2,7)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Yule-Walker AR method (log lynxdata) (n = %d)',n);
title(caption, 'FontSize', 10); 



%%ARMA


%ARMA Least squares
[a,b,sig2]=lsarma(y,n,m,M);
H=freqz(b,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(4,2,2)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The two-stage Least-Squares ARMA method lynxdata (n = %d, m = %d, M = %d)',n,m,M);
title(caption, 'FontSize', 10);   


%ARMA  Least swuares for log data
[a,b,sig2]=lsarma(yl,n,m,M);
H=freqz(b,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(4,2,4)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The two-stage Least-Squares ARMA method (log lynxdata) (n = %d, m = %d, M = %d)',n,m,M);
title(caption, 'FontSize', 10); 


%The modified Yule-Walker ARMA method
[a,gamma]=mywarma(y,n,m,M);
%H=freqz(b,a,256,'whole');
%calc phi
phi = argamse(gamma,a,L);
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(4,2,6)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The modified Yule-Walker ARMA method lynxdata (n = %d, m = %d, M = %d)',n,m,M);
title(caption, 'FontSize', 10); 


%The modified Yule-Walker ARMA method for log data
[a,gamma]=mywarma(yl,n,m,M);
%H=freqz(b,a,256,'whole');
%calc phi
phi = argamse(gamma,a,L);
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(4,2,8)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The modified Yule-Walker ARMA method (log lynxdata) (n = %d, m = %d, M = %d)',n,m,M);
title(caption, 'FontSize', 10); 
end


%% optional clear;
%clear;
%clc;
%close all;
%%
%sunspoydata
load C:\Users\MANOS\Desktop\sunspotdata.mat

y=sunspot;
fs=1;
L=256;
yl=log10(sunspot);
%2 sets of parameters
  %n m M
i=[8 8 16;
   10 10 20;];
%% AR and ARMA
for k=1:2
%set parameters
n=i(k,1);
m=i(k,2);
M=i(k,3);


%AR Least squares
[a,sig2]=lsar(y,n);
H=freqz(1,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
figure;
subplot(2,2,1)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Least-Squares AR method sunspot data (n = %d)',n);
title(caption, 'FontSize', 10); 


%AR Yule-Walker method
[a,sig2]=yulewalker(y,n);
H=freqz(1,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(2,2,3)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Yule-Walker AR method sunspot data (n = %d)',n);
title(caption, 'FontSize', 10); 



%%ARMA


%ARMA Least squares
[a,b,sig2]=lsarma(y,n,m,M);
H=freqz(b,a,256,'whole');
%calc phi
phi=abs(H).^2*sig2;
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(2,2,2)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The two-stage Least-Squares ARMA method sunspot data (n = %d, m = %d, M = %d)',n,m,M);
title(caption, 'FontSize', 10);   


%The modified Yule-Walker ARMA method
[a,gamma]=mywarma(y,n,m,M);
%H=freqz(b,a,256,'whole');
%calc phi
phi = argamse(gamma,a,L);
%plot
fVals=fs*(0:L/2-1)/L;   
subplot(2,2,4)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The modified Yule-Walker ARMA method sunspot data (n = %d, m = %d, M = %d)',n,m,M);
title(caption, 'FontSize', 10); 
end
