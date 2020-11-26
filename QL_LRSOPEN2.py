import numpy as np
import math
import matplotlib.pyplot as plt

#PATH
common_path="/home/changwan/Lunar-Radar-Sounder/"

#item_number1="QL_05km_08996_89600_92099.dat"  #SFTP_6 COLUMNS:5600
#item_number1="QL_05km_08878_89000_90199.dat"#SFTP_2 COLUMNS:1000
#item_number1="QL_05km_08913_71200_72499.dat"#SFTP_3 COLUMNS:1000
#item_number1="QL_05km_08842_92600_94899.dat"#SFTP_1 COLUMNS:1000
#item_number1="QL_05km_08972_78800_81299.dat" #SFTP_5 COLUMNS:1000
#item_number1="QL_05km_09019_97800_99999.dat" #SFTP_6 COLUMNS:1000
#item_number1="QL_05km_09019_90700_93199.dat"  #STFP_6 COLUMNS:1000
#item_number1="QL_05km_08829_40700_45499.dat" #SFTP_1 COLUMNS: 1000
#item_number1="QL_05km_08841_23400_25799.dat" #SFTP_1 COLUMNS: 1000
#item_number1="QL_05km_08888_40700_42999.dat" #SFTP_2 COLUMNS: 1000
#item_number1="QL_05km_09018_35000_36899.dat" #SFTP_6 COLUMNS: 1000
#item_number1="QL_05km_09041_94500_96999.dat" #SFTP_6 COLUMNS: 1000
#item_number1="QL_05km_08888_33600_35999.dat" #SFTP_2 COLUMNS: 1000
#item_number1="QL_05km_08900_17300_19799.dat" #SFTP_2 COLUMNS: 1000
item_number1="QL_05km_09041_87400_89899.dat"  #SFTP_6 COLUMNS: 1000
input_path=common_path+item_number1

#Label
ROWS=753
COLUMNS=1000

#HEADER, intialization
TI=np.zeros(COLUMNS,dtype=np.int)
Lat_0=np.zeros(COLUMNS,dtype=np.int)
Long_0=np.zeros(COLUMNS) 
H_datum_0=np.zeros(COLUMNS)
H_nadir_0=np.zeros(COLUMNS) 
Elv=np.zeros(COLUMNS)
	
#DATA
IMAGE_REAL_POWER=np.zeros((ROWS,1))
SAR_B_SCAN_IMAGE=np.zeros((ROWS,COLUMNS))
a,b,c,i=0,0,0,0



logic_1=input("Do you want to indicate QL_LRS data in the particular latitude?(y/n)")

if logic_1 == "y" :
  logic_2=input("Type certain latitude that you want, please")
  logic_2=int(logic_2)

with open(input_path, "rb") as f:
 for i in range(COLUMNS):

#Header 
  Header0=f.read(4)   #This is the key. The 4 byte. Empty space. 
  Header1=f.read(4)
  Header2=f.read(4)
  Header3=f.read(4)
  Header4=f.read(4)
  Header5=f.read(4)

  TI[i]=np.frombuffer(Header1,dtype="i4")
  Lat_0[i]=np.frombuffer(Header2,dtype="<f4")
  Long_0[i]=np.frombuffer(Header3,dtype="<f4")
  H_datum_0[i]=np.frombuffer(Header4,dtype="<f4")
  H_nadir_0[i]=np.frombuffer(Header5,dtype="<f4")
  #print("H_nadir_0=",H_nadir_0[i])
  Elv[i]=H_datum_0[i]-H_nadir_0[i]
  Att=(H_nadir_0[i]/100.0e3)*(H_nadir_0[i]/100.0e3)  #Normalization
  #The Valus is the power so that we need square. 

  #print(Lat_0[i])


  if logic_2<0:

   if Lat_0[i]-0.1<logic_2 and logic_2<Lat_0[i]+0.5:
    print("TI[",i,"]=",TI[i]) 
    print("Lat_[",i,"]=",float(Lat_0[i])) 
   
  elif logic_2>0:

   if Lat_0[i]-0.5<logic_2 and logic_2<Lat_0[i]+1.0:
    print("TI[",i,"]=",TI[i]) 
    print("Lat_[",i,"]=",float(Lat_0[i])) 


  for a in range(ROWS):	
   data1=f.read(4)	  
   
   IMAGE_REAL_POWER[a][0]=np.frombuffer(data1,dtype="<f4")
   IMAGE_REAL_POWER[a][0]=IMAGE_REAL_POWER[a][0]*Att

  for c in range(ROWS):
   
  #IMAGE_REAL_POWER[c][0]=10.0*np.log10(IMAGE_REAL_POWER[c][0])   
   IMAGE_REAL_POWER[c][0]=3.0*(10.0*(np.log10(IMAGE_REAL_POWER[c][0])))+20

   #int(IMAGE_REAL_POWER[c][0])
   #IMAGE_REAL_POWER[c][0]=2.0*IMAGE_REAL_POWER[c][0]
   SAR_B_SCAN_IMAGE[c][i]=IMAGE_REAL_POWER[c][0]


#GRAPH

plt.figure(figsize=(15,8))
plt.imshow(SAR_B_SCAN_IMAGE,'gist_rainbow_r')

#xt=np.arange(0,ROWS,200)
xt=np.arange(0,3200,200)
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


#test
#plt.plot(TI)

plt.show()

      
