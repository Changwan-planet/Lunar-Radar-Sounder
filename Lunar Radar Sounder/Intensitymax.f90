!2345----------------------------------------------
!>@file:Intensitymax.f90
!
!>@author:Changwan Sun/tjsckddhks@naver.com
!>date: 2016. 06. 27. (월) 10:38:28 KST
!
!2345----------------------------------------------
Program Intensitymax
implicit none

Complex :: Pixel(1000)
Integer :: TI,i,j,Maxlocation
Real :: Lat, Long, Alt, H_offset,H_nadir, Start_range,Intensity(1000)

Open(10, File='W58.15Chandrayaan_N00_N40.dat',form='unformatted',status='old')
Open(11,File='W58.15Chandrayaan_N00_N40.txt',status='replace')
j=0

100 Read(10,End=200) TI,Lat,Long,Alt,H_offset,H_nadir,Start_range,Pixel
  
      Write(11,*)'TI=',TI
      Write(11,*)'Lat=',Lat
      Write(11,*)'Long=',Long
      Write(11,*)'Alt=',Alt
      Write(11,*)'H_offset=',H_offset
      Write(11,*) 'H_nadir=',H_nadir
      Write(11,*)'Start_range=',Start_range
       
     Do i=1,1000
     Intensity(i)=20*log10(ABS(pixel(i)))
     !Write(11,*)'intensity(',i,')',Intensity(i)
     End do
    !-----Max intensity and location in the intensity array-----!
     !Write(11,*)'Max=',Maxval(Intensity)
     Write(11,*)'Maxlocation=',25*Maxloc(Intensity)
    !-----------------------------------------------------------! 
      j=j+1
      Write(11,*)'j=',j,'times'
       
    Goto 100
200 Close(10)
    Stop
End Program Intensitymax
