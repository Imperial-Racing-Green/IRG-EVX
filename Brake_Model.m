function [T] = Brake_Model(velocity,Brake_Info)

% Convert force at pedal to force on the master cylinder pushrod (N)
Front.FPushrod = Brake_Info.BrakeBias * (Brake_Info.FPedalMax * Brake_Info.PedalMotionRatio);
Rear.FPushrod = (1 - Brake_Info.BrakeBias) * (Brake_Info.FPedalMax * Brake_Info.PedalMotionRatio);

% Find pressure generated in brake line (N/m^2)
Front.P = Front.FPushrod / Brake_Info.Front.aMasterCylinder;
Rear.P = Rear.FPushrod / Brake_Info.Rear.aMasterCylinder;

% Find force applied to brake pad by piston (N)
Front.FLat = Brake_Info.Front.aPiston * Front.P;
Rear.FLat = Brake_Info.Rear.aPiston * Rear.P;

% Find longitudinal force on disc from pad (that causes braking torque) (N)
Front.FLong = Front.FLat * Brake_Info.Front.PadFrictionCoefficent * Brake_Info.Front.nPistons; 
Rear.Flong = Rear.FLat * Brake_Info.Rear.PadFrictionCoefficent * Brake_Info.Rear.nPistons; 

% Find equivalent torque (Nm)
T_FL = - (Front.FLong * Brake_Info.Front.rActing) / 2;
T_FR = T_FL;
T_RL = - (Rear.Flong * Brake_Info.Rear.rActing) / 2;
T_RR = T_RL;

T = [T_FL;T_FR;T_RL;T_RR];
