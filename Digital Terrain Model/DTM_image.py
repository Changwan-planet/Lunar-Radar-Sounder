#
############################
#
#
#
#
import numpy as np
import matplotlib.pyplot as plt

#Initialization
###########################

###########################

#Digital Terrain Model (DTM)
###########################
DTM=np.zeros((12288,12288))
###########################

#DTM_CUT
##########################
DTM_CUT=np.zeros((676,81))
#########################

#Path
############################################
input_path="DTM_CUT.txt"
#input_path="TotalDTM.txt"
############################################

#Loading
###########################################
DTM_CUT=np.loadtxt(input_path,dtype=np.int)
###########################################

plt.imshow(DTM_CUT)
plt.show()
	
print("END")



