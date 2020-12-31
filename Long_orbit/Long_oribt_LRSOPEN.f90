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
REAL, DIMENSION(:,:), ALLOCATABLE :: B_SCAN_IMAGE

INTEGER :: TI
INTEGER :: COL, COL2
INTEGER :: ALLOCATESTATUS
INTEGER :: i,j,k


OPEN(UNIT=10, FILE="SAR_05km_08827_02400_04899.dat", FORM='UNFORMATTED', STATUS='OLD')
OPEN(UNIT=20, FILE="HEADER_Long_orbit_LRS.txt",STATUS='REPLACE')
OPEN(UNIT=21, FILE="INTENSITY_LRS.txt",STATUS='REPLACE')
!OPEN(UNIT=22, FILE="MAXLOCATION_LRS.txt",STATUS='REPLACE')
OPEN(UNIT=23, FILE="B_SCAN_LRS.txt",STATUS='REPLACE')
!OPEN(UNIT=22, FILE="B_SCAN_LRS.txt",STATUS='REPLACE')
!OPEN(UNIT=23, FILE="B_SCAN_LRS.txt",STATUS='REPLACE')


!=====INITIALIZATION=======================================

INTENSITY = 0.0
B_SCAN_IMAGE = 0.0
j = 0
!==========================================================

Print*, "Enter the number of the columns in that you want to print in the B_SCAN_IMAGE"
Read *, COL

ALLOCATE(B_SCAN_IMAGE(1000,COL),STAT = ALLOCATESTATUS)
If (ALLOCATESTATUS /= 0) STOP "***NOT ENOUGH MEMORY***"

!Do j=1,COL

100 Read(10) TI,SC_Lat,SC_Long,SC_Alt,H_offset,H_nadir,Start_range,Pixel
    Write(20,*) TI,SC_Lat,SC_Long,SC_Alt,H_offset,H_nadir,Start_range

!      Write(11,*)'TI=',TI
!      Write(11,*)'Lat=',SC_Lat
!      Write(11,*)'Long=',SC_Long
!      Write(11,*)'Alt=',Alt
!      Write(11,*)'H_offset=',H_offset
!      Write(11,*) 'H_nadir=',H_nadir
!      Write(11,*)'Start_range=',Start_range


      j=j+1
!      Print *, "j=",j, "COL=",COL
!=====INTENSITY=============================================  
!  Z=a+ib
! |Z|=sqrt(a**2+b**2)

    Do i=1,1000
      Intensity(i,1)=20*log10(ABS(Pixel(i,1)))
      
      !Write(21,*)'intensity(',i,')',Intensity(i,1)
      !Write(21,*) Intensity(i,1)
      !Print *,'intensity(',i,')',Intensity(i,1)
      B_SCAN_IMAGE(i,j) = Intensity(i,1)
!      Print*, "B_SCAN_IMAGE(",i,",",j,")=",B_SCAN_IMAGE(i,j)
    End do
!===========================================================



!======Max intensity and location in the intensity array=====
     
     !Write(22,*)'Max=',Maxval(Intensity)
     !Write(22,*)'Maxlocation=',25*Maxloc(Intensity)
!============================================================ 

!End do 
   
   IF (j==COL) THEN
      Close(10)
   ELSE 
      GO TO 100
   END IF 

Print*, "In order to print out the A_scope, Enter the number of the columns in the B_SCAN_IMAGE that you want"
Read *, COL2



!=====Write==================================================
    Do i=1,1000
     Write(21,*) B_SCAN_IMAGE(i,COL2)
    End do
    
    Do i=1,1000    
      WRITE(23,*) (B_SCAN_IMAGE(i,j),j=1,COL)
    End do      
!=============================================================

    Stop
End Program 
 



