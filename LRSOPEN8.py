import numpy as np
import math
import matplotlib.pyplot as plt

#import pandas as pd
#from  scipy.optimize import curve_fit

#PATH
#input_path="LRS_SAR05KM_C_30S_322642E.tbl"
#input_path="LRS_SAR05KM_C_20S_351584E.tbl"
#input_path="LRS_SAR05KM_C_30S_322165E.tbl"
#input_path="LRS_SAR05KM_C_00N_015204E.tbl"

common_path="LRS_SAR05KM_C_"
item_number="60N_002339E"
ext1=".tbl"
ext2=".txt"
ext3=".lbl"
nput_path=common_path+item_number+ext1
output_path="HEADER_"+item_number+ext2
Label_path=common_path+item_number+ext3

#READING ROWS FROM LABEL FILE
#Label
with open(Label_path,"r") as f:
    PARSING=f.read(684)
    ROWS=f.read(4)
    ROWS=int(ROWS)

print(ROWS)

#HEADER
SC_Lat=np.zeros(ROWS)
SC_Long=np.zeros(ROWS)
SC_Alt=np.zeros(ROWS)
Range0=np.zeros(ROWS)
Start_Range=np.zeros(ROWS)
Maxlocation=np.zeros(ROWS)
H_nadir=np.zeros(ROWS)

#DATA
SAR_IMAGE_REAL=np.zeros((1000,1))
SAR_IMAGE_IMAG=np.zeros((1000,1))
SAR_IMAGE_INTENSITY=np.zeros((1000,1))
SAR_B_SCAN_IMAGE=np.zeros((1000,ROWS))
a,b,c,i=0,0,0,0

with open(input_path, "rb") as f:
 for i in range(ROWS):  # USE THE VALUE OF FILE_RECODRS IN THE LABEL DATA.:
  Spacecraft_data=f.read(29)

#Header 
  Header1=f.read(4)
  Header2=f.read(4)
  Header3=f.read(4)
  Header4=f.read(4)

  SC_Lat[i]=np.frombuffer(Header1,dtype=">f4")
  SC_Long[i]=np.frombuffer(Header2,dtype=">f4")
  SC_Alt[i]=np.frombuffer(Header3,dtype=">f4")
  Range0[i]=np.frombuffer(Header4,dtype=">f4")
  
  f.read(10)
  
  for a in range(1000):
   data1=f.read(4)   
   #print(data1)
   SAR_IMAGE_REAL[a][0]=np.frombuffer(data1,dtype=">f4") 
   #print(SAR_IMAGE_REAL[a][0])
  
  for b in range(1000):
   data2=f.read(4)   
   SAR_IMAGE_IMAG[b][0]=np.frombuffer(data2,dtype=">f4")

  for c in range(1000):
   SAR_IMAGE_INTENSITY[c][0]=20*math.log10(math.sqrt(SAR_IMAGE_REAL[c][0]**2+SAR_IMAGE_IMAG[c][0]**2))    
   #print(SAR_IMAGE_INTENSITY[c][0])
   #print(SAR_IMAGE_REAL[0][0])
   SAR_B_SCAN_IMAGE[c][i]=SAR_IMAGE_INTENSITY[c][0]
   #print(np.argmax(SAR_IMAGE_INTENSITY))
   #n=1
   #print(n)
   #n=n+1
  Maxlocation[i]=25*np.argmax(SAR_IMAGE_INTENSITY)

#OUTPUT
Start_Range = SC_Alt-Range0
H_nadir=Start_Range+(Maxlocation/1000)
#print("H_nadir=",H_nadir)
np.savetxt(output_path,(SC_Lat,SC_Long,SC_Alt,Range0,Start_Range,H_nadir),fmt='%f', delimiter=' ')       
   
#GRAPH
#"""
plt.figure(figsize=(15,8))
plt.imshow(SAR_B_SCAN_IMAGE,'gray')

#xt=np.arange(0,ROWS,200)
xt=np.arange(0,2200,200)
yt=np.arange(0,1100,100)

plt.xticks(xt,(i*0.075 for i in xt),fontsize=20)
plt.yticks(yt,(i*0.025 for i in yt),fontsize=20)
plt.minorticks_on()

plt.tick_params(which="both", width=2)
plt.tick_params(which="major",length=7)
plt.tick_params(which="minor",length=4,color='r')

plt.xlabel("Along_track [km]",fontsize=20)
plt.ylabel("Depth [km]",fontsize=20)

plt.title(item_number1,fontsize=60)


#plt.imshow(SAR_B_SCAN_IMAGE)
#"""

#Curve fitting
"""
x=np.linspace(0,2000,ROWS)

CF1=np.polyfit(x,H_nadir,40)
CF2=np.poly1d(CF1)

#plt.plot(H_nadir)
#plt.scatter(x,H_nadir, marker='.')
#plt.plot(x,H_nadir, linewidth=2)
#plt.plot(x,func(x,*popt),color='red',linewidth=2)
#plt.legend(['Original', 'Best Fit'], loc=2)


plt.plot(x,H_nadir,color='b',label='original')
plt.plot(x,CF2(x),color='r',label='polyfit')
plt.grid()
plt.legend


#plt.plot(Range0,'r')
#plt.plot(SAR_IMAGE_INTENSITY)
#plt.plot(Start_Range)
#plt.plot(Maxlocation)
"""
plt.show()

      
