function [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y,zCoG_dyn)

%% Longitudinal
% Clockwise moment about CoG
M = Car.Mass.Total*a_x*zCoG_dyn;
dF = M / Car.Dimension.lWheelbase;    % Weight transfer at each wheel (+ve upwards)
Fz_Front = dF;
Fz_Rear = - dF;

%% Lateral
% Clockwise moment about CoG
M = Car.Mass.Total*a_y*Car.Dimension.CoG(3);
dF =  M / Car.Dimension.Front_track;    % Weight transfer at each wheel (+ve upwards)
Fz_Left = dF;
Fz_Right = - dF;

Fz_FL = (Fz_Front/2) + (Fz_Left/2);
Fz_FR = (Fz_Front/2) + (Fz_Right/2);
Fz_RL = (Fz_Rear/2) + (Fz_Left/2);
Fz_RR = (Fz_Rear/2) + (Fz_Right/2);




