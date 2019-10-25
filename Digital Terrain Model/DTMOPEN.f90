!>
!> author: Changwan Sun 
!>
!> e-mail: tjsckddhks@naver.com
!>
!>date: 2016. 07. 29. (금) 21:19:09 KST
!>
Program DTMOPEN
Implicit none

Character(Len=79) :: Header(100) 
Character(Len=1) :: Passing(3156)!-->3156 Bytes!!!
Character(Len=255) :: FN='DTM_MAP_02_N15E300N12E303SC.dtm'
Integer :: i,j,k
Integer(2) :: DTMDATA(12288,12288)


Open(unit=10,File=FN,form='formatted',status='old')

Open(unit=12,File='TotalDTM_N15E300N12E303SC.txt',status='replace')
Open(unit=13,FIle='Header_N15E300N12E303.txt',status='replace') 
Open(unit=14,File='LRSfootprint10144.txt',status='replace')           

           Do i=1,96
              Read(10,'(A)') Header(i)
              Write(13,*) Header(i)
           End do
Close(10)
!!!!!!!!!!!!!!!!!!!!!!!!Please Change the file name!!!!!!!!!!!!!!!!!!!!!
OPen(unit=10, File=FN,form='unformatted',status='old')

!Open(unit=10, File=FN,form='unformatted',convert='big_endian',status='old')
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           Read(10) Passing,DTMDATA
           
           !Write(*,*) 'Passing=',Header passing
           !Write(12,*) DTMDATA !--> print one array of total data  
           
           !k=4062
           !Do k=1,12288 
           Do k=4132,4212
              !Write(12,*) (DTMDATA(j,k),j=1,12288)
              Write(14,*) (DTMDATA(j,k),j=7305,7995)
              !-->Thinking of fortran reading array
              !-->location equal to the elevation map
              !-->j: comlume(Longitude), k: Row(Latitude) 
              !-->LRSfootprint 676pixel(Long) X 81pixel(Lat)
              !600m=81pixel(rounded), 75m=10pixel(rounded)           
            End do 

End Program DTMOPEN
