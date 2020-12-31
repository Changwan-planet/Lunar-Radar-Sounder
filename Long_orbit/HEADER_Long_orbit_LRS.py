from  pandas import Series, DataFrame #Local Namespace import
from IPython.display import display
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

path="HEADER_Long_orbit_LRS.txt"
#path2="B_SCAN_LRS.txt"


#Reading data
data=np.loadtxt(path)
#data2=np.loadtxt(path2)



#DataFrame
ROW=np.linspace(0,(data.shape[0]-1),data.shape[0],dtype='int64')
COL= ['TI','SC_Lat','SC_Long','SC_Alt','H_offset','H_nadir','Start_range']
data_2=pd.DataFrame(data,index=ROW,columns=COL)
#display(data)

#data2=data.apply(pd.to_numeric)

#Data information
print("***data_2.info()***")
ata_2.info()

print('\n')
print("data_2.shape=",data_2.shape)

#print('\n')
#print(data_2.index)

#print('\n')
#print(data_2.columns)

print('\n')
#print(data_2.loc['SC_Long'])


#data2.loc[['SC_Long']]=data2.loc[['SC_Long']]-360
#data2.loc[['H_nadir']]=data2.loc[['H_nadir']]-93
#data2.loc[['H_nadir']]=data2.loc[['H_nadir']]-data2.loc[['SC_Alt']]

#print(data_2.loc['SC_Long',:])
print('\n')
print(data_2.head())

#print('\n')
#print(data_2.loc[:,['SC_Lat']])


#Particular column
Along_track=1000
print('\n')
print("Along_track  =",Along_track*0.075,"km")


#GRAPH

#SC_Lat
plt.subplot(2,2,3)
plt.plot(data_2.loc[:,['SC_Lat']],color='black',label='SC_Lat')
xt=np.arange(0,2200,200)
plt.xticks(xt,(i*0.075 for i in xt),fontsize=10)
plt.grid()
plt.minorticks_on()
plt.tick_params(which="both",width=2)
plt.tick_params(which="major",length=7)
plt.tick_params(which="minor",length=4,color='r')
plt.legend()
plt.title("SC_Lat")


#SC_Alt
plt.subplot(2,2,2)
plt.plot(data_2.loc[:,['SC_Alt']],color='red',label='SC_Alt')
xt=np.arange(0,2200,200)
plt.xticks(xt,(i*0.075 for i in xt),fontsize=10)
plt.grid()
plt.minorticks_on()
plt.tick_params(which="both",width=2)
plt.tick_params(which="major",length=7)
plt.tick_params(which="minor",length=4,color='r')
plt.legend()
plt.title("SC_Alt")


#Start_Range
plt.subplot(2,2,4)
plt.plot(data_2.loc[:,['Start_range']],color='orange',label='Start_range')
xt=np.arange(0,2200,200)
plt.xticks(xt,(i*0.075 for i in xt),fontsize=10)
plt.grid()
plt.minorticks_on()
plt.tick_params(which="both",width=2)
plt.tick_params(which="major",length=7)
plt.tick_params(which="minor",length=4,color='r')
plt.legend()
plt.title("Start_range")


#H_nadir
plt.subplot(2,2,1)
plt.plot(data_2.loc[:,['H_nadir']],color='b',label="H_nadir")
xt=np.arange(0,2200,200)
plt.xticks(xt,(i*0.075 for i in xt),fontsize=10)
plt.grid()
plt.minorticks_on()
plt.tick_params(which="both",width=2)
plt.tick_params(which="major",length=7)
plt.tick_params(which="minor",length=4,color='r')
plt.legend()
plt.title("H_nadir")

plt.show()

#print(data['SC_Lat'])
#print(len(data))

#data3=data2.HEADER.split(', ')

#print(data2)

#bins= range(len(data)/6)
#print(bins)
#print(data['HEADER'])
#print(data)


#print(data['SC_Alt'])

#print(data.loc[:,['SC_Alt']])

#print(data.columns)
#print(data.shape)

#data_ROWS = data.loc[:,['b']]
#print(ROWS)
#print("ROWS")
#print(ROWS)
#print("")
#print("ROWS.dtypes")
#print(ROWS.dtypes)

#print("ROWS.dtype = ",ROWS.dtypes)
#print("")
#print("***************")
#print("")
#data['b'].astype(str).astype(int)

#pd.to_numeric(ROWS)
#data = data.apply(pd.to_numeric,errors='coerce')

#print(data)
 
#ROWS = data.loc[[18],['b']]
#ROWS = ROWS.astype(int)
#print("ROWS")

#data['b']=data['b'].atypes(str).atypes(int)
#print(data['b'])

#print("")
#print("ROWS.dtypes ")
#print(data['b'].dtypes)

#print("****
