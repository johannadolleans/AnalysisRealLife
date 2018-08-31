function [R D]= RLnAnalysis(trialname)
trialname=strcat(trialname,'.csv');
A=csvread(trialname);
L=1.36; %length of rope in meter
    l=1;j=1;
for i=2:size(A)
    BCA(i,1)=(A(i,12)-A(i,15))/2;
    BCA(i,2)=(A(i,13)-A(i,16))/2;
    BCA(i,3)=(A(i,14)-A(i,17))/2;
    BCH(i,1)=(A(i,18)-A(i,21))/2;
    BCH(i,2)=(A(i,19)-A(i,22))/2;
    BCH(i,3)=(A(i,20)-A(i,23))/2;
    Time(i)=A(i,1)/200;
    DHA(i)=real(sqrt((BCA(i,1)-BCH(i,1))^2+(BCA(i,2)-BCH(i,2))^2+(BCA(i,3)-BCH(i,3))^2));% Distance between hand and arm
    DBT(i)=real(sqrt((A(i,24)-A(i,27))^2+(A(i,25)-A(i,28))^2+(A(i,26)-A(i,29))^2)); % Distance between Ball and Targte
    DBP(i)=real(sqrt((A(i,24)-A(i,30))^2+(A(i,25)-A(i,31))^2+(A(i,25)-A(i,32))^2)); % Distance between Ball and Pole
    B(i,1)=asin((BCH(i,1)-A(i,27))/DHA(i));% Alpha
    B(i,2)=asin(DBP(i)/L);% Theta
    B(i,3)=real(sqrt((A(i-1,24)-A(i,24))^2+(A(i-1,25)-A(i,25))^2)/(Time(i)-Time(i-1)));% Velocity alpha
    B(i,4)=real(sqrt((A(i-1,26)-A(i,26))^2)/(Time(i)-Time(i-1)));% Velocity Theta
    B(i,5)=real(sqrt((A(i,24)-A(i,27))^2+(A(i,25)-A(i,28))^2+(A(i,26)-A(i,29))^2));% Error
    DH(i)=real(sqrt((A(i,18)-A(i,21))^2+(A(i,19)-A(i,2))^2+(A(i,20)-A(i,23))^2));% Distance between Hand
    DHB(i)=real(sqrt((A(i,24)-BCH(i,1))^2+(A(i,25)-BCH(i,2))^2+(A(i,26)-BCH(i,3))^2));% Distance between ball and hand
    if abs(DHB(i)-10)<.5
        D(l)=i;
        l=l+1
    end
   
end
C=[];
for j=1:length(D)
   C(j,:)=B(D(j),:)
 end
AvAlpha=0;AvTheta=0; AvVa=0; AvVt=0; AvEr=0; SuRa=0;
for i =1:length(C)
   AvAlpha=AvAlpha+C(i,1);
   AvTheta=AvTheta+C(i,2);
      AvVa=AvVa+C(i,3); 
      AvVt=AvVt+C(i,4);
    AvEr=AvEr+C(i,5); 
    if C(i,5)<.05
        SuRa=SuRa+1;
    end
end
AvAlpha=AvAlpha/length(B);
AvTheta=AvTheta/length(B);
AvVa=AvVa/length(B);
AvVt=AvVt/length(B);
AvEr=AvAlpha/length(B);
SuRa=SuRa/length(B);
ResultNexus=[AvAlpha AvTheta AvVa AvVt AvEr SuRa];
save(sprintf('%s_RealLifeNexus_cont.mat',trialname),'B');
save(sprintf('%s_RealLifeNexus_trial.mat',trialname),'C');
end