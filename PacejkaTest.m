function [Fx,Fy,Mz] = PacejkaTest(SA,SL,Fz)
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
end