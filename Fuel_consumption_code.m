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

T1_engine = Engine_Torque(v1,Car.Dimension.WheelRL.Radius,Car.Powertrain.Engine) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
T1_engine = sum(T1_engine);

T1_motor = Motor_Torque(v1,Car.Dimension.WheelRL.Radius,Car.Powertrain.Motor) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
                    
T1_motor = sum(T1_motor);

T1_total = T1_engine + T1_motor; 

T2_engine = Engine_Torque(v2,Car.Dimension.WheelRL.Radius,Car.Powertrain.Engine) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
                    
T2_engine = sum(T2_engine);
                    
T2_motor = Motor_Torque(v2,Car.Dimension.WheelRL.Radius,Car.Powertrain.Motor) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
                    
T2_motor = sum(T2_motor);
                    
T2_total = T2_engine + T2_motor;                     

%l/m3
petrol_density=0.74;

%Drag for the 2 velocities
D1 = 0.5*Environment.Density*v1^2*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;
D2 = 0.5*Environment.Density*v2^2*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;

%Thrust Factor
TFactor1 = D1/T1_total;
TFactor2 = D2/T2_total;

%Mass flow rate at the 2 vels
mdot1=((4.1*petrol_density)/100000)*v1;
mdot2=((5.3*petrol_density)/100000)*v2;

%Getting two points of rthrottle and mdot
Tenginepoints= [T1_engine*TFactor1 T2_engine*TFactor2];
mdotpoints=[mdot1 mdot2]; 

%Getting a linear relationship between rthrottle and mdot
p=polyfit(Tenginepoints,mdotpoints,1);
Tengine=linspace(0,5000);
mdot=polyval(p,Tengine);

figure
plot(Tengine,mdot);

