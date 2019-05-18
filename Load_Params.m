function [Car,Environment] = Load_Params()

% Car component masses (kg)
% Wheels (tyre + rim)
Car.Mass.WheelFL = 2.5 + 1.75;
Car.Mass.WheelFR = 2.5 + 1.75;
Car.Mass.WheelRL = 2.5 + 1.75;
Car.Mass.WheelRR = 2.5 + 1.75;
% Driver
Car.Mass.Driver = 68;
% Suspension
Car.Mass.Suspension = 24;
% Chassis (front + rear)
Car.Mass.Chassis = 22.5 + 7.5;
% Battery
Car.Mass.Battery = 52.5;
% Powertrain
Car.Mass.Powertrain = 50;
% Steering 
Car.Mass.Steering = 5;
% Pedals
Car.Mass.Pedals = 2.5;
% Firewall
Car.Mass.Seat_Firewall = 5;
% Cooling 
Car.Mass.Cooling = 5;
% Electrics
Car.Mass.Electrics = 10;
% Aero
Car.Mass.FrontWing = 7; 
Car.Mass.RearWing = 10;
% Total
Car.Mass.Total = Car.Mass.WheelFL + Car.Mass.WheelFR + Car.Mass.WheelRL + Car.Mass.WheelRR + ...
                 Car.Mass.Driver + Car.Mass.Suspension + Car.Mass.Chassis + Car.Mass.Battery + ...
                 Car.Mass.Powertrain + Car.Mass.Steering + Car.Mass.Pedals + Car.Mass.Seat_Firewall + ...
                 Car.Mass.Cooling + Car.Mass.Electrics + Car.Mass.FrontWing + Car.Mass.RearWing;

Car.Stiffness.Chassis = 50000;

% Percentage of car length from most frontwards point 
Car.Balance.CoG = 0.55; 
Car.Balance.Aerobalance = 0.55;

% Environment condtions
Environment.Gravity = -9.81;                    % (m/s^2)
Environment.Density = 1.19;                     % (kg/m^3)
Environment.Temperature.Air = 18 + 273.15;      % (K)
Environment.Temperature.Track = 30 + 273.15;    % (K)
Environment.Pressure = 101325;                  % (Pa)

% Car dimensions
Car.Dimension.WheelFL.Radius = 0.175;
Car.Dimension.WheelFR.Radius = 0.175;
Car.Dimension.WheelRL.Radius = 0.175;
Car.Dimension.WheelRR.Radius = 0.175;
Car.Dimension.FrontalArea = 1.2*1.4;

% Car aero performance
Car.AeroPerformance.C_L = 2.57;
Car.AeroPerformance.C_D = 1.33;

load([pwd,'\kinematics\geometries\EV3 Front Hardpoints 13.01.19.mat']);
Car.Sus.Front.Hardpoints = hardpoints_front;
load([pwd,'\kinematics\geometries\Final rear Outboard 01.02.19.mat']);
Car.Sus.Rear.Hardpoints = hardpoints_front;