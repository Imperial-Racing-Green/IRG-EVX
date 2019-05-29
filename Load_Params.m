function [Car,Environment] = Load_Params()

Car.Category = 'Hybrid';        % ICE/EV/Hybrid

% Car component masses (kg)
% Wheels (tyre + rim)
Car.Mass.WheelFL = 2.68 + 4;
Car.Mass.WheelFR = 2.68 + 4;
Car.Mass.WheelRL = 2.68 + 4;
Car.Mass.WheelRR = 2.68 + 4;
% Driver
Car.Mass.Driver = 68;
% Suspension
Car.Mass.Suspension = 24;
% Chassis (front + rear)
Car.Mass.Chassis = 22.5 + 7.5;
% Battery
Car.Mass.Battery = 27.5;
% Engine
Car.Mass.Engine = 70;
% Motors (plus controller)
Car.Mass.Motors = 12.6; %(6.9*2) + (7*2);
% Steering 
Car.Mass.Steering = 3.5;
% Pedals
Car.Mass.Pedals = 2.5;
% Seat
Car.Mass.Seat = 5;
% Firewall
Car.Mass.FireWall = 4.4;
% Cooling 
Car.Mass.Cooling = 5;
% Electrics
Car.Mass.Electrics = 10;
% Aero
Car.Mass.FrontWing = 7; 
Car.Mass.RearWing = 6;
% Brakes
Car.Mass.Brakes = 4*2.3518;
% Fuel tank (plus some fuel)
Car.Mass.Fueltank = 5;
% Total
Car.Mass.Total = Car.Mass.WheelFL + Car.Mass.WheelFR + Car.Mass.WheelRL + Car.Mass.WheelRR + ...
                 Car.Mass.Driver + Car.Mass.Suspension + Car.Mass.Chassis + Car.Mass.Battery + ...
                 Car.Mass.Engine + Car.Mass.Motors + Car.Mass.Steering + Car.Mass.Pedals + ...
                 Car.Mass.Seat + Car.Mass.FireWall + Car.Mass.Cooling + Car.Mass.Electrics + ...
                 Car.Mass.FrontWing + Car.Mass.RearWing + Car.Mass.Brakes + Car.Mass.Fueltank;
             
Car.Stiffness.Chassis = 50000;

% Car dimensions (m)
Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2032; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
Car.Dimension.Front_track = 1.417;
Car.Dimension.Rear_track = 1.417;
Car.Dimension.Height = 1.4;
Car.Dimension.FrontalArea = 1.5;
Car.Dimension.lWheelbase = 1.55;
Car.Dimension.CoG = [0.8029, 0, 0.3]; % Behind front axle
Car.Dimension.CoP = [0.8525, 0, 0.37]; % Behind front axle

% Percentage of axle separation length from front axles 
Car.Balance.CoG = [0.50, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; %[Car.Dimension.xCoG/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoG/Car.Dimension.Height]; 
Car.Balance.CoP = [0.55, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; %[Car.Dimension.xCoP/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoP/Car.Dimension.Height];

% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.018; % Need updated number for Hoosier tyres

% Powertrain info
% Engine
Car.Powertrain.Engine.MaxPower = 79000;    % (W) (80000
Car.Powertrain.Engine.MaxTorque = 69;     % (Nm) (240)
Car.Powertrain.Engine.TransmissionRatio = 3.6;
Car.Powertrain.Engine.T_Max = 68;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 13000;                   % Max RPM  [R/Min] 
Car.Powertrain.Engine.RPM_Max_T = 9200;                      % RPM corresponding to max torque
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.MaxPower = 23000; %60000;    % (W)
Car.Powertrain.Motor.MaxTorque = 8.8*2; %180;     % (Nm)
Car.Powertrain.Motor.TransmissionRatio = 7;
Car.Powertrain.Motor.RPM_Lim = 25000; 
Car.Powertrain.Motor.T_Stall = 35.14;
Car.Powertrain.Motor.T_Cap = 27; %9;
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

% Car aero performance
Car.AeroPerformance.C_L = 3.0;
Car.AeroPerformance.C_D = 1.15;
Car.AeroPerformance.hRideF = 0.1; % (m)
Car.AeroPerformance.hRideR = 0.3; % (m)
Car.AeroPerformance.Initial_AoA = 5; % (deg)
Car.AeroPerformance.dCl_dalpha = 0.1; % (/deg)

% Environment condtions
Environment.Gravity = -9.81;                    % (m/s^2)
Environment.Density = 1.2126;                     % (kg/m^3)
Environment.Temperature.Air = 18 + 273.15;      % (K)
Environment.Temperature.Track = 30 + 273.15;    % (K)
Environment.Pressure = 101325;                  % (Pa)

load([pwd,'\kinematics\geometries\EV3 Front Hardpoints 13.01.19.mat']);
Car.Sus.Front.Hardpoints = hardpoints_front;
Car.Sus.Front.Stiffness.Vertical = 40000;
Car.Sus.Front.Stiffness.Horizontal = 40000;
load([pwd,'\kinematics\geometries\Final rear Outboard 01.02.19.mat']);
Car.Sus.Rear.Hardpoints = hardpoints_front;
Car.Sus.Rear.Stiffness.Vertical = 40000;
Car.Sus.Rear.Stiffness.Horizontal = 40000;