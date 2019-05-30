% This script allows the saving and editing of other teams carfiles
clear
clc

%% Car Parameters (CATALUNYA 2016)
Car.Year = '2016';
Car.Category = 'EV';        % ICE/EV/Hybrid
Car.Points.Acceleration = 38.72;
Car.Points.SkidPad = 18.28;
Car.Points.Autocross = 84.90; %58.13;
Car.Points.Endurance = 132.8; %132.0;
Car.Points.FuelEfficiency = 100;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 278;  %278
Car.Dimension.lWheelbase = 1525/1000;
Car.Dimension.Front_track = 1150/1000;
Car.Dimension.Rear_track = 1100/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 0.05;                         % unknown
Car.AeroPerformance.C_D = 0.800;                        % unknown
Car.Dimension.CoG =[0,0.5*Car.Dimension.lWheelbase,300/1000];     % height unknown
Car.Dimension.CoP = [0,0.5*Car.Dimension.lWheelbase,300/1000];
Car.Balance.CoG = [0.5, 0, 0.25];
Car.Balance.CoP = [0.5, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';                             % For miscellaneous (please specify)
Car.Powertrain.Motor.TransmissionRatio = 5.5;                               % Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 398;                        % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 8000;                      % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall =  200;                          % Max torque@max Current [Nm] %220
Car.Powertrain.Motor.T_Cap = 0.25*Car.Powertrain.Motor.T_Stall;  %0.75
Car.Powertrain.Motor.T_const = 0.134;                    % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 100000;                       % Max power (W)
Car.Powertrain.Engine.Config = 'fwd';                        % For miscellaneous (please specify)
Car.Powertrain.Engine.TransmissionRatio = 0;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 0;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 0;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 0;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 0;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
Car.Mass.Total = 280; %272
Car.Dimension.lWheelbase = 1530/1000;
Car.Dimension.Front_track = 1250/1000;
Car.Dimension.Rear_track = 1200/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.6;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0,0.5*Car.Dimension.lWheelbase,300/1000];
Car.Balance.CoG = [0.55, 0, 0.25];
Car.Balance.CoP = [0.5, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 5; % 6.39          %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 403;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 10000;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 60; %90;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0.134;                 % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 42000;                       % Max power (W)
Car.Powertrain.Engine.Config = 'fwd';
Car.Powertrain.Engine.TransmissionRatio = 0;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 0;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 0;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 0;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 0;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.2667;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.2667;
Car.Dimension.WheelRL.Radius = 0.2667;
Car.Dimension.WheelRR.Radius = 0.2667;
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
save('aachen.mat')
clear

%% Car Parameters (West Bohemia 2016)
%need to clarify 'torque constant', 'voltages' %West Bohemia, RWD Combustion
Car.Year = '2016';
Car.Category = 'EV';        % ICE/EV/Hybrid
Car.Points.Acceleration = 51.6;
Car.Points.SkidPad = 10.2;
Car.Points.Autocross = 63.7;
Car.Points.Endurance = 123.7; %118.3;
Car.Points.FuelEfficiency = 51.9;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 313;
Car.Dimension.lWheelbase = 1565/1000;
Car.Dimension.Front_track = 1220/1000;
Car.Dimension.Rear_track = 1180/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.5367*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5367, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                              % 18.7;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 4.5;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 10600;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 58;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 8900;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 62000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('West_Bohemia_16.mat')
clear

%% Car Parameters (Paderborn 2016)
%need to clarify 'torque constant', 'voltages' %Paderborn, RWD Combustion
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 3.5;
Car.Points.SkidPad = 14.5;
Car.Points.Autocross = 78.7;
Car.Points.Endurance = 188.4; %184.7;
Car.Points.FuelEfficiency = 42.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 267;
Car.Dimension.lWheelbase = 1600/1000;
Car.Dimension.Front_track = 1160/1000;
Car.Dimension.Rear_track = 1140/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.4;                         % unknown
Car.Dimension.CoG = [0, 0.5506*Car.Dimension.lWheelbase, 300]/1000;   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5506, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                              % 18.7;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 2.5;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 13100;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 65;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 11300;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 63000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('Paderborn_16.mat')
clear

%% Car Parameters (Paderborn 2016)
%need to clarify 'torque constant', 'voltages' %Paderborn, RWD Combustion
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 3.5;
Car.Points.SkidPad = 14.5;
Car.Points.Autocross = 78.7;
Car.Points.Endurance = 188.4; %184.7;
Car.Points.FuelEfficiency = 42.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 267;
Car.Dimension.lWheelbase = 1600/1000;
Car.Dimension.Front_track = 1160/1000;
Car.Dimension.Rear_track = 1140/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.4;                         % unknown
Car.Dimension.CoG = [0, 0.5506*Car.Dimension.lWheelbase, 300]/1000;   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5506, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                              % 18.7;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 2.5;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 13100;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 65;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 11300;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 63000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('Paderborn_16.mat')
clear

%% Car Parameters (Bath 2016)
%need to clarify 'torque constant', 'voltages' %Bath, RDW Combustion
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 44.9;
Car.Points.SkidPad = 28.7;
Car.Points.Autocross = 90.0;
Car.Points.Endurance = 205.8; % 203.9;
Car.Points.FuelEfficiency = 59.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 238;
Car.Dimension.lWheelbase = 1540/1000;
Car.Dimension.Front_track = 1131/1000;
Car.Dimension.Rear_track = 1131/1000;
Car.Dimension.FrontalArea = 1;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.8;                         % unknown
Car.Dimension.CoG = [0, 0.5147*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5147, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.018;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                              % 18.7;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 4;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 8500;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 63;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 5500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 56000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('Bath_16.mat')
clear

%% Car Parameters (Delft 2015)
%need to clarify 'torque constant', 'voltages' %Delft, 4WD Electric
Car.Year = '2015';
Car.Category = 'EV';        % ICE/EV/Hybrid
Car.Points.Acceleration = 69.2;
Car.Points.SkidPad = 33.3;
Car.Points.Autocross = 141.9;
Car.Points.Endurance = 293.5; %292.4;
Car.Points.FuelEfficiency = 98.7;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 228;
Car.Dimension.lWheelbase = 1530/1000;
Car.Dimension.Front_track = 1200/1000;
Car.Dimension.Rear_track = 1200/1000;
Car.Dimension.FrontalArea = 1.4;
Car.AeroPerformance.C_L = 3.5; %2.7;                          % unknown
Car.AeroPerformance.C_D = 1.2; %1.24;                         % unknown
Car.Dimension.CoG = [0, 0.5088*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Balance.CoG = [0.5088, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.018;
% Powertrain parameters
Car.Powertrain.Motor.Config = '4wd';
Car.Powertrain.Motor.TransmissionRatio = 10.8;                  %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 400; % Guess                    % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 14000; %11000;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 50; % 28;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.9*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 1.05; % Guess                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 32500;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 0;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 0;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 0;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 0;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 0;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.203; %0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.203; %0.230; 
Car.Dimension.WheelRL.Radius = 0.203; %0.230;  
Car.Dimension.WheelRR.Radius = 0.203; %0.230; 
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
save('Delft_15.mat')
clear

%% Car Parameters (Stuttgart 2016)
%need to clarify 'torque constant', 'voltages' %Stuttgart, RWD Combustion
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 51.5;
Car.Points.SkidPad = 44.9;
Car.Points.Autocross = 146.4;
Car.Points.Endurance = 300;
Car.Points.FuelEfficiency = 70.8;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 253;
Car.Dimension.lWheelbase = 1630/1000;
Car.Dimension.Front_track = 1140/1000;
Car.Dimension.Rear_track = 1120/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 5;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.5059*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];
Car.Tyres.Coefficients.RollingResistance = 0.020;
Car.Balance.CoG = [0.5059, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                              % 18.7;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 4.6;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 9500;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 67.5;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 7500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 62500;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
Car.Brakes.Front.rActing = (Car.Brakes.Front.dDisk/2) - (Car.Brakes.Front.wPad/2); % Acting radius (m)
Car.Brakes.Rear.rActing = (Car.Brakes.Rear.dDisk/2) - (Car.Brakes.Rear.wPad/2);
Car.Brakes.Front.dMasterCylinder =  0.0254; % (5/8)*25.4e-3                         % Master cylinder diameter (m)
Car.Brakes.Rear.dMasterCylinder = 0.0254; % (3/4)*25.4e-3
Car.Brakes.Front.aMasterCylinder = pi*(Car.Brakes.Front.dMasterCylinder/2)^2;       % Master cylinder area (m^2)
Car.Brakes.Rear.aMasterCylinder = pi*(Car.Brakes.Rear.dMasterCylinder/2)^2;
save('Stuttgart_16.mat')
clear

%% Car Parameters (Bath 2015)
Car.Year = '2015';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 34.5;
Car.Points.SkidPad = 24.2;
Car.Points.Autocross = 94.7;
Car.Points.Endurance = 300;
Car.Points.FuelEfficiency = 68.6;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 238;
Car.Dimension.lWheelbase = 1540/1000;
Car.Dimension.Front_track = 1114/1000;
Car.Dimension.Rear_track = 1114/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.5147*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 800/1000, 300/1000];
Car.Balance.CoG = [0.5147, 0, 0.25];
Car.Balance.CoP = [0.5195, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 4; %3;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 8500;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 59;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 5500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 51000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('Bath_15.mat')
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
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.55*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 800/1000, 300/1000];
Car.Balance.CoG = [0.55, 0, 0.25];
Car.Balance.CoP = [0.5070, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                              % 18.7;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 4.2;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 8000;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 63;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 6500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 64000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('CTU_Prague_16.mat')
clear

%% Car Parameters (Karlsruhe 2016)
Car.Year = '2016';
Car.Category = 'ICE';        % ICE/EV/Hybrid
Car.Points.Acceleration = 49.5;
Car.Points.SkidPad = 37.4;
Car.Points.Autocross = 115.8;
Car.Points.Endurance = 227.3; % 215.8;
Car.Points.FuelEfficiency = 69.3;
Car.Points.Total = Car.Points.Acceleration + Car.Points.SkidPad + Car.Points.Autocross + Car.Points.Endurance + Car.Points.FuelEfficiency;
Car.Mass.Total = 266;
Car.Dimension.lWheelbase = 1530/1000;
Car.Dimension.Front_track = 1220/1000;
Car.Dimension.Rear_track = 1150/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.5376*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0, 800/1000, 300/1000];
Car.Balance.CoG = [0.5376, 0, 0.25];
Car.Balance.CoP = [0.5229, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 2.83;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 6000;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 120;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 4500;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 65000;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('Karlsruhe_16.mat')
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
Car.Mass.Total = 258;
Car.Dimension.lWheelbase = 1550/1000;
Car.Dimension.Front_track = 1250/1000;
Car.Dimension.Rear_track = 1250/1000;
Car.Dimension.FrontalArea = 1.2;
Car.AeroPerformance.C_L = 2.7;                          % unknown
Car.AeroPerformance.C_D = 1.24;                         % unknown
Car.Dimension.CoG = [0, 0.5155*Car.Dimension.lWheelbase, 300/1000];   % height unknown
Car.Dimension.CoP = [0,0.55*Car.Dimension.lWheelbase,300/1000];
Car.Balance.CoG = [0.5155, 0, 0.25];
Car.Balance.CoP = [0.55, 0, 0.30];
Car.Tyres.Coefficients.RollingResistance = 0.020;
% Powertrain parameters
Car.Powertrain.Motor.Config = 'rwd';
Car.Powertrain.Motor.TransmissionRatio = 0;                %Gear Ratio
Car.Powertrain.Motor.RatedVoltage = 0;                     % Input rated voltage of motor [V]
Car.Powertrain.Motor.RPM_Lim = 0;                  % Max RPM  [R/Min]         
Car.Powertrain.Motor.T_Stall = 0;                        % Max torque@max Current [Nm]
Car.Powertrain.Motor.T_Cap = 0.75*Car.Powertrain.Motor.T_Stall;
Car.Powertrain.Motor.T_const = 0;                   % Input Torque constant of Motor [Nm/A]
Car.Powertrain.Motor.P_Max = 0;                       % Max power (W)
Car.Powertrain.Engine.Config = 'rwd';
Car.Powertrain.Engine.TransmissionRatio = 5.5;                               % Gear ratio
Car.Powertrain.Engine.RPM_Limit = 11000;                   % Max RPM  [R/Min]         
Car.Powertrain.Engine.T_Max = 61;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Max_T = 9000;                      % RPM corresponding to max torque
Car.Powertrain.Engine.P_Max = 62500;                       % Max power (W)
Car.Dimension.WheelFL.Radius = 0.230;                          % Tyre radius          [m]   18"
Car.Dimension.WheelFR.Radius = 0.230;
Car.Dimension.WheelRL.Radius = 0.230;
Car.Dimension.WheelRR.Radius = 0.230;
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
save('Wroclaw_16.mat')
clear