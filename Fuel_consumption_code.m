%Script to work out fuel consumption (Assuming Linear Rate)
%Housekeeping
clear
clc

%Fuel Cosumption 
%25 m/s -> 4.1 kg/ 100000 m
%33.3333 m/s -> 5.3 kg/ 100000 m


[Car,Environment] = Load_Params();

%Velocities in m/s, max thrust and petrol density  
v1=25;
v2=33.333;
Tmax=(Car.Powertrain.MaxTorque/Car.Dimension.WheelFL.Radius)*2;
petrol_density=0.74;

%Drag for the 2 velocities
D1 = 0.5*Environment.Density*v1^2*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;
D2 = 0.5*Environment.Density*v2^2*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;

%Thrust for the two vel
T1=D1;
T2=D2;

%Mass flow rate at the 2 vels
mdot1=((4.1*petrol_density)/100000)*v1;
mdot2=((5.3*petrol_density)/100000)*v2;

%Getting two points of rthrottle and mdot
rthrottlepoints= [T1/Tmax T2/Tmax];
mdotpoints=[mdot1 mdot2]; 

%Getting a linear relationship between rthrottle and mdot
p=polyfit(rthrottlepoints,mdotpoints,1);
rthrottle=linspace(0,1);
mdot=polyval(p,rthrottle);

figure
plot(rthrottle,mdot);

