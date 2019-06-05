function [T] = Brake_Model(Brake_Info)

% Convert force at pedal to force on the master cylinder pushrod (N)
Front.FPushrod = Brake_Info.BrakeBias * (Brake_Info.FPedalMax * Brake_Info.PedalMotionRatio);
Rear.FPushrod = (1 - Brake_Info.BrakeBias) * (Brake_Info.FPedalMax * Brake_Info.PedalMotionRatio);

% Find pressure generated in brake line (N/m^2)
Front.P = Front.FPushrod / Brake_Info.Front.aMasterCylinder;
Rear.P = Rear.FPushrod / Brake_Info.Rear.aMasterCylinder;

% Find force (at caliper) applied to brake pad by piston (N)
Front.FLat = Brake_Info.Front.aPiston * Front.P * Brake_Info.Front.nPistons;
Rear.FLat = Brake_Info.Rear.aPiston * Rear.P * Brake_Info.Rear.nPistons;

% Find clamping force (multipled by 2 for two calipers)
Front.FClamp = Front.FLat * 2;
Rear.FClamp = Rear.FLat * 2;

% Find longitudinal force on disc from pad (that causes braking torque) (N)
Front.FLong = Front.FClamp * Brake_Info.Front.PadFrictionCoefficent; 
Rear.Flong = Rear.FClamp * Brake_Info.Rear.PadFrictionCoefficent; 

% Find equivalent torque (Nm)
T_FL = - (Front.FLong * Brake_Info.Front.rActing);
T_FR = T_FL;
T_RL = - (Rear.Flong * Brake_Info.Rear.rActing);
T_RR = T_RL;

T = [T_FL;T_FR;T_RL;T_RR];

% T = [-400;-400;-200;-200];
