#!usr/bin/python
from __future__ import division
import numpy as np
import math
import cmath
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.patches as mpatches

#find the autocavariance for M=10 and calculate the PSD from the autocavariance sequence
#this is for exercise C1.13 and the question c
def r(k):
	if (k>=0):
		return (5.2631578947*(0.9**(k)))
			#*cmath.exp((-1j*2*cmath.pi*k)/256)
	else:
		return (5.2631578947*(0.9**(-k)))
			#*cmath.exp((-1j*2*cmath.pi*k)/256)



#question c as well
def ACS(M):
	acs = [] # autocovariance sequence
	for x in range(0,M+1):
		acs.append(r(x))
	for x in range(-M,0):
		acs.append(r(x))
	return acs



def PSD():
	
	acs = ACS(10)
	#print 'Autocovariance sequence:',acs,'\n'
	
	#calculate the fft of this sequence and then take the sum of the components
	#the PSD from the definition as the sum of the ft of the autocavariance sequence components
	acsF = np.fft.fft(acs,n=256)
	PSD = sum(acsF)
	print 'Calculated PSD with no padding:',PSD,'\n'
	#in case we want to take only the real part of the numbernp.real(sum(acsF))

	#initialization
	acsM = ACS(10)
	for x in range(11,246):
		acsM.insert(x,0)
	
	#print 'Autocovariance sequence with padding in the middle:',acsM,'\n'

	#calculate the PSD of the new acs
	acsPF = np.fft.fft(acsM)
	PSDM = sum(acsPF)
	print 'Calculated PSD with padding and M = 10:',PSDM,'\n'

	print 'Error between PSD and PSD with padding and M = 10:',abs(PSD - PSDM),'\n'


	#now try a better approximation with M = 127
	acsMM = ACS(127)
	#add padding in the middle before fft
	acsMM.insert(128,0)
	#fft acsMM
	acsFF = np.fft.fft(acsMM)
	PSDMM = sum(acsFF)
	print 'Calculated PSD with padding and M = 127:',PSDMM,'\n'

	print 'Error between PSD and PSD with padding and M = 127:',abs(PSD - PSDMM),'\n'

	print 'Conclusion:\n'
	if (abs(PSD - PSDM)>abs(PSD - PSDMM)):
		print 'using M = 127 gave us a better approximation but not much better'
	else:
		print 'using M = 10 gave us a better approximation but not much better'
		
	
	fig1 = plt.figure(figsize=(8,4))
	green_patch = mpatches.Patch(color='green', label='Without padding')
	plt.legend(handles=[green_patch])
	plt.plot(acs,linestyle='-',color='g')

	fig1 = plt.figure(figsize=(8,4))
	blue_patch = mpatches.Patch(color='blue', label='With padding and M = 10')
	plt.legend(handles=[blue_patch])
	plt.plot(acsM,linestyle='-',color='b')

	fig1 = plt.figure(figsize=(8,4))
	red_patch = mpatches.Patch(color='red', label='With padding and M = 127')
	plt.legend(handles=[red_patch])
	plt.plot(acsMM,linestyle='-',color='r')

	#plt.show()

PSD()	





