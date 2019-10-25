!>
!>Author: Changwan Sun
!>
!>Date: 2016. 09. 20. (화) 10:48:56 KST
!>
!>E-mail: tjsckddhks@naver.com
!>

Program Correlation
Implicit none

!!Total signal number: 1187!!!!
!!Time lag: 122---->approximately 0.3 degree!!!!!!

Real ::Range_Average(1:1192)
Real :: H_nadir(-596:595)

Real :: Range_Average_Cut(-474:473)

Real :: S_H_nadir(-474:473)
Real :: S_Range_Average_Cut(-474:473)
Real :: E_H_nadir(-122:122)
Real :: E_Range_Average_Cut

Real :: Multi(-474:473)
Real :: CRRL(-122:122)
Real :: N_CRRL(-122:122)
Real :: H_DC_offset
Real :: R_DC_offset

Integer :: T_delay
Integer :: Lag
Integer :: i,j,k,l,m,n,p,q,t,r,g

Character(len=44) :: FN1
Character(len=38) :: FN2
Character(len=25) :: FH1='Range_Cal_Average_0.01x'
Character(len=19) :: FH2='Correlation_0.01x'
Character(len=15) :: FT1='_N21E300N18E303'
Character(len=4) :: FT2='.txt'

Do g=0,10

!*******************************************************!
!********Automatic change code for opening file*********!

   If(g<=9.AND.g>=0) then
     Write(FH1(24:24),FMT='(I1)') 0
     Write(FH1(25:25),FMT='(I1)') g
     Write(FH2(18:18),FMT='(I1)') 0
     Write(FH2(19:19),FMT='(I1)') g
   Else
     Write(FH1(24:25),FMT='(I2)') g
     Write(FH2(18:19),FMT='(I2)') g
   End if

   FN1=trim(FH1//FT1//FT2)
   FN2=trim(FH2//FT1//FT2)
   
   Open(unit=20,file=FN1,status='old',Action='Read')
   OPen(unit=21,file=FN2,status='replace',Action='Write')
   Open(unit=10,file='H_nadir_N21E300N18E303.txt',status='old')    
  !Open(unit=13,file='HR(lag+9)_Test.txt',status='replace')

!*************************Initialization************************!
      H_DC_offset=0
      R_DC_offset=0
!***************************************************************!

      Read(10,*) H_nadir
      Read(20,*) Range_Average

!------------------------Remove DC offset------------------------!
      H_DC_offset=Sum(H_nadir)/Size(H_nadir)
      R_DC_offset=Sum(Range_Average)/Size(Range_Average)

      H_nadir=H_nadir-H_DC_offset
      Range_Average=Range_Average-R_DC_offset
!----------------------------------------------------------------!

!------------------------Cut the signal--------------------------!
      Do i=-474,473
        Range_Average_Cut(i)=Range_Average(i+597)
      End do 
!----------------------------------------------------------------

!-----------------------Cross Correlation------------------------!
      Do Lag=-122,122
!Lag=9

n=1

      Do t=-474,473
         T_delay=t+Lag
!-------------------------Multiplication-------------------------!      
         Multi(t)= Range_Average_Cut(t)*H_nadir(T_delay)
!---------------------------Check out----------------------------!      
Write(*,*)'********************,n',n,'***************************'
         Write(*,*)'t+lag=',T_delay
         Write(*,*) 't=',t,'lag=',lag
         Write(*,*) 'Range_Average_Cut(',t,')=',Range_Average_Cut(t)
         Write(13,*)H_nadir(T_delay),Range_Average_Cut(t)
         Write(*,*) 'H_naidr(',T_delay,')=',H_nadir(T_delay)
         Write(*,*) 'Multi(',t,')=',Multi(t)
         n=n+1    

!-----------For calculating the energy of Range_Average----------!    
         S_H_nadir(t)=(H_nadir(T_delay))**2   
!----------------------------------------------------------------!   

      End do 
      Write(*,*)'Sum(Multi)',Sum(Multi)
      CRRL(Lag)=Sum(Multi)

!------------------Normalized Cross correlation------------------!

      Do p=-474,473
         S_Range_Average_Cut(p)=(Range_Average_Cut(p))**2
      End do 

         E_Range_Average_Cut=Sum(S_Range_Average_Cut)
         E_H_nadir(lag)=Sum(S_H_nadir)

         N_CRRL(lag)=CRRL(lag)/sqrt(E_Range_Average_Cut*E_H_nadir(lag))

Write(*,*) '@@@@@@@E_Range_Average_Cut',E_Range_Average_Cut,'@@@@@@@@'
Write(*,*) '@@@@@@@E_H_nadir(',lag,')',E_H_nadir(lag),'@@@@@@@@'
!----------------------------------------------------------------!      
Write(*,*) '@@@@@@@@@@@@CRRL(',Lag,')',CRRL(Lag),'@@@@@@@@@@@@@@@'
  End do    
  !----------------------------------------------------------------!

  !Write(*,*) CRRL
  !Do r=-122,122
  !   Write(21,*) CRRL(r)
  !End do 
  !Write(*,*) CRRL

    Write(*,*)N_CRRL
    Do r=-122,122
      Write(21,*)N_CRRL(r)
    End do
Close(10)
Close(20)
End do 
End Program Correlation
