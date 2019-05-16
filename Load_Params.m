function [Car,Environment] = Load_Params()

% Car component masses (kg)
Car.Mass.Chassis = 200;
Car.Mass.WheelFL = 10;
Car.Mass.WheelFR = 10;
Car.Mass.WheelRL = 10;
Car.Mass.WheelRR = 10;
Car.Mass.Driver = 70;
Car.Mass.FrontWing = 7; 
Car.Mass.RearWing = 10;
Car.Mass.Total = Car.Mass.Chassis + Car.Mass.WheelFL +...
                 Car.Mass.WheelFR + Car.Mass.WheelRL +...
                 Car.Mass.WheelRR + Car.Mass.Driver + ...
                 Car.Mass.FrontWing + Car.Mass.RearWing;

Car.Stifness.Chassis = 50000;

% Percentage of car length from most frontwards point 
Car.Balance.CoG = 0.60; 
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