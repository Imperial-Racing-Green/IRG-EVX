function [Car,Environment] = Load_Params()

Car.Category = 'Hybrid';        % ICE/EV/Hybrid

% Car mass (including 70kg driver) (kg)
Car.Mass.Total = 315.459;

% Car dimensions (m)
Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2032; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
Car.Dimension.Front_track = 1.2;
Car.Dimension.Rear_track = 1.2;
Car.Dimension.Height = 1.4;
Car.Dimension.lWheelbase = 1.55;
Car.Dimension.CoG = [0.73315, 0, 0.309]; % Behind front axle
Car.Dimension.CoP = [0.9300, 0, 0.37]; % Behind front axle
Car.Dimension.zRollCentreF = 28.6/1000;
Car.Dimension.zRollCentreR = 25.7/1000;

% Percentage of axle separation length from front axles 
Car.Balance.CoG = [Car.Dimension.CoG(1)/Car.Dimension.lWheelbase, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; %[Car.Dimension.xCoG/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoG/Car.Dimension.Height]; 
% Car.Balance.CoP = [Car.Dimension.CoP(1)/Car.Dimension.lWheelbase, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; %[Car.Dimension.xCoP/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoP/Car.Dimension.Height];
Car.Balance.CoP = [0.341, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; %[Car.Dimension.xCoP/Car.Dimension.lWheelbase, 0, Car.Dimension.zCoP/Car.Dimension.Height];

% Tyre info
Car.Tyres = load('TyreMap.mat'); % Load in tyre map for pacejka coefficent for Hoosier tyres
Car.Tyres.Coefficients.RollingResistance = 0.020; % Need updated number for Hoosier tyres
Car.Tyres.Camber.FL = -0.65; %-0.4;
Car.Tyres.Camber.FR = -0.65; %-0.4;
Car.Tyres.Camber.RL = -0.40; %-1.2;
Car.Tyres.Camber.RR = -0.40; %-1.2;
Car.Tyres.CamberRollFactor.Front = 0.4; %0.325;     (deg/deg)
Car.Tyres.CamberRollFactor.Rear = 0.13; %1.1;       (deg/deg)
Car.Tyres.CamberRideFactor.Front = -41.0;         % (deg/m)
Car.Tyres.CamberRideFactor.Rear = -11.0;          % (deg/m)

% Powertrain info
% Engine
Car.Powertrain.Engine.FinalDriveRatio = 3.56; % 5.18;
Car.Powertrain.Engine.RPM_Idle = 3000;                      % Idle RPM
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
Car.Powertrain.Motor.TransmissionRatio = 8;
Car.Powertrain.Motor.Efficiencies.Motor = 0.87;
Car.Powertrain.Motor.Efficiencies.Gears = 0.941;
Car.Powertrain.Motor.Config = 'fwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)

% Define gears
Car.Gears = table([1; 2; 3; 4; 5; 6],...
                  [NaN; 12.6443; 19.4528; 25.8860; 34.1266; 42.8187],...
                  [10.4906; 18.6993; 28.7681; 38.2820; 50.4686; NaN],...
                  [4.171; 2.340; 1.521; 1.143; 0.867; 0.691]);
Car.Gears.Properties.VariableNames = {'NGear','vCar_ShiftDown','vCar_ShiftUp','Ratio'};
% [15.39;19.17;22.75;26.39;28.75;31.33] Speeds for MaxPower at each gear

% Brakes info
Car.Brakes.FPedalMax = 1800;                                           % (N) 
Car.Brakes.BrakeBias = 0.57; %0.6757;                                                        % > 0.5 is biased towards front - might change with weight / CG
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;

% Car aero performance
Car.AeroPerformance.SC_L = 3.0;
Car.AeroPerformance.SC_D = 1.5;
Car.AeroPerformance.hRideF = 0.030; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.030; % (m)
Car.AeroPerformance.Aeromap = GenerateAeromap();

% Steering
Car.Steering.Ratio = 5.8;

% Environment conditions
Environment.Gravity = -9.81;                    % (m/s^2)
Environment.Density = 1.2126;                     % (kg/m^3)
Environment.Temperature.Air = 18 + 273.15;      % (K)
Environment.Temperature.Track = 30 + 273.15;    % (K)
Environment.Pressure = 101325;                  % (Pa)

load([pwd,'\kinematics\geometries\EV3 Front Hardpoints 13.01.19.mat']);
Car.Sus.Front.Hardpoints = hardpoints_front;
Car.Sus.Front.Stiffness.Vertical = 60000; 
Car.Sus.Front.Stiffness.Horizontal = 60000;
Car.Sus.Front.MotionRatio = 0.83;
load([pwd,'\kinematics\geometries\Final rear Outboard 01.02.19.mat']);
Car.Sus.Rear.Hardpoints = hardpoints_front;
Car.Sus.Rear.Stiffness.Vertical = 40000;
Car.Sus.Rear.Stiffness.Horizontal = 40000;
Car.Sus.Rear.MotionRatio = 0.83;

save('Baseline_Carfile','Car')
save('Baseline_Weatherfile','Environment')