!2345----------------------------------------------
!>@file:LRSOPEN.f90
!
!>@author:Changwan Sun/tjsckddhks@naver.com
!>date: 2016. 08. 25. (목) 11:06:11 KST
!>
!2345----------------------------------------------
Program LRSOPEN
implicit none

Complex :: Pixel(1000)
Integer :: TI,i,j,n
Real :: Lat, Long, Alt, H_offset,H_nadir, Start_range,Intensity(1000)

Open(10, File='W58.15Chandrayaan_N00_N40.dat',form='unformatted',status='old')
Open(11,File='10220.txt',status='replace')
j=1


100 Read(10,End=200) TI,Lat,Long,Alt,H_offset,H_nadir,Start_range,Pixel
      
    If(j==10220) then
      !Write(*,*)'j',j,'times'
      !Write(11,*)'TI',TI
      !Write(11,*)'Lat',Lat
      !Write(11,*)'Long',Long
      !Write(11,*)'Alt',Alt
      !Write(11,*)'H_offset',H_offset
      !Write(11,*) 'H_nadir',H_nadir
      !Write(*,*)'Start_range',Start_range
      !Write(11,*)'pixel=',pixel
    
    Do i=1,1000
    Intensity(i)=20*log10(ABS(pixel(i)))
    Write(11,*)'intensity(',i,')',Intensity(i)
    !Write(11,*) Intensity(i)
    End do
    !-----Max intensity in the intensity array-----!
    ! Write(11,*)'Max=',Maxval(Intensity) 
    !----------------------------------------------! 
    End if 
       j=j+1
    
   
    Goto 100
200 Close(10)

    Stop
End Program LRSOPEN

