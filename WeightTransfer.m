function [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y,zCoG_dyn)

%% Longitudinal
% Clockwise moment about CoG
M = Car.Mass.Total*a_x*zCoG_dyn;
dF = M / Car.Dimension.lWheelbase;    % Weight transfer at each wheel (+ve upwards)
Fz_Front = dF;
Fz_Rear = - dF;

%% Lateral
% Front
% Clockwise moment about CoG
M = Car.Mass.Total*a_y*Car.Dimension.CoG(3)*(1-Car.Balance.CoG(1));
dF =  M / Car.Dimension.Front_track;    % Weight transfer at each wheel (+ve upwards)
Fz_Left_Front = dF;
Fz_Right_Front = - dF;
% Rear
% Clockwise moment about CoG
M = Car.Mass.Total*a_y*Car.Dimension.CoG(3)*Car.Balance.CoG(1);
dF =  M / Car.Dimension.Rear_track;    % Weight transfer at each wheel (+ve upwards)
Fz_Left_Rear = dF;
Fz_Right_Rear = - dF;

% Fz_FL = (Fz_Front/2) + (Fz_Left/2);
% Fz_FR = (Fz_Front/2) + (Fz_Right/2);
% Fz_RL = (Fz_Rear/2) + (Fz_Left/2);
% Fz_RR = (Fz_Rear/2) + (Fz_Right/2);
Fz_FL = (Fz_Front/2) + Fz_Left_Front;
Fz_FR = (Fz_Front/2) + Fz_Right_Front;
Fz_RL = (Fz_Rear/2) + Fz_Left_Rear;
Fz_RR = (Fz_Rear/2) + Fz_Right_Rear;



