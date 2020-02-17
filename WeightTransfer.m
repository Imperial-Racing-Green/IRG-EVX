function [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y,zCoG_dyn)

m = Car.Mass.Total;
l = Car.Dimension.lWheelbase;
tF = Car.Dimension.Front_track;
tR = Car.Dimension.Rear_track;
kRollF = Car.Sus.Front.Stiffness.Roll;
kRollR = Car.Sus.Rear.Stiffness.Roll;
hRollCentreF = Car.Dimension.zRollCentreF;
hRollCentreR = Car.Dimension.zRollCentreR;
hCG_F_diff = zCoG_dyn - hRollCentreF;
hCG_R_diff = zCoG_dyn - hRollCentreR;

%% Longitudinal
% Clockwise moment about CoG
M = m*a_x*zCoG_dyn;
dF = M / l;    % Weight transfer at each wheel (+ve upwards)
Fz_Front = dF;
Fz_Rear = - dF;

%% Lateral
% Front
% % Clockwise moment about CoG
% M = m*a_y*zCoG_dyn*(1-Car.Balance.CoG(1));
% dF =  M / Car.Dimension.Front_track;   
% Weight transfer at each wheel (+ve upwards)
dF = ((m*a_y)/tF) * ( ((kRollF*hCG_F_diff)/(kRollF + kRollR - (m*9.81*hCG_F_diff))) + ((1-Car.Balance.CoG(1))*hRollCentreF) ); 
Fz_Left_Front = dF;
Fz_Right_Front = - dF;
% Rear
% % Clockwise moment about CoG
% M = m*a_y*zCoG_dyn*Car.Balance.CoG(1);
% dF =  M / Car.Dimension.Rear_track;    
% Weight transfer at each wheel (+ve upwards)
dF = ((m*a_y)/tR) * ( ((kRollR*hCG_R_diff)/(kRollF + kRollR - (m*9.81*hCG_R_diff))) + (Car.Balance.CoG(1)*hRollCentreR) );
Fz_Left_Rear = dF;
Fz_Right_Rear = - dF;

% Superimpose results of both load transfers
Fz_FL = (Fz_Front/2) + Fz_Left_Front;
Fz_FR = (Fz_Front/2) + Fz_Right_Front;
Fz_RL = (Fz_Rear/2) + Fz_Left_Rear;
Fz_RR = (Fz_Rear/2) + Fz_Right_Rear;



