**Lunar Radar Sounder**

We created and used these codes to find a lunar lava tube in the north of the Rima Galilaei on the Moon. Theses codes are written by Fortran 90 and divided into the two groups: Digital Terrain Modeal (DTM) and Lunar Radar Sounder (LRS). We obtained DTM datasets from the SELENE Data archive (https://darts.isas.jaxa.jp/planet/pdap/selene/index.html.en). 

~~Although we can also find LRS dataset in the website, it is not easy to read the released dataset by Fortran 90 because of its complex configuration. Therefore, we received the data with the different data configuration from the Dr. Takao Kobayashi (if you contact him, you can recieve the LRS dataset with simple configuration). We recommend that you avoid to use a high-level language, such as C or Fortran, to read LRS dataset from the SELENE Data archive. This recommendation means that even if you download the code related to LRS in my github, you cannot use it for the LRS dataset downloaded from the data archive. However, you can utilize the code associated with the DTM for the DTM dataset downloaded from the archive.~~

* No! You can open the archived dataset with Fortran90 if you use the function ACCESS='stream when you open the downloaded files.
* You can open the dataset by using the code, LRSOPEN2.f90 or LRSOPEN9.py 

