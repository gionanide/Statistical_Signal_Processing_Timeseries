%% optional clear;
clear;
clc;
close all;
%% load the dataset and set parameters
load C:\Users\MANOS\Desktop\lynxdata.mat
load C:\Users\MANOS\Desktop\sunspotdata.mat

y=lynx;
ys=sunspot;
fs=1;
L=256;
yl=log10(lynx);

%2 sets of parameters
k=2
%Capon
phi=rfb(yl,k,L)
%plot
fVals=fs*(0:L/2-1)/L;   
figure(1)
plot(fVals,10*log10(phi(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The RFB method lynx data');
title(caption, 'FontSize', 10); 


m=50
%Capon
phis=capon(yl,m,L)
%plot
fVals=fs*(0:L/2-1)/L;   
figure(2)
plot(fVals,10*log10(phis(1:L/2)),'b','LineSmoothing','on','LineWidth',1);         
caption = sprintf('The Capon method sunspot data');
title(caption, 'FontSize', 10); 

