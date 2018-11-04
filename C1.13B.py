#!usr/bin/python
from __future__ import division
import math
import numpy as np

def myFFT(w,r,k):
	return r*(math.cos(w*k) - 1j*math.sin(w*k)/256)

def ACSa(M):
	acs = []
	for x in range(-M,M+1):
		acs.append((r(x)))
	return acs

#determine autocovariance sequence
def r(k):
	if (k>=-10 and k<=10):
		return ((10-abs(k))/10)
	else:
		return 0

#initialize f(w) with variable w
def main():
	fwSamples = [((2*k*math.pi)/256) for k in range(0,256)]
	#print fwSamples
	acs = ACSa(10)
	#print acs
	yf = []
	#for every value of the fw samples
	for x in range(len(fwSamples)):
		#run all the acs in order to find the sum 
		temp = 0
		for y in range(len(acs)):
			#take the sum of every ft of every element in the acs
			#fwSamples represents the w in the spectrum of [0,255], acs[y] represents the element of the ACS,
			#x represents the k in the range of [0,255]
			temp = temp + myFFT(fwSamples[x],acs[y],x)
		yf.append(temp)
	#sum of the inverse fourier transform of the yf vector
	siftyf = sum(np.fft.ifft(yf))
	#sum of the acs
	sacs = sum(acs)	
	print 'Sum of the inverse fourier transform of the yf where yf = [f(0)....f((L-1*2p)/L)] vector:',siftyf,'\n'
	print 'Sum of the acs:',sacs,'\n'
	print 'We verify that y closely approximates the ACS.'

		


main()
