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

% Percentage of axle separation length from front axles 
Car.Balance.CoG = 0.55; 
Car.Balance.Aerobalance = 0.55;

% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.018; % Need updated number for Hoosier tyres

% Powertrain info
% Engine
Car.Powertrain.Engine.MaxPower = 79000;    % (W) (80000
Car.Powertrain.Engine.MaxTorque = 69;     % (Nm) (240)
Car.Powertrain.Engine.TransmissionRatio = 3;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor
Car.Powertrain.Motor.MaxPower = 46000;    % (W)
Car.Powertrain.Motor.MaxTorque = 220;     % (Nm)
Car.Powertrain.Motor.TransmissionRatio = 3;
Car.Powertrain.Motor.Config = 'fwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)

% Brakes info
Car.Brakes.FPedalMax = 120*4.44822162825;                                           % (N)
Car.Brakes.BrakeBias = 0.66;                                                        % > 0.5 is biased towards front
Car.Brakes.PedalMotionRatio = 6;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3                                          % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55; % 0.42
Car.Brakes.Rear.PadFrictionCoefficent = 0.55; % 0.42
Car.Brakes.Front.nPistons = 2;                                                      % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dPiston = 0.03175; % 25.4e-3                                       % Piston diameter (m)
Car.Brakes.Rear.dPiston =  0.03175; % 25.4e-3
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2;                       % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.254; % 0.22                                              % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.254; % 0.18
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254; % (5/8)*25.4e-3                         % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254; % (3/4)*25.4e-3
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;

% Car dimensions
Car.Dimension.WheelFL.Radius = 0.175;
Car.Dimension.WheelFR.Radius = 0.175;
Car.Dimension.WheelRL.Radius = 0.175;
Car.Dimension.WheelRR.Radius = 0.175;
Car.Dimension.FrontalArea = 1.2*1.4;

% Car aero performance
Car.AeroPerformance.C_L = 2.3;
Car.AeroPerformance.C_D = 1.9;

% Environment condtions
Environment.Gravity = -9.81;                    % (m/s^2)
Environment.Density = 1.19;                     % (kg/m^3)
Environment.Temperature.Air = 18 + 273.15;      % (K)
Environment.Temperature.Track = 30 + 273.15;    % (K)
Environment.Pressure = 101325;                  % (Pa)

load([pwd,'\kinematics\geometries\EV3 Front Hardpoints 13.01.19.mat']);
Car.Sus.Front.Hardpoints = hardpoints_front;
load([pwd,'\kinematics\geometries\Final rear Outboard 01.02.19.mat']);
Car.Sus.Rear.Hardpoints = hardpoints_front;