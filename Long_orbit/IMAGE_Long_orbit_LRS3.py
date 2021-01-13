import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas import Series, DataFrame 
from mpl_toolkits.mplot3d import Axes3D
from skimage import data, img_as_float
from skimage import exposure
#from mpl_toolkits.basemap import Basemap
from irfpy.moon import moon_map

#+++++++++++++DO NOT REMOVE++++++++++++++++
#++++++++function for three X axis+++++++++
def make_patch_spines_invisible(ax):
    ax.set_frame_on(True)
    ax.patch.set_visible(False)
    for sp in ax.spines.values():
        sp.set_visible(False)
#++++++++++++++++++++++++++++++++++++++++++


#PATH
input_path1="/home/changwan/Lunar-Radar-Sounder/Long_orbit/08878_89000_90199_HEADER_Long_orbit_LRS.txt"
input_path2="/home/changwan/Lunar-Radar-Sounder/Long_orbit/08878_89000_90199_B_SCAN_LRS.txt"
input_path3="/home/changwan/Lunar-Radar-Sounder/Long_orbit/08878_89000_90199_INTENSITY_LRS.txt"
#input_path4="/home/changwan/Lunar-Radar-Sounder/Long_orbit/INTENSITY_PROFILE2_output.txt"

#READ DATASET
LRS=np.loadtxt(input_path1)
#A_SCOPE=np.loadtxt(input_path1)
B_SCAN_IMAGE=np.loadtxt(input_path2)
INTENSITY=np.loadtxt(input_path3)
#INTENSITY_PROFILE2=np.loadtxt(input_path4)

######READ HEADER#######
ROW = np.linspace(0,(LRS.shape[0]-1),LRS.shape[0],dtype='int64')
COL = ['TI','SC_Lat','SC_Long','SC_Alt','H_offset','H_nadir','Start_range']
data_2=pd.DataFrame(LRS,index=ROW,columns=COL)

#data_2.info()
#print('\n')
#print("data_2.shape=",data_2.shape)

#print('\n')
print(data_2.head())
print(data_2.tail())
#########################

#B_SCAN_IMAGE.info()
#print('\n')
#print("B_SCAN_IMAGE.shape=",B_SCAN_IMAGE.shape)

#ORIBT_CHECK (LONGITUDE)
long_min = -180
long_max =  180
lat_min  = -90
lat_max  =  90

map = moon_map.MoonMapSmall()
#plt.imshow(map.image,extent=[long_min,long_max,lat_min,lat_max],aspect="auto")
plt.imshow(map.image,extent=[long_min,long_max,lat_min,lat_max])
plt.scatter(data_2.loc[:,['SC_Long']],data_2.loc[:,['SC_Lat']],c="lime", marker='.')
plt.grid()


#B_SCAN_IMAGE
fig, host=plt.subplots(figsize=(15,18))

plt.title('item_name',fontsize=40)
plt.grid()

par1 = host.twiny()
par2 = host.twiny()

par2.spines["top"].set_position(("axes",1.1))
make_patch_spines_invisible(par2)
par2.spines["top"].set_visible(True)


par1_min=data_2.loc[0,['SC_Lat']]               
par1_max=data_2.loc[len(data_2)-1,['SC_Lat']]
par2_min=data_2.loc[0,['SC_Long']]               
par2_max=data_2.loc[len(data_2)-1,['SC_Long']]


ax1_min=0
ax1_max=len(data_2)*0.075
ay1_min=1000*0.025
ay1_max=0

#host.imshow(B_SCAN_IMAGE,'rainbow', aspect="auto")
#host.imshow(B_SCAN_IMAGE,'rainbow', aspect="auto")
host.imshow(B_SCAN_IMAGE,extent=(ax1_min,ax1_max,ay1_min,ay1_max),aspect="auto")


#B_SCAN_IMAGE_LIMIT
#host.set_ylim(ay1_min,ay1_max)
host.set_xlim(ax1_min,ax1_max)
par1.set_xlim(par1_min.item(),par1_max.item())
par2.set_xlim(par2_min.item(),par2_max.item())

print(par2_min.item())
print(par2_max.item())

#B_SCAN_IMAGE_LABEL

host.set_ylabel('DEPTH [KM]', fontsize=15)
host.set_xlabel('DISTANCE [KM]', fontsize=15)
par1.set_xlabel('LATITUDE [DEGREE]', fontsize=15)
par2.set_xlabel('LONGITUDEE [DEGREE]', fontsize=15)

#B_SCAN_IMAGE_TICK
host.tick_params(which="both", width=2)
host.tick_params(which="major",length=7)
par1.tick_params(which="both", width=2)
par1.tick_params(which="major",length=7)
par2.tick_params(which="both", width=2)
par2.tick_params(which="major",length=7)

#B_SCAN_IMAGE_MINORTICK
host.minorticks_on()
host.tick_params(which="minor",length=4,color='r')
par1.minorticks_on()
par1.tick_params(which="minor",length=4,color='r')
par2.minorticks_on()
par2.tick_params(which="minor",length=4,color='r')


"""
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
"""

plt.show()



