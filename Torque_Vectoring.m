function [Delta_T]=Torque_Vectoring(Car,Fy_tyres,curve_d,velocity,Fz_front,Fz_rear)

%Inputs - Car parameters, Fy_FL, Fy_FR, Fy_RL, Fy_RR, Steering angle, Velocity 
% Cf- Cornering Stiffness front  Cr-Cornering Stiffness rear 

%Outputs - Torque Differential

%% Calculating Values needed 

%Working out front axle to CG
lf=Car.Dimension.xCoG*Car.Dimension.lWheelbase;
%Working out rear axle to CG
lr=(1-Car.Dimension.xCoG)*Car.Dimension.lWheelbase;
%Working out Cornering stiffness front 
Cf=CS_exp_model(Fz_front);
%Working out Cornering stiffness rear
Cr=CS_exp_model(Fz_rear);

%Calculating parameter g
g=(4*Cf*Cr*lf*lr-2*Cf*lf*Car.Mass.Total*velocity^2)/(Car.Mass.Total*velocity^2+2*(Cf*lf-Cr*lr));

%% Working out original Mz and desired Mz

Mz_1=lf*(Fy_tyres(1)+Fy_tyres(2)) - lr*(Fy_tyres(3)+Fy_tyres(4));
Mz_2=g*curve_d;

%% Working out Delta_T

Delta_T=(2*(Mz_2-Mz_1)*Car.Dimension.WheelFL.Radius)/Car.Dimension.Width;
b=0;







