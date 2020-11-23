#
############################
#
#Author:Changwan Sun
#Date: June 24, 2020
#Email: tjsckddhks@gmail.com
#
import numpy as np
#
#
#Initialization
###########################
###########################

#Digital Terrain Model (DTM)
###########################
#DTM=np.zeros((12288,12288))
DTM_CUT=np.zeros((81,676))
###########################

#Path
############################################
input_path="TotalDTM.txt"
#output_path="DTM_CUT.txt"
output_path2="DTM_CUT2.txt"
############################################

#Loading
########################################################### 
#                 
#          Matrix (81 x 676)
#
#       (4131,7305)...(4131,7980)
#
#            :             :
#            :             :
#
#	    (4212,7305)...(4212,7980)	   
###########################################################
# Always keep in mind that Numpy array strart from [0][0] 2d array
###########################################################
DTM_CUT=np.genfromtxt(input_path,dtype=np.int,skip_header=4132,skip_footer=12288-4214+1, usecols=range(7305,7981))
############################################################

#Cutting
############################################################
#	row: 4132...4212
#	col: 7305...7980

# for a in range(4132,4213):   # consider to be x-4132=81. (0,0)...(80,0) 
#  for b in range(7305,7981): # consider to be x-7305=676. (0,0)...(0,675)
#   c=a-4132
#   d=b-7305	   
#   DTM_CUT[c][d]=DTM[a][b]  
###########################################################

#Writing
##################################
#np.savetxt(output_path,DTM_CUT,fmt="%i")
np.savetxt(output_path2,DTM_CUT,fmt="%i")
#################################
print("DTM_CUT shape",np.shape(DTM_CUT))
print('END')
