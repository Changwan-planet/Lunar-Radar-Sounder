Program DTMSAR_Cut_5km
Implicit none

Integer :: i,j,k,m,n,p

!!!!!!!!!!Change----------------->Latitude Number!!!!!!!!!!
Integer :: L=1157      
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Integer :: TotalDTM(12288,12288)
Integer :: DTMSAR_N(1157)
Integer :: DTMSAR_S(1157)
Integer :: DTMSAR_E(1157)
Integer :: DTMSAR_W(1157)
Integer :: LRSLong_P(1157)
Integer :: PS_Lat

Real :: DTMLat_N=15.0000000
Real :: DTMLat_S=12.000244
Real :: DTMLong_E=302.999756 ! write ~  longitude
Real :: DTMLong_W=300.000000 ! write ~  longitude
Real :: LRSLat_N=14.98815
Real :: LRSLat_S=12.01129
Real :: LRSLong_E=-58.13175
Real :: LRSLong_W=-58.13222

Real :: HalfSARLong=0.082464!---->Half-SAR Longitude Size by Degree
Real :: HalfSARLat=0.009896!---->Half-SAR Latitude Size by Degree
Real :: Degree

Real, Dimension(5,1157) :: LRS_Info
Real, Dimension(1157) :: LRS_Lat
Real, Dimension(1157) :: LRS_Long

Real,Parameter :: pi=Acos(-1.0)

Open(unit=10, file='TotalDTM_N15E300N12E303SC.txt',status='old')
Open(unit=11, file='reOrbit_W58.15_parsing_12_15_ac.txt',status='old')
Open(unit=13, file='DTMSAR_Cut_ac_5km_N15E300N12E303SC.txt',status='replace')
!Open(unit=14, file='Test.txt',status='replace')

Write(*,*)'DTMLatitude_N',DTMLat_N
Write(*,*)'DTMLatitude_S',DTMLat_S
Write(*,*)'DTMLongitude_E',DTMLong_E
Write(*,*)'DTMLongitude_W',DTMLong_W
Write(*,*)'LRSLatitude_N',LRSLat_N
Write(*,*)'LRSLatitude_S',LRSLat_S
Write(*,*)'LRSLongitude_E',LRSLong_E
Write(*,*)'LRSLongitude_W',LRSLong_W
                             
!                                
!           DTMLat_N  .......................
!                     .            *        .
!                     .            *        .
!                     .            @        .                        
!                     .           @ <---LRS .
!          LRS_Lat j  .**********@**********. 
!                     .         @           .
!                     .        @            .
!                     . _ A _  *            .
!                     ./     \ *            .
!           DTMLat_S  ....................... 
!                              i
!                           LRS_Long     
!
Write(*,*)'******************DTM_SAR_CUT************************'
!----------------------------Degree to pixel-----------------------

Degree=2*pi/360

Read(10,*) TotalDTM

!!*****************Read LRS information************************
Read(11,*) LRS_Info
!! 1.Latitude 2.Longitude 3.Altitude 4.Radar_Altitude 5.H_nadir

!**************************************************************
!If Kaguya fly from north to south,Latitue begin large number.
!So We need to change the direction
!***************************************************************
If (LRS_Info(1,1)>LRS_Info(1,L)) then
  Do p=1,L
     LRS_Lat(L-p+1)=LRS_Info(1,p)
     LRS_Long(L-p+1)=LRS_Info(2,p)
  End do 

  Else

  Do i=1,L
     LRS_Lat(i)=LRS_Info(1,i)
     LRS_Long(i)=LRS_Info(2,i)
  End do 
End if
!***************************************************************

!**********************Check negative longtidue***************** 
If(LRS_Long(1)<0)  LRS_Long=LRS_Long+360
!***************************************************************

!Write(*,*) LRS_Long

!LRS_Long=LRS_Long-0.1

Do m=1,L

   Write(*,*) '****************DTMSAR',m,'**********************' 
 
   DTMSAR_N(m)=Floor(12287*(DTMLat_N-(LRS_Lat(m)+HalfSARLat))/3)+1
   !To make the pixelsize 81 pixel, Add 1 to the DTMSAR_N

   DTMSAR_S(m)=Floor(12287*(DTMLat_N-(LRS_Lat(m)-HalfSARLat))/3)
   LRSLong_P(m)=Floor(12287*(LRS_Long(m)-DTMLong_W)/3)
   DTMSAR_E(m)=LRSLong_P(m)+Floor(2500/(7.403*cos(LRSLat_S*degree)))
   DTMSAR_W(m)=LRSLong_P(m)-Floor(2500/(7.403*cos(LRSLat_S*degree)))
   
!!!!!!!!!Fixing the latitude size 81 pixel!!!!!!!!!!!! 
   PS_Lat=(DTMSAR_S(m)-DTMSAR_N(m))+1
      If(PS_Lat==82) then
        DTMSAR_N(m)=DTMSAR_N(m)+1
        PS_Lat=(DTMSAR_S(m)-DTMSAR_N(m))+1
      End if
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 

   Write(*,*) 'LRS_Lat',LRS_Lat(m) 
   Write(*,*) 'LRS_Long',LRS_Long(m)
   Write(*,*) 'DTMSAR_N',DTMSAR_N(m), 'DTMSAR_S',DTMSAR_S(m)  
   Write(*,*) 'DMTSAR_E',DTMSAR_E(m), 'DTMSAR_W',DTMSAR_W(m)
   Write(*,*) 'LRSLong_P',LRSLong_P(m)
   Write(14,*) LRSLong_P(m)
   Write(*,*) 'Latitude pixel size',PS_Lat 
   Write(*,*) 'Latitude meter size',((DTMSAR_S(m)-DTMSAR_N(m))+1)*7.403
   Write(*,*) 'Longitude pixel size',(DTMSAR_E(m)-DTMSAR_W(m))+1 
   Write(*,*) 'Longitude meter size',((DTMSAR_E(m)-DTMSAR_W(m))+1)*7.403*cos(LRSLat_S*degree)  

!!!! We decide the Longtiude pixel size to the size of the lowest Latitude!!
!!!! We ignore the difference!!!!!
!!!! When our research area are the 3 degree in latitude, the difference 11 pixel, little gap compared to the entire length 5km. 
!lowest longitude pixel size:699, highest longitude pixel size:711)
!However,, A Latitude go up, the difference could be larger

                 Do k=DTMSAR_N(m),DTMSAR_S(m)  
                   Write(13,*) (TotalDTM(j,k),j=DTMSAR_W(m),DTMSAR_E(m))
                   !j:colume(Longitude),k:Row(Latitude)
                End do
End do 
                                                     
End Program DTMSAR_CUT_5km

