!>
!>author: Changwan Sun
!>e-mail: tjsckddhks@naver.com
!>
!>2016. 08. 19. (금) 19:13:29 KST
!>
Program Ranging
Implicit none

Character(len=255) :: FN_in='DTMSAR_Cut_2km_N15E300N12E303SC.txt'
Character(len=255) :: FN_in2='reOrbit_W58.15_parsing_12_15.txt'

!Character(len=255) :: FN_out="Denoised_DTM1113.txt"
Character(len=255) :: FN_out2='DTM_2km_N15E300N12E303SC.txt'
Character(len=255) :: FN_out3='Range_2km_N15E300N12E303SC.txt'

Integer :: Elevation(81,277)
Integer :: Denoised_El(81,277)
Integer :: Row(277)
!--------------------------------Declaration for Ranging-------------------------
Real, Dimension(5,1157) :: LRS_Info
Real :: Altitude(1157)
Real :: LRS_Lat(1157)
Real :: DTM_Center(1157)
Real :: LRS_Ranging(81,277)
Real :: Range_Average(1157)
Real :: Degree
Real,Parameter :: pi=Acos(-1.0)

Integer :: h,i,f,g,s,d,e,j,k,l,m,n,q,t,v,u,y,x,z
Integer :: A,B,C
Integer :: p=1157
Integer :: r,w

Open(unit=10, file=FN_in, status='old')
Open(unit=11, file=FN_in2, status='old')

!OPen(unit=13, file=FN_out, status='replace')
Open(unit=14, file=FN_out2, status='replace')
Open(unit=15, file=FN_out3, status='replace')

!!******************Read LRS information**********************
Read(11,*) LRS_Info
!! 1.Latitude 2.Longitude 3.Altitude 4.Radar_Altitude 5.H_nadir
!*************************************************************
!If Kaguya fly from north to south, Latitude begin large number.
!So We need to change the direction.

!---------------------------Initilization------------------------------!
Elevation=0
Row=0
Altitude=0
Degree=2*pi/360

!******************Conversion of LRS direction************************
If (LRS_Info(1,1)>LRS_Info(1,p)) then
   Do r=1,p
      LRS_Lat(p-r+1)=LRS_Info(1,r)
      Altitude(p-r+1)=LRS_Info(3,r)
   End do 

   Else

   Do w=1,p
      LRS_Lat(w)=LRS_Info(1,w)
      Altitude(w)=LRS_Info(3,w)
   End do 
End if
!*******************************************************!


!**********SAR Area Longitude way pixel number**********!
s=277
!*******************************************************!

Do n=1,p

    
Write(*,*) '********************DTMSAR',n,'***********************' 
    
    Do k=1,81
       Read(10,*) (Elevation(k,j),j=1,s)
       !Write(*,*) (Elevation(k,j),j=1,676)
       !j:colume(Longitude), k:Row(Latitude)
    End do 
!----------------------------------------------------------------------!

!Write(*,*) 'Elevation_Max=',Maxval(Elevation)
!Write(*,*) 'Elevation_Min=',Minval(Elevation)
!Write(*,*) Elevation

!-----------------------------denoising--------------------------------!
    
      Do m=1,81
          Do l=1,s
             Row(l)=Elevation(m,l)
          End do 
!Write(*,*) '****************Latitude pixel=',m,'********************'       
t=0
v=0
u=0
y=0

           Do q=1,s-1
!-------------------------------------------------------------------------!
             If(ABS(Row(1)-Row(2))>=60) then 
                 If(Maxloc(Row,1)==1) Row(1)=Row(2)
                 If(Maxloc(Row,1)==2) Row(2)=Row(1)
                 If(Minloc(Row,1)==1) Row(1)=Row(2)
                 If(Minloc(Row,1)==2) Row(2)=Row(1)
                 
                 v=v+1
                 
             End if
!-------------------------------------------------------------------------!             
             If(ABS(Row(3)-Row(4))>=60) then
                If(Maxloc(Row,1)==3) Row(3)=Row(4)
                If(Maxloc(Row,1)==4) Row(4)=Row(3)
                If(Minloc(Row,1)==3) Row(3)=Row(4)
                If(Minloc(Row,1)==4) Row(4)=Row(3)
                
                v=v+1
              ! Write(*,*)'Front unnatural elevation denoising=',v                
             End If  
!-----------------------------------------------------------------------!             
              If(ABS(Row(s)-Row(s-1))>=60) then
                  Row(s)=Row(s-2)
                  Row(s-1)=Row(s-2)
                  y=y+1
                  !Write(*,*) 'Last unatural elvation denoising=',y
              End if
!-----------------------------------------------------------------------!
              If(ABS(Row(q)-Row(q+1))>=80) then
                 t=t+1
                 !Write(*,*)'denoising=',Row(q)
                 Row(q+1)=Row(q-2)
                 !Write(*,*)'denoising=',Row(q+1)
              End if
           End do 
           !Write(*,*) 'Unnatural elevation denoising',t
           u=v+t+y+x
           !Write(*,*) 'Total unnatrual denoising',u
           !Write(*,*) 'Max_elevation',Maxval(Row)
           !Write(*,*) 'Min_elevation',Minval(Row)
 
!-----------------------------denoised Row-----------------------------!
         
         !Write(*,*) Row
         
         
         !Write(12,*) Row      
         
         Do z=1,s
            Denoised_El(m,z)=Row(z)
         End do  
    End do

!------------------------pick up specific DTMSAR ----------------------!      
!         If(n==1113) then 
!            Write(*,*) 'good'
!            Do h=1,81
!               Write(13,*) (Denoised_El(h,i),i=1,s)
!            End do 
!        End if
!----------------------------------------------------------------------!
               
         DTM_Center(n)=Denoised_El(41,INT(s/2))
         !Write(*,*) Denoised_El(41,INT(s/2))
         Write(*,*) 'LRS Singal',n,'Range_Cal_Center',DTM_Center(n)
         Write(14,*) DTM_Center(n)
         !Write(*,*)'LRS Altitude',n,Altitude(n) 
         !Write(*,*) cos(LRS_Lat(n))
         !Write(*,*) cos(LRS_Lat(n)*degree)
         Do d=1,81
            Do e=1,s
            
            LRS_Ranging(d,e)= Sqrt((Altitude(n)-Denoised_El(d,e))**2+(ABS(81-d)*7.4)**2+&
            (ABS(INT(s/2)-e)*7.4*(cos(LRS_Lat(n)*degree)))**2)
            
            End do 
            
         End do 
           
            Range_Average(n)=SUM(LRS_Ranging)/Size(LRS_Ranging)
            Write(*,*) 'Range_Average',Range_Average(n)
            Write(15,*)Range_Average(n)
End do 
End program Ranging
