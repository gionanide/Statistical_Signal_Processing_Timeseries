#!usr/bin/python
from __future__ import division
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.patches as mpatches
from sklearn import metrics
from scipy.integrate import simps
import math

#this is the acs for exercise C1.13 and the question a x = [r(0).....r(M)00000....0000r(-M).....r(-1)]
def ACSa(M):
	acs = []
	for x in range(0,M+1):
		acs.append((10-abs(x))/10)
	for x in range(-M,0):
		acs.append((10-abs(x))/10)
	return acs

#this is used to initiate the other acs x = [r(-M)......r(-1)r(0)......r(M)00000.....0000]
def iACS(M):
	acs = []
	for x in range(-M,0):
		acs.append((10-abs(x))/10)
	for x in range(0,M+1):
		acs.append((10-abs(x))/10)
	return acs

#split the imaginary and the real part of the fft to make the plot and calculate tha area under the curve
def splitRI(myList):
	real = []
	im = []
	for x in range(len(myList)):
		real.append(np.real(myList[x]))
		im.append(np.imag(myList[x]))
	return real,im

#acs
def r(k):
	if (k>=-10 and k<=10):
		return ((10-abs(k))/10)
	else:
		return 0


def myFFT(x,k):
	return x*(math.cos((2*math.pi*k**2)/256) - 1j*math.sin((2*math.pi*k**2)/256))

#compute the fft of the sequence
fw = []
for y in range(-10,11):
	fw.append(myFFT(r(y),y))


#initialize the PSD
acs = ACSa(10)#make the sequence
#put zeros in the end of the autocovariance sequence
#for x in range(117):
#	acs.append(0)
#now we have to put zeros before the acs
#zerosBefore = []
#for x in range(118):
#	zerosBefore.append(0)
#acs = zerosBefore+acs
#print acs
#print len(acs)

acsF = np.fft.fft(acs,n=256)#compute the fft of the sequence
PSD = sum(acsF)#take the sum
print 'PSD without padding:',PSD,'\n'



#initialize the PSD with padding in the middle
acsM = ACSa(10)
#make the padding
for x in range(11,246):
	acsM.insert(x,0)

acsFF = np.fft.fft(acsM)
PSDFF = sum(acsFF)
print 'PSD with padding in the middle:',PSDFF,'\n'





#initialize the last PSD with padding in the end
acsMM = iACS(10)
#make the padding
for x in range(235):
	acsMM.append(0)
acsFFF = np.fft.fft(acsMM)
PSDFFF = sum(acsFFF)
print 'PSD with padding in the end:',PSDFFF,'\n'



errorMiddle = abs(PSD - PSDFF)
errorEnd = abs(PSD - PSDFFF)

if (errorMiddle < errorEnd):
	print 'Padding in the middle give us better approximation of the PSD with error:',errorMiddle
else:
	print 'Padding in the end give us better approximation of the PSD with error:',errorEnd

#plot the autocovariance sequencies


fig1 = plt.figure(1,figsize=(8,4))
plt.subplot(211)
green_patch = mpatches.Patch(color='red', label='Without padding')
plt.legend(handles=[green_patch])
plt.title('Without padding')
plt.xlabel('k', fontsize=10)
plt.ylabel('F[r(k])', fontsize=16)
plt.plot(acsF,linestyle='-',color='r')
plt.subplot(212)
blue_patch = mpatches.Patch(color='blue', label='Without padding')
plt.legend(handles=[blue_patch])
plt.xlabel('k', fontsize=10)
plt.ylabel('r(k)', fontsize=16)
plt.plot(acs,linestyle='-',color='b')

#realF,imF = splitRI(acsF)
#print simps(realF,imF)

fig2 = plt.figure(2,figsize=(8,4))
plt.subplot(211)
red_patch = mpatches.Patch(color='red', label='With padding in the middle')
plt.legend(handles=[red_patch])
plt.title('With padding in the middle')
plt.xlabel('k', fontsize=10)
plt.ylabel('F[r(k])', fontsize=16)
plt.plot(acsFF,linestyle='-',color='r')
plt.subplot(212)
blue_patch = mpatches.Patch(color='blue', label='With padding in the middle')
plt.legend(handles=[blue_patch])
plt.xlabel('k', fontsize=10)
plt.ylabel('r(k)', fontsize=16)
plt.plot(acsM,linestyle='-',color='b')

#realFF,imFF = splitRI(acsFF)
#print simps(realFF,imFF)


fig3 = plt.figure(3,figsize=(8,4))
plt.subplot(211)
red_patch = mpatches.Patch(color='red', label='With padding in the end')
plt.legend(handles=[red_patch])
plt.title('With padding in the end')
plt.xlabel('k', fontsize=10)
plt.ylabel('F[r(k])', fontsize=16)
plt.plot(acsFFF,linestyle='-',color='r')
plt.subplot(212)
blue_patch = mpatches.Patch(color='blue', label='With padding in the end')
plt.legend(handles=[blue_patch])
plt.xlabel('k', fontsize=10)
plt.ylabel('r(k)', fontsize=16)
plt.plot(acsMM,linestyle='-',color='b')

#realFFF,imFFF = splitRI(acsFFF)
#print simps(realFFF,imFFF)	


plt.show()

























