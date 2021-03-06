%六连杆机构计算
%2019/1/2
clear all

%-----------------------------初始化
L1 = 20.5; AB=L1;
L2 = 105.6; BC=L2;
L2_ = 65; CE=L2_;
L3 = 67.5; CD=L3;
L4 = 87.5; AD=L4;
L5 = 24.4; EF=L5;
L6 = 15; FG=L6;
G = [153.5,41.7];
dT = 0.01;
i = 1;
%-----------------------------根据几何关系求解角度之间的关系
%数值方法处理
theta1_1 = 0:dT:3.14;
theta1_2 = 3.15:dT:5.79;
theta1 = [theta1_1,theta1_2];
BD = sqrt(L1^2+L4^2-2*L1*L4*cos(theta1));
ADB = acos((L4^2+BD.^2-L1^2)./(2*L4*BD));
BDC = acos((L3^2+BD.^2-L2^2)./(2*L3*BD));
ABD = acos((L1^2+BD.^2-L4^2)./(2*L1*BD));
CBD = acos((L2^2+BD.^2-L3^2)./(2*L2*BD));

theta2_1 = ABD(1:315)+CBD(1:315)-(pi-theta1_1);
theta2_2 = CBD(316:580)-ABD(316:580)+(theta1_2-pi);
theta2 = [theta2_1,theta2_2];
w2 = zeros(length(theta2)-1,1);
for i = 1:(length(w2))
    w2(i) = (theta2(i+1)-theta2(i))/dT;
end 
a2 = zeros(length(w2)-1,1);
for i = 1:(length(a2))
    a2(i) = (w2(i+1)-w2(i))/dT;
end 
%----------------------------------------
theta3_1 = pi-ADB(1:315)-BDC(1:315);
theta3_2 = pi + ADB(316:580)-BDC(316:580);
theta3 = [theta3_1,theta3_2];

w3 = zeros(length(theta3)-1,1);
for i = 1:(length(w3))
    w3(i) = (theta3(i+1)-theta3(i))/dT;
end 
a3 = zeros(length(w3)-1,1);
for i = 1:(length(a3))
    a3(i) = (w3(i+1)-w3(i))/dT;
end 
%-----------------------------------------
Ex = L1*cos(theta1)+L2*cos(theta2)+L2_*cos(pi/3-theta2);
Ey = L1*sin(theta1)+L2*sin(theta2)-L2_*sin(pi/3-theta2);
GE = sqrt((Ex-G(1)).^2+(Ey-G(2)).^2);
GEY = atan((G(2)-Ey)./(G(1)-Ex));
for j=1:314
    if GEY(j) < 0
        GEY(j) = pi+GEY(j);
    end
end
FGE = acos((GE.^2+L6^2-L5^2)./(2*GE*L6));
FEG = acos((GE.^2-L6^2+L5^2)./(2*GE*L5));
theta5 = GEY-FEG;
theta6 = FGE+GEY-pi;


w5 = zeros(length(theta5)-1,1);
for i = 1:(length(w5))
    w5(i) = (theta5(i+1)-theta5(i))/dT;
end 
a5 = zeros(length(w5)-1,1);
for i = 1:(length(a5))
    a5(i) = (w5(i+1)-w5(i))/dT;
end 

w6 = zeros(length(theta6)-1,1);
for i = 1:(length(w6))
    w6(i) = (theta6(i+1)-theta6(i))/dT;
end 
a6 = zeros(length(w6)-1,1);
for i = 1:(length(a6))
    a6(i) = (w6(i+1)-w6(i))/dT;
end 

VEx = zeros(length(Ex)-1,1);
for i = 1:(length(VEx))
    VEx(i) = (Ex(i+1)-Ex(i))/dT;
end 
VEy = zeros(length(Ey)-1,1);
for i = 1:(length(VEy))
    VEy(i) = (Ey(i+1)-Ey(i))/dT;
end 
VE = sqrt(VEx.^2+VEy.^2);

aEx = zeros(length(VEx)-1,1);
for i = 1:(length(aEx))
    aEx(i) = (VEx(i+1)-VEx(i))/dT;
end 
aEy = zeros(length(VEy)-1,1);
for i = 1:(length(aEx))
    aEx(i) = (VEy(i+1)-VEy(i))/dT;
end 
aE = sqrt(aEx.^2+aEy.^2);


Ax = 0;
Ay = 0;
Bx = AB.*cos(theta1);
By = AB.*sin(theta1);
Cx = Bx + L2.*cos(theta2);
Cy = By + L2.*sin(theta2);
Dx = L4;
Dy = 0;
Fx = Ex + L5.*cos(theta5);
Fy = Ey + L5.*sin(theta5);
Gx = G(1);
Gy = G(2);

%---------------------------------绘图-
% figure(1);
% subplot 131
% plot(theta1,theta2);
% title('θ2');
% subplot 132
% plot(theta1(1:length(w2)),w2);
% title('w2');
% subplot 133
% plot(theta1(1:length(a2)),a2);
% title('α2');
% 
% figure(2);
% subplot 131
% plot(theta1,theta3);
% title('θ3');
% subplot 132
% plot(theta1(1:length(w3)),w3);
% title('w3');
% subplot 133
% plot(theta1(1:length(a3)),a3);
% title('α3');
% 
% 
% figure(3);
% subplot 131
% plot(theta1,theta5);
% title('θ5');
% subplot 132
% plot(theta1(1:length(w5)),w5);
% title('w5');
% subplot 133
% plot(theta1(3:length(a5)),a5(3:length(a5)));
% title('α5');
% 
% 
% figure(4);
% subplot 131
% plot(theta1,theta6);
% title('θ6');
% subplot 132
% plot(theta1(1:length(w6)),w6);
% title('w6');
% subplot 133
% plot(theta1(3:length(a6)),a6(3:length(a6)));
% title('α6');

% figure(5);
% subplot 131;
% plot(theta1(1:length(VE)),VE);
% title('E点速度');
% xlabel('θ');
% ylabel('v(mm/s)');
% subplot 132;
% plot(theta1(1:length(aE)),aE);
% title('E点加速度');
% xlabel('θ');
% ylabel('a(mm/s^2)');

% figure(6)
% for  i=1:580
%     plot([Ax,Bx(i),Cx(i)],[Ay,By(i),Cy(i)],'k',[Dx,Cx(i),Ex(i)],[Dy,Cy(i),Ey(i)],'k',...
%         [Gx,Fx(i),Ex(i)],[Gy,Fy(i),Ey(i)],'k', Ax,Ay,'^b',Bx(i),By(i),'bo',Cx(i),Cy(i),'bo',...
%         Dx,Dy,'b^',Ex(i),Ey(i),'bo',Fx(i),Fy(i),'bo',Gx,Gy,'^b');
%     axis([-50 170 -50 170])
% 
%     pause(0.01);
% end

figure(7)
subplot 131
plot(theta1,theta1,'k');
title('θ1');
subplot 132
plot(theta1,zeros(length(theta1))+1,'k');
title('w1');
subplot 133
plot(theta1,zeros(length(theta1)),'k');
title('α1');
subplot 131
