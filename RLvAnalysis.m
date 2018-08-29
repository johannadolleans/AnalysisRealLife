function [ResultVive]= RLvAnalysis(trialname)
trialname=strcat(trialname,'.csv');
A=csvread(trialname);
for i=1:size(A)
     t(i)=A(i,10)/A(i,13); % velocity / distance
     vt(i)=sqrt((A(i,6)-A(i,9))^2)./t(i);% velocity in m/s
     vt(i)=vt(i)/2/pi/0.95;%velocity in radian
     vt(i)=vt(i)*180;%velocity in degrees
     va(i)=sqrt((A(i,4)-A(i,7))^2+(A(i,5)-A(i,8))^2)./t(i);% velocity in m/s
     va(i)=va(i)/2/pi/0.95;%vitesse in radian
     va(i)=va(i)*180;% velocity in degrees
     A(i,4)=A(i,5)-A(i,11);%bring back coordinate to normal one
     A(i,5)=A(i,4)-A(i,12);
     A(i,6)=A(i,6)+1-A(i,13);    
     A(i,7)=A(i,8)-A(i,11);
     A(i,8)=A(i,7)-A(i,12);
     A(i,9)=A(i,9)+1-A(i,13);  
     r(i)=sqrt(A(i,4)^2+A(i,5)^2);
     B(i,1)=asin(A(i,5)/r(i))*360/pi;%Calucltaion of alpha using x and y
     B(i,2)=A(i,17);% theta
     B(i,3)=va(i);%va
     B(i,4)=vt(i);%vt
     B(i,5)=A(i,12);%Error  
end
AvAlpha=0;AvTheta=0; AvVa=0; AvVt=0; AvEr=0; SuRa=0;
for i =1:length(releaseData)
   AvAlpha=AvAlpha+B(i,1);
   AvTheta=AvTheta+B(i,2);
      AvVa=AvVa+B(i,3); 
      AvVt=AvVt+B(i,4);
    AvEr=AvEr+B(i,5); 
    if B(i,5)<.05
        SuRa=SuRa+1;
    end
end
AvAlpha=AvAlpha/length(B);
AvTheta=AvTheta/length(B);
AvVa=AvVa/length(B);
AvVt=AvVt/length(B);
AvEr=AvAlpha/length(B);
SuRa=SuRa/length(B);
ResultVive=[AvAlpha AvTheta AvVa AvVt AvEr SuRa];
save(sprintf('%s_RealLifeVive_clean',trialname),'B');
end