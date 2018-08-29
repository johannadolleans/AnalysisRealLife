function [Velocityxyz] = Velocityxyz(trialname)
%   trialname=strcat(trialname,'_RL_total.csv');
result=load(trialname);
for i = 1:size(result)
        A(i,9)=0.95*sin(result(i,17));% r
    A(i,1)=result(i,4); % Ball xyz
    A(i,2)=result(i,6);
    A(i,3)=result(i,5);
     A(i,4)=result(i,7); % Wrist xyz
     A(i,5)=result(i,8);
     A(i,6)=result(i,9);
     A(i,7)=result(i,10); % distance hand-ball
     A(i,8)=result(i,13); % Velocity of the ball
end
 Dz=2*pi*0.95;
  Dxy=A(:,9);
for i=1:size(result)
     t(i)=A(i,7)/A(i,8);
     Vz(i)=sqrt((A(i,3)-A(i,6))^2)./t(i);% velocity in m/s
     Vz(i)=Vz(i)/Dz;%velocity in radian
     Vz(i)=Vz(i)*180;%velocity in degrees
     Vxy(i)=sqrt((A(i,1)-A(i,4))^2+(A(i,2)-A(i,5))^2)./t(i);% velocity in m/s
     Vxy(i)=Vxy(i)/Dxy(i);%vitesse in radian
     Vxy(i)=Vxy(i)*180;% velocity in degrees
end
     Velocityxyz =[Vxy' Vz'];
end

