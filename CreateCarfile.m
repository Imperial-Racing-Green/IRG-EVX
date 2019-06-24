clear
clc
% Script to generate carfile
name = 'HEV1';

Car.Category = 'Hybrid';        % ICE/EV/Hybrid

% Car component masses (kg)
% Wheels (tyre + rim + upright)
Car.Mass.WheelFL = 3.63 + 1.66 + 0.37;
Car.Mass.WheelFR = 3.63 + 1.66 + 0.37;
Car.Mass.WheelRL = 3.63 + 1.66 + 0.52;
Car.Mass.WheelRR = 3.63 + 1.66 + 0.52;
% Driver
Car.Mass.Driver = 68;
% Suspension
Car.Mass.Suspension = 11;
% Chassis (plus anti-intrusion plate, impact attenuator and jackoing bar)
Car.Mass.Chassis = 24.1 + 2.14;
% Battery (plus controller)
Car.Mass.Battery = 33.75;
% Engine
Car.Mass.Engine = 70;
% Motors (plus controllers)
Car.Mass.Motors = 2.93*2;
Car.Mass.MotorControllers = 6.8*2;
Car.Mass.MotorGears = 3.86*2;
% Steering 
Car.Mass.Steering = 3.97;
% Pedals
Car.Mass.Pedals = 2.5;
% Seat (plus headrest)
Car.Mass.Seat = 5;
% Firewall
Car.Mass.FireWall = 2.547;
% Cooling (including radiator)
Car.Mass.Cooling = 5;
% Aero
Car.Mass.FrontWing = 9.32; 
Car.Mass.RearWing = 6.45;
Car.Mass.Floor = 6.65; % Including diffuser
Car.Mass.Bodywork = 0; % Sidepods/bargeboards
% Brakes
Car.Mass.Brakes = 4*1.103;
% Fuel tank (plus some fuel)
Car.Mass.Fueltank = 5;
% Misc (random mass in order to reach actual weight)
Car.Mass.Misc = 38;
% Total
Car.Mass.Total = Car.Mass.WheelFL + Car.Mass.WheelFR + Car.Mass.WheelRL + Car.Mass.WheelRR + ...
                 Car.Mass.Driver + Car.Mass.Suspension + Car.Mass.Chassis + Car.Mass.Battery + ...
                 Car.Mass.Engine + Car.Mass.Motors + Car.Mass.MotorControllers + Car.Mass.MotorGears + ...
                 Car.Mass.Steering + Car.Mass.Pedals + Car.Mass.Seat + Car.Mass.FireWall + ...
                 Car.Mass.Cooling + Car.Mass.FrontWing + Car.Mass.RearWing + Car.Mass.Floor + ...
                 Car.Mass.Bodywork + Car.Mass.Brakes + Car.Mass.Fueltank + Car.Mass.Misc;

% Car dimensions (m)
Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2032; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
Car.Dimension.Front_track = 1.2;
Car.Dimension.Rear_track = 1.2;
Car.Dimension.Height = 1.4;
Car.Dimension.FrontalArea = 1;
Car.Dimension.lWheelbase = 1.55;
Car.Dimension.CoG = [0.8525, 0, 0.300]; % Behind front axle
Car.Dimension.CoP = [0.9300, 0, 0.37]; % Behind front axle

% Percentage of axle separation length from front axles 
Car.Balance.CoG = [Car.Dimension.CoG(1)/Car.Dimension.lWheelbase, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; %[Car.Dimension.xCoG/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoG/Car.Dimension.Height]; 
Car.Balance.CoP = [Car.Dimension.CoP(1)/Car.Dimension.lWheelbase, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; %[Car.Dimension.xCoP/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoP/Car.Dimension.Height];

% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.020; % Need updated number for Hoosier tyres
Car.Tyres.Camber.FL = -0.4;
Car.Tyres.Camber.FR = -0.4;
Car.Tyres.Camber.RL = -1.2;
Car.Tyres.Camber.RR = -1.2;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;

% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 3.56;
Car.Powertrain.Engine.RPM_Idle = 2000;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 53.75;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 9200;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 68;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 13000;                   % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 52;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 23000;    % Max power (W)
Car.Powertrain.Motor.Kv = 200;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 125;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 10;
Car.Powertrain.Motor.Efficiencies.Motor = 0.87;
Car.Powertrain.Motor.Efficiencies.Gears = 0.941;
Car.Powertrain.Motor.Config = 'fwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)

% Brakes info
Car.Brakes.FPedalMax = 1500;                                           % (N) 
Car.Brakes.BrakeBias = 0.6757;                                                        % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3                                          % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2;                                                      % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3;                                  % Piston diameter (m)
Car.Brakes.Rear.dPiston =  25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2;                       % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.254;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.254;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;

% Car aero performance
Car.AeroPerformance.C_L = 2.45; %1.78; %3.0;
Car.AeroPerformance.C_D = 1.45; %0.731; %1.15;
Car.AeroPerformance.hRideF = 0.030; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.030; % (m)
Car.AeroPerformance.Initial_AoA = 5; % (deg)
Car.AeroPerformance.dCl_dalpha = 0.1; % (/deg)

% Steering
Car.Steering.Ratio = 5.8;

% Environment condtions
Environment.Gravity = -9.81;                    % (m/s^2)
Environment.Density = 1.2126;                     % (kg/m^3)
Environment.Temperature.Air = 18 + 273.15;      % (K)
Environment.Temperature.Track = 30 + 273.15;    % (K)
Environment.Pressure = 101325;                  % (Pa)

load([pwd,'\kinematics\geometries\EV3 Front Hardpoints 13.01.19.mat']);
Car.Sus.Front.Hardpoints = hardpoints_front;
Car.Sus.Front.Stiffness.Vertical = 80000; %40000;
Car.Sus.Front.Stiffness.Horizontal = 80000; %40000;
load([pwd,'\kinematics\geometries\Final rear Outboard 01.02.19.mat']);
Car.Sus.Rear.Hardpoints = hardpoints_front;
Car.Sus.Rear.Stiffness.Vertical = 75000; %40000;
Car.Sus.Rear.Stiffness.Horizontal = 75000; %40000;

save(name,'Car')