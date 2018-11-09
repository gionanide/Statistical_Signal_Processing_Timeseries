#!usr/bin/python
import math
import numpy as np
import matplotlib.pyplot as plt

def r(k):                               ###ACS
    if k in range(-10,10):
        return (10-math.fabs(k))/10
    else:
        return 0

x=[]                        ###vector x
for k in range(0,11):
    x.append(r(k))
for k in range(11,256-10):
    x.append(0)
for k in range(0,10):
    x.append(r(k-10))
x=np.array(x)

xf=np.fft.fft(x)
xf1=np.fft.fftshift(xf)
ixf=np.fft.ifft(xf)
ixf1=np.fft.fftshift(ixf)

w1=np.arange(0.0,256,1)
w = [-math.pi + 2*math.pi*x/255 for x in w1]

plt.plot(w,xf1,'--')       ### xf1=shift of fft
plt.show()

t1=np.arange(0,256,1)
t = [x-117 for x in t1]

plt.stem(t,ixf1)
plt.show()
