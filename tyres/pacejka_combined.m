function [Fx,Fy,Mz] = pacejka_combined(SR,SA,Fz)
%PACEJKA_COMBINED Summary of this function goes here
%   Detailed explanation goes here
addpath("model_fitting")

SM = sqrt(SA.^2 + SR.^2);
B = 18.6206;
C = 0.0180;
D = 3.5223e+04.*(Fz./180);
E = 1.1095;
coef = [B, C, D, E, 0, 0];
F = pacejka4(coef,0.0174533.*SM);
theta = atand(SR./SA);
Fx = F.*sind(theta);
Fy = F.*cosd(theta);
Mz = zeros(size(SA));
end
