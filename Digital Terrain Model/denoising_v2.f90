!
!>author: Changwan Sun
!>e-mail: tjsckddhks@naver.com
!>
!>2016. 10. 12. (수) 10:04:08 KST
!>
Program denoising_v2
Implicit none

Character(len=255) :: FN_in='LRSfootprint10144.txt'
Character(len=255) :: FN_out='Denoised_LRSfootprint10144.txt'

Integer :: Elevation(81,691)
Integer :: Denoised_El(81,691)
Integer :: Row(691)
Integer :: m,l,q,s,t,u,v,y,x,j,k,n
Integer :: ts,dis

Open(unit=11, file=FN_in,status='old')
Open(unit=13, file=FN_out,status='replace')

!-------------------------Initilization----------------------------!
Elevation=0
Row=0

!----------------------Change the Matrix size----------------------!

ts=81   !--->Row number
s=691    !---> Column number
    
!------------------------------------------------------------------!

   
    Do k=1,ts
       Read(11,*) (Elevation(k,j),j=1,s)
       
       !j:column(Longitude), k:Row(Latitude)
    End do 
!-----------------------------------------------------------------!

Do m=1,ts
          Do l=1,s
             Row(l)=Elevation(m,l)
          End do 
!Write(*,*) '**************Latitude pixel=',m,'*******************'       
t=0
v=0
u=0
y=0

!---------------------------Denoise extremely large noise-----------------------!
              Do  q=1,s-1
              
	      If(Row(1)==-9999) then
                Row(1)=Row(6)-10
                Row(2)=Row(1)-2
                Row(3)=Row(2)-2
                Row(4)=Row(3)-2
                Row(5)=Row(4)-2
              End if
                
              Dis=ABS(Row(q)-Row(q+1))
              if (Dis>=7000) then
                  Write(*,*) '@@@@@@@@@@@@@@@@@@@@@@@',n,'@@@@@@@@@@@@@@@@@@@@@@@'   
                  Write(*,*) 'Row:',m,'Row(',q,')',Row(q),'Row(',q+1,')',Row(q+1)
                 
                    If(Row(q)<=Row(q+1)) Row(q)=Row(q+1)+2                 
                    If(Row(q)>=Row(q+1)) ROw(q+1)=Row(q)+2
                        
                  Write(*,*)'*****************denosied*************************'
                  Write(*,*) 'Row:',m,'Row(',q,')',Row(q),'Row(',q+1,')',Row(q+1)
              End if

              
!-----------------------------------------------------------------!
             If(ABS(Row(1)-Row(2))>=60) then 
                 If(Maxloc(Row,1)==1) Row(1)=Row(2)
                 If(Maxloc(Row,1)==2) Row(2)=Row(1)
                 If(Minloc(Row,1)==1) Row(1)=Row(2)
                 If(Minloc(Row,1)==2) Row(2)=Row(1)
                           
                 v=v+1
                 
             End if
!-----------------------------------------------------------------!      
             If(ABS(Row(3)-Row(4))>=60) then
                If(Maxloc(Row,1)==3) Row(3)=Row(4)
                If(Maxloc(Row,1)==4) Row(4)=Row(3)
                If(Minloc(Row,1)==3) Row(3)=Row(4)
                If(Minloc(Row,1)==4) Row(4)=Row(3) 
    
                v=v+1

               !Write(*,*)'Front unnatural elevation denoising=',v
             End If  
!-----------------------------------------------------------------!             
              If(ABS(Row(s)-Row(s-1))>=60) then
                  Row(s)=Row(s-2)
                  Row(s-1)=Row(s-2)
                  y=y+1
                  !Write(*,*) 'Last unatural elvation denoising=',y
              End if
!-----------------------------------------------------------------!
              If(ABS(Row(q)-Row(q+1))>=80) then
                 t=t+1
                 !Write(*,*)'denoising=',Row(q)
                 Row(q+1)=Row(q-2)
                 !Write(*,*)'denoising=',Row(q+1)
              End if
           End do 

           u=v+t+y+x

!--------------------------denoised Row--------------------------!
         Write(*,*) Row 
         Write(13,*) Row                 
End do     

End program denoising_v2
