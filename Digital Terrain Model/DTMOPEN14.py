#
#############################
#Author: Changwan Sun
#Date: June, 24, 2020
#Email: tjsckddhks@mgmail.com
#############################
#
import numpy as np


#Initialization
###########################
a,b,p=0,0,0
###########################

#Digital Terrain Model (DTM)
###########################
DTM=np.zeros((12288,12288))
###########################

#Path
############################################
input_path="DTM_MAP_02_N15E309N12E312SC.dtm"
output_path="TotalDTM.txt"
############################################

with open(input_path,"rb") as f1:

#Passing Label 
#########################
 f1.seek(3161,1)
#########################  

#DTM_Read_Loop 
############################################################
 for a in range(12288):
  for b in range(12288):
    
   p=f1.read(2)
   DTM[a][b]=int.from_bytes(p,'little',signed=True)        
###########################################################

#Writing
######################################   
np.savetxt(output_path,DTM, fmt="%i")
######################################

print("DTM,shape",np.shape(DTM))
print('END')


