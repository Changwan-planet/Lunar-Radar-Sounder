!2345----------------------------------------------
!>@file:LRSOPEN.f90
!
!>@author:Changwan Sun/tjsckddhks@gmail.com
!>date: 2020. 08. 21. (Friday) 11:06:11 KST
!>
!2345----------------------------------------------
Program LRSOPEN
Implicit none

INTEGER ::i,j,k
INTEGER :: OPENSTATUS

INTEGER :: Start_Step
CHARACTER ::OT, TI
CHARACTER, Dimension (55) :: Parsing 

REAL :: Delay
REAL :: SC_Lat, SC_Long,SC_Alt,Rang0
REAL, Dimension (1000) :: SAR_Real,SAR_Imag 

!Open(10, File='LRS_SAR05KM_C_60N_002339E.tbl',form='unformatted',status='old',ACTION='READ',POSITION='REWIND',IOSTAT=OPENSTATUS)

Open(10, File='LRS_SAR05KM_C_60N_002339E.tbl',access='stream',status='old',ACTION='READ',POSITION='REWIND',IOSTAT=OPENSTATUS)


Open(11, File='LRStest.txt',status='replace')


Do i = 1,1988

    Read(10,End=200) Parsing

IF (OPENSTATUS < 0) EXIT
IF (OPENSTATUS > 0) STOP "***CANNOT OOPE FILE***"

  
200 continue

    Read(10,End=300) SAR_Real(i)
 
300 continue

    Read(10,End=400) SAR_Imag(k)
    
    Write(*,*) "SAR_Real=",SAR_Real
    Write(*,*) "SAR_Imag=",SAR_Imag

End do 

400 continue
    stop
    
    !Do i=1,1000
    !Intensity(i)=20*log10(ABS(pixel(i)))
    !Write(11,*)'intensity(',i,')',Intensity(i)
    !Write(11,*) Intensity(i)
    !End do
    !-----Max intensity in the intensity array-----!
    ! Write(11,*)'Max=',Maxval(Intensity) 
    !----------------------------------------------! 
    !End if 
    j=j+1
print *, j  
End Program LRSOPEN

