function [Car,Environment] = Load_Params()

Car.Category = 'EV';        % ICE/EV/Hybrid

%% Car mass (including 70kg driver) (kg)
Car.Mass.Total = 320;

%% Car dimensions (m)
Car.Dimension.Front_track = 1.2;
Car.Dimension.Rear_track = 1.2;
Car.Dimension.Height = 1.21;
Car.Dimension.lWheelbase = 1.55;
Car.Dimension.CoG = [0.775, 0, 0.300]; % Behind front axle
Car.Dimension.CoP = [0.682, 0, 0.37]; % Behind front axle
Car.Dimension.zRollCentreF = 28.6/1000;
Car.Dimension.zRollCentreR = 25.6/1000;

% Percentage of axle separation length from front axles 
Car.Balance.CoG = [Car.Dimension.CoG(1)/Car.Dimension.lWheelbase, 0, Car.Dimension.CoG(3)/Car.Dimension.Height];
Car.Balance.CoP = [Car.Dimension.CoP(1)/Car.Dimension.lWheelbase, 0, Car.Dimension.CoP(3)/Car.Dimension.Height]; 

%% Tyre info
Car.Tyres.Camber.FL = -1.0;
Car.Tyres.Camber.FR = -1.0;
Car.Tyres.Camber.RL = 0.0;
Car.Tyres.Camber.RR = 0.0;
Car.Tyres.CamberRollFactor.Front = 0.36;     % (deg/deg)
Car.Tyres.CamberRollFactor.Rear = 0.13;      % (deg/deg)
Car.Tyres.CamberRideFactor.Front = -34.8;         % (deg/m)
Car.Tyres.CamberRideFactor.Rear = -11.5;          % (deg/m)
Car.Tyres.GripScale_Total = 2/3;            % Scale factor of the grip level (2/3 accounts for higher grip seen in test facility)
Car.Tyres.GripWeightingFront = 0.5; 
Car.Tyres.bSameTyreType = 1;    % (boolean) Forces rear tyres to be the same type as fronts (can have different pressure). Useful for sweeping tyre choice for both axles
Car.Tyres.Front.Name = 'Hoosier_16.0x7.5-10_R25B'; % If front and rear are intentionally different set 'bSameTyreType = 0'
Car.Tyres.Rear.Name = 'Hoosier_16.0x7.5-10_R25B';
Car.Tyres.Front.Pressure = 12; % psi
Car.Tyres.Rear.Pressure = 12;   % psi
Car = fnSelectTyres(Car);

%% Powertrain info
% Engine (only required if ICE or Hybrid)
Car.Powertrain.Engine.FinalDriveRatio = 3.56;
Car.Powertrain.Engine.RPM_Idle = 3000;                      % Idle RPM
Car.Powertrain.Engine.T_Idle = 53.75;                       % Torque at idle RPM
Car.Powertrain.Engine.RPM_Max_T = 9200;                      % RPM corresponding to max torque
Car.Powertrain.Engine.T_Max = 68;                      % Max torque possible [Nm]
Car.Powertrain.Engine.RPM_Limit = 13000;                   % Max RPM  [R/Min]
Car.Powertrain.Engine.T_Limit = 52;                   % Torque at max RPM
Car.Powertrain.Engine.Efficiencies.Gears = 0.98;
Car.Powertrain.Engine.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
% Battery/motor (values for single motor) (only required if EV or Hybrid)
Car.Powertrain.Motor.P_max = 100000;    % Max power (W)
Car.Powertrain.Motor.Kv = 65;          % RPM constant 
Car.Powertrain.Motor.RatedVoltage = 100;          % (V) 
Car.Powertrain.Motor.TransmissionRatio = 3.25;
Car.Powertrain.Motor.Efficiencies.Motor = 0.87;
Car.Powertrain.Motor.Efficiencies.Gears = 0.941;
Car.Powertrain.Motor.Config = 'rwd';      % (fwd/rwd/4wd   front/rear/4 wheel drive)
Car.Powertrain.Motor.nMotors = 1; % Find if they are axle or in-hub motors (If fwd/rwd: 1=axle,2=in-hub; if 4wd: 2=axle,4=in-hub for each corner)

%% Define gears
Car.Gears = table([1; 2; 3; 4; 5; 6],...
                  [NaN; 12.6443; 19.4528; 25.8860; 34.1266; 42.8187],...
                  [10.4906; 18.6993; 28.7681; 38.2820; 50.4686; NaN],...
                  [4.171; 2.340; 1.521; 1.143; 0.867; 0.691]);
Car.Gears.Properties.VariableNames = {'NGear','vCar_ShiftDown','vCar_ShiftUp','Ratio'};
% [15.39;19.17;22.75;26.39;28.75;31.33] Speeds for MaxPower at each gear

%% Brakes info
Car.Brakes.FPedalMax = 1500;                                           % (N) 
Car.Brakes.BrakeBias = 0.67;                                           % > 0.5 is biased towards front
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

%% Car aero performance
Car.AeroPerformance.SC_L = 2.6;
Car.AeroPerformance.SC_D = 1.3;
Car.AeroPerformance.hRideF = 0.030; % (m) (Static ride height under the weight of the car)
Car.AeroPerformance.hRideR = 0.030; % (m)
Car.AeroPerformance.Aeromap = GenerateAeromap();

%% Steering
Car.Steering.Ratio = 11;

%% Environment conditions
Environment.Gravity = -9.81;                    % (m/s^2)
Environment.Density = 1.2126;                     % (kg/m^3)
Environment.Temperature.Air = 18 + 273.15;      % (K)
Environment.Temperature.Track = 30 + 273.15;    % (K)
Environment.Pressure = 101325;                  % (Pa)
Environment.track_conditions = 'dry';           % dry/wet

%% Suspension
% Format: Linear spring at each corner with front and rear roll bump stiffnesses
% calculated. Additional roll stiffness available with front and rear
% anti-roll bars without affecting bump stiffness
Car.Sus.Front.Stiffness.Vertical = 40000; % (N/m)
Car.Sus.Front.Stiffness.ARB = 20000; % (Nm/deg)
Car.Sus.Front.Stiffness.Roll = (0.5*(Car.Dimension.Front_track^2)*Car.Sus.Front.Stiffness.Vertical) + Car.Sus.Front.Stiffness.ARB; % (Nm/deg)
Car.Sus.Front.MotionRatio = 0.78;
Car.Sus.Rear.Stiffness.Vertical = 60000; % (N/m)
Car.Sus.Rear.Stiffness.ARB = 20000; % (Nm/deg)
Car.Sus.Rear.Stiffness.Roll = (0.5*(Car.Dimension.Rear_track^2)*Car.Sus.Front.Stiffness.Vertical) + Car.Sus.Rear.Stiffness.ARB; % (Nm/deg)
Car.Sus.Rear.MotionRatio = 0.74;

save('Baseline_Carfile','Car')
save('Baseline_Weatherfile','Environment')