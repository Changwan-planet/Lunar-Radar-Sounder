Program Long_orbit_LRSOPEN
Implicit none

COMPLEX, DIMENSION(1000,1) :: Pixel

REAL :: SC_Lat
REAL :: SC_Long
REAL :: SC_Alt
REAL :: H_offset
REAL :: H_nadir
REAL :: Start_range
REAL, DIMENSION(1000,1) :: Intensity

INTEGER :: TI
INTEGER :: COL, COL2
INTEGER :: ALLOCATESTATUS
INTEGER :: i,j,k


OPEN(UNIT=10, FILE="SAR_05km_08878_89000_90199.dat", FORM='UNFORMATTED', STATUS='OLD')
OPEN(UNIT=20, FILE="W_HEADER_Long_orbit_LRS.txt",STATUS='REPLACE')
!OPEN(UNIT=21, FILE="INTENSITY_LRS.txt",STATUS='REPLACE')
!OPEN(UNIT=22, FILE="MAXLOCATION_LRS.txt",STATUS='REPLACE')
OPEN(UNIT=23, FILE="W_B_SCAN_LRS.txt",STATUS='REPLACE')

!=====INITIALIZATION=======================================
INTENSITY = 0.0
j = 0
k = 0
!==========================================================

100 Read(10, End=200) TI,SC_Lat,SC_Long,SC_Alt,H_offset,H_nadir,Start_range,Pixel
  Write(20,*) TI,SC_Lat,SC_Long,SC_Alt,H_offset,H_nadir,Start_range
      j=j+1
      Print *, "j=",j

!=====INTENSITY=============================================  
!  Z=a+ib
! |Z|=sqrt(a**2+b**2)

    Do i=1,1000
      Intensity(i,1)=20*log10(ABS(Pixel(i,1))) 
   End do
!===========================================================


!======Max intensity and location in the intensity array=====
     
     !Write(22,*)'Max=',Maxval(Intensity)
     !Write(22,*)'Maxlocation=',25*Maxloc(Intensity)
!============================================================ 

    GO TO 100
200 Close(10)
    STOP   
    
End Program 
 



