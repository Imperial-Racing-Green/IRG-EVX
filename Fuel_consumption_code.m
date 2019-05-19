%Script to work out fuel consumption (Assuming Linear Rate)
%Housekeeping
clear
clc

%Fuel Cosumption 
%25 m/s -> 4.1 kg/ 1000000 m
%33.3333 m/s -> 5.3 kg/ 1000000 m

v1=25;
v2=33.333;
Tmax=1775;

[Car,Environment] = Load_Params();

D1 = 0.5*Environment.Density*v1^2*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;
D2 = 0.5*Environment.Density*v2^2*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;

T1=D1;
T2=D2;

mdot1=(4.1/1000000)*v1;
mdot2=(5.3/1000000)*v2;

rthrottle = [T1/Tmax T2/Tmax];
mdot=[mdot1 mdot2]; 

p=polyfit(rthrottle,mdot,1);

xval=[0 100];
yval=polyval(p,xval);

figure
plot(xval,yval);



