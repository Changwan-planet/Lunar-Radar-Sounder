import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas import Series, DataFrame 

def make_patch_spines_invisible(ax):
    ax.set_frame_on(True)
    ax.patch.set_visible(False)
    for sp in ax.spines.values():
        sp.set_visible(False)

#PATH
input_path1="/home/changwan/Lunar-Radar-Sounder/Long_orbit/08831_60600_62399_HEADER_Long_orbit_LRS.txt"
input_path2="/home/changwan/Lunar-Radar-Sounder/Long_orbit/08831_60600_62399_B_SCAN_LRS.txt"
input_path3="/home/changwan/Lunar-Radar-Sounder/Long_orbit/08831_60600_62399_INTENSITY_LRS.txt"
#input_path4="/home/changwan/Lunar-Radar-Sounder/Long_orbit/INTENSITY_PROFILE2_output.txt"



#READ DATASET
data=np.loadtxt(input_path1)
#A_SCOPE=np.loadtxt(input_path1)
B_SCAN_IMAGE=np.loadtxt(input_path2)
INTENSITY=np.loadtxt(input_path3)
#INTENSITY_PROFILE2=np.loadtxt(input_path4)



######READ HEADER#######
ROW = np.linspace(0,(data.shape[0]-1),data.shape[0],dtype='int64')
COL = ['TI','SC_Lat','SC_Long','SC_Alt','H_offset','H_nadir','Start_range']
data_2=pd.DataFrame(data,index=ROW,columns=COL)

data_2.info()
print('\n')
print("data_2.shape=",data_2.shape)

print('\n')
print(data_2.head())
print(data_2.tail())
#########################



#B_SCAN_IMAGE.info()
print('\n')
print("B_SCAN_IMAGE.shape=",B_SCAN_IMAGE.shape)


#B_SCAN_IMAGE
fig, ax1=plt.subplots()

plt.title('item_name',fontsize=40)
plt.grid()


par1 = ax1.twiny()
par2 = ax1.twiny()


#B_SCAN_IMAGE_AXIS_X_DISTANCE
ax1_min=0
ax1_max=len(data_2)*0.075
ay1_min=1000*0.025
ay1_max=0

ax1.imshow(B_SCAN_IMAGE,'rainbow',extent=(ax1_min,ax1_max,ay1_min,ay1_max),aspect="auto")
ax1.set_xlabel('DISTANCE [KM]',fontsize=20)
ax1.set_ylabel('DEPTH [KM]',fontsize=20)
ax1.tick_params(which="both", width=2)
ax1.tick_params(which="major",length=7)
ax1.minorticks_on()
ax1.tick_params(which="minor",length=4,color='r')


#B_SCAN_IMAGE_AXIS_X2_LATITUDE

par1_min=data_2.loc[0,['SC_Lat']]               
par1_max=data_2.loc[len(data_2)-1,['SC_Lat']]
print(par1_min)
print(par1_max)
par1.axis([par1_min.item(),par1_max.item(),ay1_min,ay1_max])
par1.set_xlabel('LATITUDE [DEGREE]', fontsize=20)
par1.tick_params(which="both", width=2)
par1.tick_params(which="major",length=7)
par1.minorticks_on()
par1.tick_params(which="minor",length=4,color='r')

#B_SCAN_IMAGE_AXIS_X3_LONGTITUDEE
par2=plt.twiny()
par2.spines["top"].set_position(("axes",1.2))

make_patch_spines_invisible(par2)
par2.spines["top"].set_visible(True)

par2_min=data_2.loc[0,['SC_Long']]               
par2_max=data_2.loc[len(data_2)-1,['SC_Long']]
print(par2_min)
print(par2_max)
par2.axis([par2_min.item(),par2_max.item(),ay1_min,ay1_max])
par2.set_xlabel('LONGITUDEE [DEGREE]', fontsize=20)
par2.tick_params(which="both", width=2)
par2.tick_params(which="major",length=7)
par2.minorticks_on()
par2.tick_params(which="minor",length=4,color='r')



#INTESNTIY#
plt.figure()
plt.title('item_number',fontsize=40)

plt.grid()

plt.plot(INTENSITY,color='black')

xt=np.arange(0,1200,200)
plt.xticks(xt,(i*0.025 for i in xt),fontsize=10)

plt.ylabel("INTENSITY [dB]",fontsize=20)
plt.xlabel("Depth [km]",fontsize=20)
plt.tick_params(which="both", width=2)
plt.tick_params(which="major",length=7)
plt.minorticks_on()
plt.tick_params(which="minor",length=4,color='r')


plt.show()



