function [Fx,Fy,Mz] = PacejkaTest(Car,SA,SL,Fz,IA)
%PACEJKA_COMBINED Summary of this function goes here
%   Detailed explanation goes here
% addpath("model_fitting")
SL = SL .* 30;
SM = sqrt(SA.^2 + SL.^2);
B = 18.6206;
C = 0.0180;
D = 3.5223e+04.*(-Fz./180).*0.6;
E = 1.1095;
% F = zeros(length(D),1);

D2 = D;
% Sv = 0; %Vertical shift
Sh = 0; %Horizontal shift

x = 0.0174533.*SM + Sh;
y = D2*sin(C*atan(B*x - E*(B*x - atan(B*x))));
F = y;

theta = atand(SL./SA);
Fx = abs(F.*sind(theta)).*sign(SL);
Fy = abs(F.*cosd(theta)).*sign(SA);
Mz = zeros(size(SA));

% %% Greg's script
% % Source: http://psrcentre.org/images/extraimages/22.%20512067.pdf and Owen
% % Heaney's FYP
% 
% Sx = (abs(SL) ./ (1 + abs(SL))).*sign(SL);
% Sy = (tand(abs(SA)) ./ (1 + abs(SL))).*sign(SL);
% S = sqrt(Sx.^2 + Sy.^2);
% % theta = atand(Sy./Sx);
% theta = atand(Sx./Sy);
% G_x = sind(theta);
% G_y = cosd(theta);
% 
% %% Longitudinal force
% B_x = interp2(Car.Tyres.TyreMap.Longitudinal.B.Fz,Car.Tyres.TyreMap.Longitudinal.B.IA,Car.Tyres.TyreMap.Longitudinal.B.B,-Fz,-IA,'spline'); % Stiffness factor
% C_x = interp2(Car.Tyres.TyreMap.Longitudinal.C.Fz,Car.Tyres.TyreMap.Longitudinal.C.IA,Car.Tyres.TyreMap.Longitudinal.C.C,-Fz,-IA,'spline'); % Shape factor
% D_x = interp2(Car.Tyres.TyreMap.Longitudinal.D.Fz,Car.Tyres.TyreMap.Longitudinal.D.IA,Car.Tyres.TyreMap.Longitudinal.D.D,-Fz,-IA,'spline'); % Peak value
% E_x = interp2(Car.Tyres.TyreMap.Longitudinal.E.Fz,Car.Tyres.TyreMap.Longitudinal.E.IA,Car.Tyres.TyreMap.Longitudinal.E.E,-Fz,-IA,'spline'); % Curvature factor
% Sv_x = interp2(Car.Tyres.TyreMap.Longitudinal.Sv.Fz,Car.Tyres.TyreMap.Longitudinal.Sv.IA,Car.Tyres.TyreMap.Longitudinal.Sv.Sv,-Fz,-IA,'spline'); % Vertical shift
% Sh_x = interp2(Car.Tyres.TyreMap.Longitudinal.Sh.Fz,Car.Tyres.TyreMap.Longitudinal.Sh.IA,Car.Tyres.TyreMap.Longitudinal.Sh.Sh,-Fz,-IA,'spline'); % Horizontal shift
% 
% x = SL + Sh_x;
% y = D_x*sin( C_x*atan((B_x*x) - (E_x*(B_x*x - atan(B_x*x)))) );
% Y = y + Sv_x;
% F_x0 = Y;
% F_x0_0 = (D_x*sin( C_x*atan((B_x*0) - (E_x*(B_x*0 - atan(B_x*0)))) )) + Sv_x;
% 
% %% Lateral force
% B_y = interp2(Car.Tyres.TyreMap.Lateral.B.Fz,Car.Tyres.TyreMap.Lateral.B.IA,Car.Tyres.TyreMap.Lateral.B.B,-Fz,-IA,'spline'); % Stiffness factor
% C_y = interp2(Car.Tyres.TyreMap.Lateral.C.Fz,Car.Tyres.TyreMap.Lateral.C.IA,Car.Tyres.TyreMap.Lateral.C.C,-Fz,-IA,'spline'); % Shape factor
% D_y = interp2(Car.Tyres.TyreMap.Lateral.D.Fz,Car.Tyres.TyreMap.Lateral.D.IA,Car.Tyres.TyreMap.Lateral.D.D,-Fz,-IA,'spline'); % Peak value
% E_y = interp2(Car.Tyres.TyreMap.Lateral.E.Fz,Car.Tyres.TyreMap.Lateral.E.IA,Car.Tyres.TyreMap.Lateral.E.E,-Fz,-IA,'spline'); % Curvature factor
% Sv_y = interp2(Car.Tyres.TyreMap.Lateral.Sv.Fz,Car.Tyres.TyreMap.Lateral.Sv.IA,Car.Tyres.TyreMap.Lateral.Sv.Sv,-Fz,-IA,'spline'); % Vertical shift
% Sh_y = interp2(Car.Tyres.TyreMap.Lateral.Sh.Fz,Car.Tyres.TyreMap.Lateral.Sh.IA,Car.Tyres.TyreMap.Lateral.Sh.Sh,-Fz,-IA,'spline'); % Horizontal shift
% 
% x = deg2rad(SA) + Sh_y;
% y = D_y*sin( C_y*atan((B_y*x) - (E_y*(B_y*x - atan(B_y*x)))) );
% Y = y + Sv_y;
% F_y0 = Y;
% F_y0_0 = (D_y*sin( C_y*atan((B_y*0) - (E_y*(B_y*0 - atan(B_y*0)))) )) + Sv_y;
% 
% %% Combined forces
% Fx = (G_x.*(F_x0 - F_x0_0)) + F_x0_0;
% Fy = (G_y.*(F_y0 - F_y0_0)) + F_y0_0;

% % Enforce symmetry
% for i = 1:(size(Fx,1)/2)
%    Fx(i,:) = mean([abs(Fx(i,:));abs(Fx(end-i+1,:))]).*sign(Fx(i,:)); 
%    Fx(end-i+1,:) = abs(Fx(i,:)).*sign(Fx(end-i+1,:)); 
%    Fy(:,i) = mean([abs(Fy(:,i))';abs(Fy(:,end-i+1))']).*sign(Fy(:,i)'); 
%    Fy(:,end-i+1) = abs(Fy(:,i)).*sign(Fy(:,end-i+1)); 
% end
% 
% figure();
% for i = 1:size(SA,1)
%     scatter(SA(i,:),Fy(i,:),'filled')
%     hold on
% end
% figure();
% for i = 1:size(SL,1)
%     scatter(SL(:,i),Fx(:,i),'filled')
%     hold on
% end
% figure();
% for i = 1:size(Fx,1)
%     scatter(Fy(:,i),Fx(:,i),'filled')
%     hold on
% end


end