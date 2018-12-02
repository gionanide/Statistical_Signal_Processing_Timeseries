#!usr/bin/python
from __future__ import division
from scipy import signal
import math
import numpy as np
import matplotlib.pyplot as plt

'''In this exercise we are going to study the effect or zero padding has on the periodogram. As we already know is that adding zeros
it doesn't give us gain in frequency resolution, it increases the smoothness and we can better characterize the signal.

define the input sequence as y and then as phi we define the periodogram for given frequency
	y(t,N) 10*np.sin(0.2*math.pi*t) + 5np.sin((0.2 + 1/N)*2*math.pi*t) + e(t), e(t) is white noise'''

#define the phi function as given in the exercise, N is fixed, and w = (2*math.pi*k/N)
#in order to calculate the actuall PSD and compare it with the estimations of the periodogram
def phi(k,N=64):
	return (50*math.pi*(signal.unit_impulse((2*math.pi*k)/N - 0.2*2*math.pi) + signal.unit_impulse((2*math.pi*k)/N + 0.2*2*math.pi)) + \
		12.5*math.pi*(signal.unit_impulse((2*math.pi*k)/N - (0.2 + 1/N)*2*math.pi) + \
			signal.unit_impulse((2*math.pi*k)/N + (0.2 + 1/N)*2*math.pi)) + 1)

#define the input signal
def y(t,e,N=64):
	return (10*np.sin(0.2*math.pi*t) + 5*np.sin((0.2 + 1/N)*2*math.pi*t) + e[t])


#first we have to define the Gaussian white noise with variance 1 and 0 mean
def whiteNoise():
	wgn = np.random.normal(0,1,64) # white gaussian noise, with 64 elements from 0 to N-1
	return wgn


def fp(N):
	#now in order to make the frequency array w = 2*pi*k/N for k = 0,....N-1
	f = []
	for  k in range(0,N):
		f.append((2*math.pi*k)/N)
	return f

#make the padding
def zeroPadding(signal,length_of_padding):

	#apply zero padding in the request length
	for x in range(length_of_padding):
		signal.append(0)

	return signal

def main():

	#generate the random white Gaussian noise
	e = whiteNoise()

	#generate the signal for t = 0,.....,N-1
	signal = []
	N = 64 # the initial points in time domain
	for t in range(0,N):
		signal.append(y(t,e))

	

	#calculate the psd plot by applying fft to the sequence of the signal
	psd = np.fft.fft(signal)
	
	#make the frequency array
	fxx = fp(len(signal))

	print len(signal)
	
	#calculate psd
	print 'PSD without padding:', (np.real(sum(psd)/len(psd)))

	signal1 = zeroPadding(signal,N)
	psd1 = np.fft.fft(signal1)

	print len(signal1)
	
	#calculate psd
	print 'PSD with padding N:', (np.real(sum(psd1)/len(psd1)))

	signal2 = zeroPadding(signal,3*N)
	psd2 = np.fft.fft(signal2)

	print len(signal2)

	#calculate psd
	print 'PSD with padding 3N:', (np.real(sum(psd2)/len(psd2)))

	signal3 = zeroPadding(signal,5*N)
	psd3 = np.fft.fft(signal3)

	print len(signal3)

	#calculate psd
	print 'PSD with padding 5N:', (np.real(sum(psd3)/len(psd3)))

	signal4 = zeroPadding(signal,7*N)
	psd4 = np.fft.fft(signal4)

	print len(signal4)

	#calculate psd
	print 'PSD with padding 7N:', (np.real(sum(psd4)/len(psd4)))
	

	#plots
	fig1 = plt.figure(1,figsize=(12,6))
	plt.plot(e,color='blue')
	plt.xlabel('Time (s)')
	plt.ylabel('Amplitude')
	plt.title('white Gaussian noise e(t)')
	fig1.savefig('white_noise.png')

	fig2 = plt.figure(2,figsize=(12,6))
	plt.plot(signal,color='blue')
	plt.xlabel('Time (s)')
	plt.ylabel('y(t)')
	plt.title('Signal with padding 7N')
	#fig2.savefig('signal_padding_7N.png')

	fig3 = plt.figure(3,figsize=(12,6))
	plt.plot(fxx,psd,color='blue')
	plt.xlabel('Frequency (Hz)')
	plt.ylabel('PSD')
	plt.title('Periodogram of y(t) without padding')
	#fig3.savefig('periodoram_without_padding.png')

	#because psd is symmetric, plot only the 0-pi part because pi to 2*pi is the same
	fig4 = plt.figure(4,figsize=(12,6))
	plt.plot(fxx[:int(len(signal)/2)],psd[:int(len(signal)/2)],color='blue')
	plt.xlabel('Frequency (Hz)')
	plt.ylabel('PSD')
	plt.title('Periodogram of y(t) with padding 7N')
	#fig4.savefig('periodoram_wit_padding_7N_half.png')
	

	plt.show()

main()
	
