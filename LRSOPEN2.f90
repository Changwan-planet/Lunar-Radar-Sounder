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

!INTEGER :: Start_Step
!CHARACTER ::OT, TI
CHARACTER, Dimension (684) :: HEADER


!REAL :: SC_Lat, SC_Long,SC_Alt,Rang0
REAL, Dimension (1000) :: SAR_REAL,SAR_IMAG 
COMPLEX, DIMENSION (1000) :: PIXEL
REAL, DIMENSION (1000) :: INTENSITY


!Open(10, File='LRS_SAR05KM_C_60N_002339E.tbl',form='unformatted',status='old',ACTION='READ',POSITION='REWIND',IOSTAT=OPENSTATUS)

Open(10, File='LRS_SAR05KM_C_60N_002339E.tbl',access='stream',status='old',ACTION='READ',IOSTAT=OPENSTATUS)
Open(11, File='LRStest.txt',status='replace')

j=0
k=0
SAR_REAL=0
SAR_IMAG=0
PIXEL=0
INTENSITY=0

100 READ(10, End=200) HEADER, PIXEL
PRINT *, PIXEL
!DO k = 1,1000
!   PIXEL(k) = SQRT(SAR_REAL(k)**2 + SAR_IMAG(k)**2)
!END DO

!DO i=1,1000
    
! Intensity(i,1)=20*log10(ABS(Pixel(i))) 

!END DO  

    Print *, "j=",j
   
    j=j+1

    GO TO 100

200 CLOSE(10)
    STOP


   
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

