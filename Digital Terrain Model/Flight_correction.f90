Program Flight_correction
Implicit none

Integer :: L,p,i,j

Real, Dimension(5,1179) :: LRS_Info
Real :: LRS_Lat(1179)
Real :: LRS_Long(1179)
Real :: LRS_Alt(1179)
Real :: LRS_RadarAlt(1179)
Real :: H_nadir(1179)



Open(unit=10, file='Orbit_01_parsing_27_30.txt', status='old')
Open(unit=11, file='reOrbit_01_parsing_27_30.txt',status='replace')
!!*****************Read LRS information************************

Read(10,*) LRS_Info
!! 1.Latitude 2.Longitude 3.Altitude 4.Radar_Altitude 5.H_nadir

!**************************************************************
!If Kaguya fly from north to south,Latitue begin large number.
!So We need to change the direction
!***************************************************************

L=1179

If (LRS_Info(1,1)>LRS_Info(1,L)) then
  Do p=1,L
     LRS_Lat(L-p+1)=LRS_Info(1,p)
     LRS_Long(L-p+1)=LRS_Info(2,p)
     LRS_Alt(L-p+1)=LRS_Info(3,p)
     LRS_RadarAlt(L-p+1)=LRS_Info(4,p)
     H_nadir(L-p+1)=LRS_Info(5,p)
  End do 

  Else

  Do i=1,L
     LRS_Lat(i)=LRS_Info(1,i)
     LRS_Long(i)=LRS_Info(2,i)
     LRS_Alt(i)=LRS_Info(3,i)
     LRS_RadarAlt(i)=LRS_Info(4,i)
     H_nadir(i)=LRS_Info(5,i)     
  End do 
End if

Do j=1,L
   Write(11,*) LRS_Lat(j),LRS_Long(j), LRS_Alt(j), LRS_RadarALt(j), H_nadir(j)
End do     
!***************************************************************

End program

