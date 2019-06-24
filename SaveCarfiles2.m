% This script allows the saving and editing of other teams carfiles
clear
clc

%% Car Parameters (Bath 2018)
Car.Year = '2018';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 10.61;
Car.Points.SkidPad = 18.41;
Car.Points.Autocross = 102.47;
Car.Points.Endurance = 0; 
Car.Points.FuelEfficiency = 0;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 238;
Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2032; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
Car.Dimension.Front_track = 1.131;
Car.Dimension.Rear_track = 1.131;
Car.Dimension.Height = 1.340;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.lWheelbase = 1.540;
Car.Dimension.CoG = [0.793, 0, 0.311]; % Behind front axle
Car.Dimension.CoP = [0.793, 0, 0.311]; % Behind front axle
Car.Balance.CoG = [0.515, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; 
Car.Balance.CoP = [0.55, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; 
% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 3;
Car.Powertrain.Engine.RPM_Idle = 2000;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 45;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 5500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 63;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 9000;                  % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 45;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0;    % Max power (W)
Car.Powertrain.Motor.Kv = 0;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0;
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
% Car aero performance
Car.AeroPerformance.C_L = 2.0;
Car.AeroPerformance.C_D = 1.15;
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
% Steering
Car.Steering.Ratio = 7;
% Suspension
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Bath_18.mat')
clear


%% Car Parameters (Bath 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 44.9;
Car.Points.SkidPad = 28.7;
Car.Points.Autocross = 90.0;
Car.Points.Endurance = 205.8; 
Car.Points.FuelEfficiency = 59.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 238;
Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2032; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
Car.Dimension.Front_track = 1.131;
Car.Dimension.Rear_track = 1.131;
Car.Dimension.Height = 1.340;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.lWheelbase = 1.540;
Car.Dimension.CoG = [0.793, 0, 0.311]; % Behind front axle
Car.Dimension.CoP = [0.793, 0, 0.311]; % Behind front axle
Car.Balance.CoG = [0.515, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; 
Car.Balance.CoP = [0.55, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; 
% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 3;
Car.Powertrain.Engine.RPM_Idle = 1000;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 61;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 5500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 63;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 10000;                   % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 61;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0;    % Max power (W)
Car.Powertrain.Motor.Kv = 0;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0;
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
% Car aero performance
Car.AeroPerformance.C_L = 2.7;
Car.AeroPerformance.C_D = 1.15;
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
% Steering
Car.Steering.Ratio = 7;
% Suspension
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Bath_16.mat')
clear


%% Car Parameters (CATALUNYA 2016)
Car.Year = '2016';
Car.Category = 'EV';        % ICE/EV/Hybrid
Car.Points.Acceleration = 38.72;
Car.Points.SkidPad = 18.28;
Car.Points.Autocross = 84.90; %58.13;
Car.Points.Endurance = 132.8; %132.0;
Car.Points.FuelEfficiency = 100;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 278;
Car.Dimension.WheelFL.Radius = 0.2667;  % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2667; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2667;
Car.Dimension.WheelRR.Radius = 0.2667;
Car.Dimension.Front_track = 1150/1000;
Car.Dimension.Rear_track = 1100/1000;
Car.Dimension.Height = 1.325;
Car.Dimension.FrontalArea = 1;
Car.Dimension.lWheelbase = 1525/1000;
Car.Dimension.CoG = [0.5*Car.Dimension.lWheelbase, 0, 300/1000]; % Behind front axle
Car.Dimension.CoP = [0.5*Car.Dimension.lWheelbase, 0, 300/1000]; % Behind front axle
Car.Balance.CoG = [0.5, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; 
Car.Balance.CoP = [0.5, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; 
% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 0;
Car.Powertrain.Engine.RPM_Idle = 0;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 0;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 0;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 0;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 0;                  % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 0;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 50000; %100000;    % Max power (W)
Car.Powertrain.Motor.Kv = 100;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 120;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 3.82;
Car.Powertrain.Motor.Efficiencies.Motor = 0.87;
Car.Powertrain.Motor.Efficiencies.Gears = 0.941;
Car.Powertrain.Motor.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
% Car aero performance
Car.AeroPerformance.C_L = 0.05;
Car.AeroPerformance.C_D = 1.15;
Car.AeroPerformance.hRideF = 0.038;     % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038;     % (m)
% Steering
Car.Steering.Ratio = 7;
% Suspension
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('cata.mat')
clear


%% Car Parameters (Aachen 2015)
Car.Year = '2015';
Car.Category = 'EV';        % ICE/EV/Hybrid
Car.Points.Acceleration = 0; % Didn't enter
Car.Points.SkidPad = 32.94; %27.18;
Car.Points.Autocross = 89.02; %19.31;
Car.Points.Endurance = 178.0; %161.2;
Car.Points.FuelEfficiency = 95.2;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 272;
Car.Dimension.WheelFL.Radius = 0.2667;  % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2667; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2667;
Car.Dimension.WheelRR.Radius = 0.2667;
Car.Dimension.Front_track = 1250/1000;
Car.Dimension.Rear_track = 1200/1000;
Car.Dimension.Height = 1.325;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.lWheelbase = 1530/1000;
Car.Dimension.CoG = [0.55*Car.Dimension.lWheelbase, 0, 300/1000]; % Behind front axle
Car.Dimension.CoP = [0.5*Car.Dimension.lWheelbase, 0, 300/1000]; % Behind front axle
Car.Balance.CoG = [0.55, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; 
Car.Balance.CoP = [0.5, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; 
% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 0;
Car.Powertrain.Engine.RPM_Idle = 0;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 0;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 0;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 0;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 0; %8500;                   % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 0;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 80000;    % Max power (W)
Car.Powertrain.Motor.Kv = 100;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 100;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 6.39;
Car.Powertrain.Motor.Efficiencies.Motor = 0.77;   %0.87
Car.Powertrain.Motor.Efficiencies.Gears = 0.9;    %0.941
Car.Powertrain.Motor.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
% Car aero performance
Car.AeroPerformance.C_L = 2.2;       %2.7
Car.AeroPerformance.C_D = 1.35;      %1.15
Car.AeroPerformance.hRideF = 0.038;     % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038;     % (m)
% Steering
Car.Steering.Ratio = 7;
% Suspension
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('aachen.mat')
clear


%% Car Parameters (West Bohemia 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 51.6;
Car.Points.SkidPad = 10.2;
Car.Points.Autocross = 63.7;
Car.Points.Endurance = 123.7; %118.3;
Car.Points.FuelEfficiency = 51.9;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 313;
Car.Dimension.WheelFL.Radius = 0.230;  % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.230; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
Car.Dimension.Front_track = 1220/1000;
Car.Dimension.Rear_track = 1180/1000;
Car.Dimension.Height = 1.460;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.lWheelbase = 1565/1000;
Car.Dimension.CoG = [0.5367*Car.Dimension.lWheelbase, 0, 300/1000]; % Behind front axle
Car.Dimension.CoP = [0.55*Car.Dimension.lWheelbase, 0, 300/1000]; % Behind front axle
Car.Balance.CoG = [0.5367, 0, Car.Dimension.CoG(3)/Car.Dimension.Height]; 
Car.Balance.CoP = [0.55, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; 
% Tyre info
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 4.5;
Car.Powertrain.Engine.RPM_Idle = 3300;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 52;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 8900;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 58;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 14500;                  % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 52;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0;    % Max power (W)
Car.Powertrain.Motor.Kv = 0;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0;
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
% Car aero performance
Car.AeroPerformance.C_L = 2.7;
Car.AeroPerformance.C_D = 1.15;
Car.AeroPerformance.hRideF = 0.038;     % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038;     % (m)
% Steering
Car.Steering.Ratio = 7;
% Suspension
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('West_Bohemia_16.mat')
clear


%% Car Parameters (CTU Prague 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 45.6;
Car.Points.SkidPad = 37.1;
Car.Points.Autocross = 101.3;
Car.Points.Endurance = 256.9; %245.1;
Car.Points.FuelEfficiency = 50.4;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 268;
Car.Dimension.lWheelbase = 1578/1000;
Car.Dimension.Front_track = 1214/1000;
Car.Dimension.Rear_track = 1214/1000;
Car.Dimension.Height = 1.460;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.4;         %2.7                 % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
Car.Dimension.CoG = [0.55*Car.Dimension.lWheelbase, 0, 300/1000];   % height unknown
Car.Dimension.CoP = [800/1000, 0, 300/1000];
Car.Balance.CoG = [0.55, 0, 0.25];
Car.Balance.CoP = [0.5070, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Car dimensions (m)
Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
Car.Dimension.WheelFR.Radius = 0.2032; % (10" tyres = 0.2032m total radius, 13" tyres = 0.2413m total radius)
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
Car.Dimension.Front_track = 1.417;
Car.Dimension.Rear_track = 1.417;
Car.Dimension.Height = 1.4;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.lWheelbase = 1.55;
Car.Dimension.CoG = [0.8029, 0, 0.311]; % Behind front axle
Car.Dimension.CoP = [0.8525, 0, 0.37]; % Behind front axle
% Powertrain info
% Engine
Car.Powertrain.Engine.TransmissionRatio = 4.2;
Car.Powertrain.Engine.RPM_Idle = 2000;           % Idle RPM
Car.Powertrain.Engine.T_Idle = 52;                     % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 6500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 63;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 8000;                   % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 52;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0.6;   %0.98
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0;    % Max power (W)
Car.Powertrain.Motor.Kv = 0;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Brakes info
Car.Brakes.FPedalMax = 600;              %750                             % ? 
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
% Steering
Car.Steering.Ratio = 7;
% Suspension
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('CTU_Prague_16.mat')
clear

%% Car Parameters (Paderborn 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 3.5;
Car.Points.SkidPad = 14.5;
Car.Points.Autocross = 78.7;
Car.Points.Endurance = 188.4; %184.7;
Car.Points.FuelEfficiency = 42.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 267;
%Dimensions
Car.Dimension.lWheelbase = 1600/1000;
Car.Dimension.Front_track = 1160/1000;
Car.Dimension.Rear_track = 1140/1000;
Car.Dimension.Height = 1.460;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.CoG = [0, 0.5506*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5506, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
%Aero
Car.AeroPerformance.C_L = 3;                          % unknown
Car.AeroPerformance.C_D = 1.4;      % unknown
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Engine
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 3.18;                               % Gear ratio
Car.Powertrain.Engine.RPM_Idle = 3000;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 57;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Limit = 13100; % Max RPM  [R/Min]        
Car.Powertrain.Engine.T_Limit = 57;                   % Torque at max RPM
Car.Powertrain.Engine.T_Max = 65;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 11300;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 63000;                       % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0;    % Max power (W)
Car.Powertrain.Motor.Kv = 0;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Brakes info
Car.Brakes.FPedalMax = 1500;                                           % ? 
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Paderborn_16.mat')
clear


%% Car Parameters (Delft 2015)
Car.Year = '2015';
Car.Category = 'EV';        % ICE/EV/Hybrid
Car.Points.Acceleration = 69.2;
Car.Points.SkidPad = 33.3;
Car.Points.Autocross = 141.9;
Car.Points.Endurance = 293.5; %292.4;
Car.Points.FuelEfficiency = 98.7;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 228;
%Dimensions
Car.Dimension.lWheelbase = 1530/1000;
Car.Dimension.Front_track = 1200/1000;
Car.Dimension.Rear_track = 1200/1000;
Car.Dimension.Height = 1.460;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.CoG = [0, 0.5088*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5088, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
%Aero
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.15;      % unknown
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Engine
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 0;                               % Gear ratio
Car.Powertrain.Engine.RPM_Idle = 0;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 0;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Limit = 0; % Max RPM  [R/Min]        
Car.Powertrain.Engine.T_Limit = 0;                   % Torque at max RPM
Car.Powertrain.Engine.T_Max = 0;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 0;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0;
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 32500;    % Max power (W)
Car.Powertrain.Motor.Kv = 100;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 110;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 10.8;
Car.Powertrain.Motor.Efficiencies.Motor = 0.87;
Car.Powertrain.Motor.Efficiencies.Gears = 0.941;
Car.Powertrain.Motor.Config = '4wd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Brakes info
Car.Brakes.FPedalMax = 1500;                                           % ? 
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Delft_15.mat')
clear


%% Car Parameters (Wroclaw 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 56.5;
Car.Points.SkidPad = 34.1;
Car.Points.Autocross = 98.6;
Car.Points.Endurance = 235.0; % 221.3;
Car.Points.FuelEfficiency = 49.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 248;
%Dimensions
Car.Dimension.lWheelbase = 1550/1000;
Car.Dimension.Front_track = 1250/1000;
Car.Dimension.Rear_track = 1250/1000;
Car.Dimension.Height = 1.460;
Car.Dimension.FrontalArea = 1.0;
Car.Dimension.CoG = [0, 0.5155*Car.Dimension.lWheelbase, 200/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5155, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.2032;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.2032;
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
%Aero
Car.AeroPerformance.C_L = 3.0;                          % unknown
Car.AeroPerformance.C_D = 1.0;      % unknown
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Engine
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 3;                               % Gear ratio
Car.Powertrain.Engine.RPM_Idle = 1000;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 61;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Limit = 14000; % Max RPM  [R/Min]        
Car.Powertrain.Engine.T_Limit = 61;                   % Torque at max RPM
Car.Powertrain.Engine.T_Max = 61;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 9000;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 62500;                       % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0;    % Max power (W)
Car.Powertrain.Motor.Kv = 0;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0;
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Brakes info
Car.Brakes.FPedalMax = 1500;                                           % ? 
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
Car.Brakes.Front.dDisk = 0.1905;                                        % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing =  (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing =  (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254;                      % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Wroclaw_16.mat')
clear


%% Car Parameters (Karlsruhe 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
%Points
Car.Points.Acceleration = 49.5;
Car.Points.SkidPad = 37.4;
Car.Points.Autocross = 115.8;
Car.Points.Endurance = 227.3; % 215.8;
Car.Points.FuelEfficiency = 69.3;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 266;
%Dimensions
Car.Dimension.lWheelbase = 1530/1000;
Car.Dimension.Front_track = 1220/1000;
Car.Dimension.Rear_track = 1150/1000;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.CoG = [0.5376*Car.Dimension.lWheelbase, 0, 300/1000];   % height unknown
Car.Dimension.CoP = [800/1000, 0, 300/1000];
Car.Balance.CoG = [0.5376, 0, 0.25];
Car.Balance.CoP = [0.5229, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
%Aero
Car.AeroPerformance.C_L = 3;              %2.7            % unknown
Car.AeroPerformance.C_D = 1.15;                         % unknown
Car.AeroPerformance.hRideF = 0.03; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.03; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0; % Max power (W)
Car.Powertrain.Motor.Kv = 0; % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0; % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd'; % (fwd/rwd/4wd front/rear/4 wheel drive)
% Engine
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 2.83;                               % Gear ratio
Car.Powertrain.Engine.RPM_Idle = 2500; % Idle RPM
Car.Powertrain.Engine.T_Idle = 90; % Torque at idle RPM
Car.Powertrain.Engine.RPM_Limit = 6000;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Limit = 90; % Torque at max RPM
Car.Powertrain.Engine.T_Max = 120;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 4500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 65000;                       % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
% Brakes info
Car.Brakes.FPedalMax = 1500; %  (N)
Car.Brakes.BrakeBias = 0.6757; % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3 % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2; % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3; % Piston diameter (m)
Car.Brakes.Rear.dPiston = 25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2; % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.1905; % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder = 0.0254; % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2; % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Karlsruhe_16.mat')
clear


%% Car Parameters (Bath 2015)
Car.Year = '2015';
Car.Category = 'ICE';        % ICE/EV/Hybrid
% Points
Car.Points.Acceleration = 34.5;
Car.Points.SkidPad = 24.2;
Car.Points.Autocross = 94.7;
Car.Points.Endurance = 300;
Car.Points.FuelEfficiency = 68.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 238;
%Dimensions
Car.Dimension.lWheelbase = 1540/1000;
Car.Dimension.Front_track = 1114/1000;
Car.Dimension.Rear_track = 1114/1000;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.CoG = [0.5147*Car.Dimension.lWheelbase, 0, 200/1000];   % height unknown
Car.Dimension.CoP = [800/1000, 0, 300/1000];
Car.Balance.CoG = [0.5147, 0, 0.25];
Car.Balance.CoP = [0.5195, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
%Aero
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.4;                         % unknown
Car.AeroPerformance.hRideF = 0.03; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.03; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0; % Max power (W)
Car.Powertrain.Motor.Kv = 0; % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0; % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd'; % (fwd/rwd/4wd front/rear/4 wheel drive)
% Engine
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 3;                               % Gear ratio
Car.Powertrain.Engine.RPM_Idle = 800; % Idle RPM
Car.Powertrain.Engine.T_Idle = 58; % Torque at idle RPM
Car.Powertrain.Engine.RPM_Limit = 10000;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Limit = 58; % Torque at max RPM
Car.Powertrain.Engine.T_Max = 59;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 5500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 51000;                       % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
% Brakes info
Car.Brakes.FPedalMax = 1500; %  
Car.Brakes.BrakeBias = 0.6757; % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3 % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2; % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3; % Piston diameter (m)
Car.Brakes.Rear.dPiston = 25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2; % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.1905; % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder = 0.0254; % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2; % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Bath_15.mat')
clear


%% Car Parameters (%Loughborough 2016)
Car.Year = '2016';
Car.Category = 'ICE'; % ICE/EV/Hybrid
Car.Points.Acceleration = 15.5;
Car.Points.SkidPad = 0;
Car.Points.Autocross = 44.1;
Car.Points.Endurance = 75.7; %
Car.Points.FuelEfficiency = 32.5;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 273;
%Dimensions
Car.Dimension.lWheelbase = 1535/1000;
Car.Dimension.Front_track = 1200/1000;
Car.Dimension.Rear_track = 1181/1000;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.CoG = [0.5*Car.Dimension.lWheelbase, 0, 300/1000]; % height unknown
Car.Dimension.CoP = [0.5*Car.Dimension.lWheelbase, 0,300/1000];
Car.Balance.CoG = [0.5, 0, 0.25];
Car.Balance.CoP = [0.5, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.2667; %0.2402; % Tyre radius [m] 13"
Car.Dimension.WheelFR.Radius = 0.2667; %0.2402;
Car.Dimension.WheelRL.Radius = 0.2667; %0.2402;
Car.Dimension.WheelRR.Radius = 0.2667; %0.2402;
%Aero
Car.AeroPerformance.C_L = 2.4; % unknown
Car.AeroPerformance.C_D = 1.15; % unknown
Car.AeroPerformance.hRideF = 0.03; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.03; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0; % Max power (W)
Car.Powertrain.Motor.Kv = 0; % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0; % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd'; % (fwd/rwd/4wd front/rear/4 wheel drive)
% Engine
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 3.1; % Gear ratio %3.1
Car.Powertrain.Engine.RPM_Idle = 4500; % Idle RPM   %5000
Car.Powertrain.Engine.T_Idle = 67; % Torque at idle RPM  %55
Car.Powertrain.Engine.RPM_Limit = 13500; % Max RPM [R/Min] %13000
Car.Powertrain.Engine.T_Limit = 67; % Torque at max RPM %55
Car.Powertrain.Engine.T_Max = 85; % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 9000; % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 79000; % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.98; %0.98
% Brakes info
Car.Brakes.FPedalMax = 1500; %  
Car.Brakes.BrakeBias = 0.6757; % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3 % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2; % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3; % Piston diameter (m)
Car.Brakes.Rear.dPiston = 25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2; % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.1905; % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder = 0.0254; % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2; % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Loughborough_16.mat')
clear


%% Car Parameters (Stuttgart 2016)
%need to clarify 'torque constant', 'voltages' %Stuttgart, RWD Combustion
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
%Points
Car.Points.Acceleration = 51.5;
Car.Points.SkidPad = 44.9;
Car.Points.Autocross = 146.4;
Car.Points.Endurance = 300;
Car.Points.FuelEfficiency = 70.8;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 253;
%Dimensions
Car.Dimension.lWheelbase = 1630/1000;
Car.Dimension.Front_track = 1140/1000;
Car.Dimension.Rear_track = 1120/1000;
Car.Dimension.FrontalArea = 1.2;
Car.Dimension.CoG = [0.5059*Car.Dimension.lWheelbase, 0, 200/1000];   % height unknown %300
Car.Dimension.CoP = [0.55*Car.Dimension.lWheelbase, 0, 300/1000];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Balance.CoG = [0.5059, 0, 0.20];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Dimension.WheelFL.Radius = 0.2032; %0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.2032; %0.230;  
Car.Dimension.WheelRL.Radius = 0.2032; %0.230;  
Car.Dimension.WheelRR.Radius = 0.2032; %0.230;  
%Aero
Car.AeroPerformance.C_L = 3.5;                          % unknown
Car.AeroPerformance.C_D = 1.15;                         % unknown
Car.AeroPerformance.hRideF = 0.038; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.038; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0; % Max power (W)
Car.Powertrain.Motor.Kv = 0; % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0; % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd'; % (fwd/rwd/4wd front/rear/4 wheel drive)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 2.7;                     % Gear ratio
Car.Powertrain.Engine.RPM_Idle = 1200; % Idle RPM  
Car.Powertrain.Engine.T_Idle = 67; % Torque at idle RPM
Car.Powertrain.Engine.RPM_Limit = 11000;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Limit = 67; % Torque at max RPM 
Car.Powertrain.Engine.T_Max = 68;                   % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 7500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 62500;                       % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.99;
% Brakes info
Car.Brakes.FPedalMax = 1500; %  
Car.Brakes.BrakeBias = 0.6757; % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3 % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2; % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3; % Piston diameter (m)
Car.Brakes.Rear.dPiston = 25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2; % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.1905; % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder = 0.0254; % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2; % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 70000;
Car.Sus.Rear.Stiffness.Vertical = 65000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Stuttgart_16.mat')
clear


%% Car Parameters (%Loughborough 2018)
Car.Year = '2018';
Car.Category = 'ICE'; % ICE/EV/Hybrid
Car.Points.Acceleration = 60.4;
Car.Points.SkidPad = 26.3;
Car.Points.Autocross = 77.9;
Car.Points.Endurance = 173.5; %
Car.Points.FuelEfficiency = 34.4;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 265;
%Dimensions
Car.Dimension.lWheelbase = 1547/1000;
Car.Dimension.Front_track = 1300/1000;
Car.Dimension.Rear_track = 1150/1000;
Car.Dimension.FrontalArea = 1.0;
Car.Dimension.CoG = [0.5*Car.Dimension.lWheelbase, 0, 300/1000]; % height unknown
Car.Dimension.CoP = [0.5*Car.Dimension.lWheelbase, 0, 300/1000];
Car.Balance.CoG = [0.5, 0, 0.25];
Car.Balance.CoP = [0.5, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.2302; % Tyre radius [m] 13"
Car.Dimension.WheelFR.Radius = 0.2302;
Car.Dimension.WheelRL.Radius = 0.2302;
Car.Dimension.WheelRR.Radius = 0.2302;
%Aero
Car.AeroPerformance.C_L = 0.05; % unknown
Car.AeroPerformance.C_D = 0.5; % unknown
Car.AeroPerformance.hRideF = 0.03; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.03; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0; % Max power (W)
Car.Powertrain.Motor.Kv = 0; % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0; % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd'; % (fwd/rwd/4wd front/rear/4 wheel drive)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 3.1; % Gear ratio %3.1
Car.Powertrain.Engine.RPM_Idle = 1500; % Idle RPM
Car.Powertrain.Engine.T_Idle = 75; % Torque at idle RPM  %55
Car.Powertrain.Engine.RPM_Limit = 12500; % Max RPM [R/Min] 
Car.Powertrain.Engine.T_Limit = 75; % Torque at max RPM %55
Car.Powertrain.Engine.T_Max = 80; % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 9500; % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 63000; % Max power (W)
Car.Powertrain.Engine.Efficiencies.Gears = 0.98; %0.98
% Brakes info
Car.Brakes.FPedalMax = 1500; %  
Car.Brakes.BrakeBias = 0.6757; % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3 % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2; % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3; % Piston diameter (m)
Car.Brakes.Rear.dPiston = 25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2; % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.1905; % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder = 0.0254; % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2; % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Loughborough_18.mat')
clear


%% Car Parameters (%Sussex 2018)
Car.Year = '2018';
Car.Category = 'ICE'; % ICE/EV/Hybrid
Car.Points.Acceleration = 9.8;
Car.Points.SkidPad = 0;
Car.Points.Autocross = 48.7;
Car.Points.Endurance = 118.3; %
Car.Points.FuelEfficiency = 29.2;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
%Mass
Car.Mass.Total = 290;
%Dimensions
Car.Dimension.lWheelbase = 1650/1000;
Car.Dimension.Front_track = 1280/1000;
Car.Dimension.Rear_track = 1250/1000;
Car.Dimension.FrontalArea = 1.0;
Car.Dimension.CoG = [0.6*Car.Dimension.lWheelbase, 0, 300/1000]; % height unknown
Car.Dimension.CoP = [0.5*Car.Dimension.lWheelbase, 0, 300/1000];
Car.Balance.CoG = [0.6, 0, 0.3];
Car.Balance.CoP = [0.5, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Dimension.WheelFL.Radius = 0.2032; % Tyre radius [m] 13"
Car.Dimension.WheelFR.Radius = 0.2032;
Car.Dimension.WheelRL.Radius = 0.2032;
Car.Dimension.WheelRR.Radius = 0.2032;
%Aero
Car.AeroPerformance.C_L = 0.2; % unknown
Car.AeroPerformance.C_D = 1.2; % unknown
Car.AeroPerformance.hRideF = 0.03; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.03; % (m)
% Steering
Car.Steering.Ratio = 7;
% Powertrain parameters
% Battery/motor (values for single motor)
Car.Powertrain.Motor.P_max = 0; % Max power (W)
Car.Powertrain.Motor.Kv = 0; % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 0; % (V) 
Car.Powertrain.Motor.TransmissionRatio = 0; %10;
Car.Powertrain.Motor.RPM_Lim = 0; 
Car.Powertrain.Motor.Efficiencies.Motor = 0;
Car.Powertrain.Motor.Efficiencies.Gears = 0;
Car.Powertrain.Motor.Config = 'fwd'; % (fwd/rwd/4wd front/rear/4 wheel drive)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 3.1; % Gear ratio %3.46
Car.Powertrain.Engine.RPM_Idle = 3000; % Idle RPM
Car.Powertrain.Engine.T_Idle = 53; % Torque at idle RPM  %55
Car.Powertrain.Engine.RPM_Limit = 7000; % Max RPM [R/Min] 
Car.Powertrain.Engine.T_Limit = 53; % Torque at max RPM %55
Car.Powertrain.Engine.T_Max = 64.1; % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 10000; % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 55000; % Max power (W)   %58800
Car.Powertrain.Engine.Efficiencies.Gears = 0.98; %0.98
% Brakes info
Car.Brakes.FPedalMax = 1500; %  
Car.Brakes.BrakeBias = 0.6757; % > 0.5 is biased towards front - might change with weight / CG
Car.Brakes.PedalMotionRatio = 205.8/51.5;
Car.Brakes.Front.wPad = 0.040894; %25.4e-3 % Pad width (m) 
Car.Brakes.Rear.wPad = 0.040894; %25.4e-3
Car.Brakes.Front.PadFrictionCoefficent = 0.55;
Car.Brakes.Rear.PadFrictionCoefficent = 0.55;
Car.Brakes.Front.nPistons = 2; % Per caliper
Car.Brakes.Rear.nPistons = 2; 
Car.Brakes.Front.dBoreDisk = 30e-3; % Bore diameter of brake disk
Car.Brakes.Rear.dBoreDisk = 30e-3;
Car.Brakes.Front.dPiston = 25e-3; % Piston diameter (m)
Car.Brakes.Rear.dPiston = 25e-3;
Car.Brakes.Front.aPiston = pi*(Car.Brakes.Front.dPiston/2)^2; % Piston area (m^2)
Car.Brakes.Rear.aPiston = pi*(Car.Brakes.Rear.dPiston/2)^2;
Car.Brakes.Front.dDisk = 0.1905; % Disk diameter (m)
Car.Brakes.Rear.dDisk = 0.1905;
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder = 0.0254; % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254;
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2; % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
Car.Sus.Front.Stiffness.Vertical = 65000;
Car.Sus.Rear.Stiffness.Vertical = 55000;
% Cambers
Car.Tyres.Camber.FL = -1;
Car.Tyres.Camber.FR = -1;
Car.Tyres.Camber.RL = 0;
Car.Tyres.Camber.RR = 0;
Car.Tyres.CamberRollFactor.Front = 0.325;
Car.Tyres.CamberRollFactor.Rear = 1.1;
save('Sussex_18.mat')
clear