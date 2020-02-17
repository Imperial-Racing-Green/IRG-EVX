function [T,NGear,RPM_engine] = Engine_Torque(vWheels,radius,Engine_Info,Gears,NGear)

FinalDriveRatio = Engine_Info.FinalDriveRatio;
Config = Engine_Info.Config;
RPM_Idle = Engine_Info.RPM_Idle;
T_Idle = Engine_Info.T_Idle;
RPM_Max_T = Engine_Info.RPM_Max_T;
T_Max = Engine_Info.T_Max;
RPM_Limit = Engine_Info.RPM_Limit;
T_Limit = Engine_Info.T_Limit;

% Get wheel speed
if strcmp(Config,'fwd') == 1
   vWheel = mean(vWheels(1:2)); 
elseif strcmp(Config,'rwd') == 1
    vWheel = mean(vWheels(3:4)); 
else % 4wd
    vWheel = mean(vWheels); 
end

% Assign gears
if (NGear < 6) && (vWheel >= Gears.vCar_ShiftUp(NGear))
    NGear = NGear + 1;
elseif (NGear > 1) && (vWheel < Gears.vCar_ShiftDown(NGear))
    NGear = NGear - 1;
end
GearRatio = Gears.Ratio(NGear);

% Wheel rotational speed in RPM
wheel_RPM = (vWheel / radius) * (30/pi);

RPM_engine = wheel_RPM * (FinalDriveRatio * Engine_Info.Efficiencies.Gears * GearRatio); 

% Enforce max RPM limit
RPM_engine = min(RPM_engine,RPM_Limit);

% Ensure RPM never goes below idle
RPM_engine = max(RPM_engine,RPM_Idle);

% Find torque of motor from RPM of motor based on quadratic assumption graph:
if RPM_engine <= RPM_Max_T
    x = [RPM_Idle, RPM_Max_T, (RPM_Max_T + (RPM_Max_T-RPM_Idle))];
    y = [T_Idle, T_Max, T_Idle];
    p = polyfit(x,y,2);
    T_engine = (p(1)*(RPM_engine^2)) + (p(2)*RPM_engine) + p(3);
else % Use parabolic equation for other side to torque curve
    x = [(RPM_Max_T - (RPM_Limit-RPM_Max_T)), RPM_Max_T, RPM_Limit];
    y = [T_Limit, T_Max, T_Limit];
    p = polyfit(x,y,2);
    T_engine = (p(1)*(RPM_engine^2)) + (p(2)*RPM_engine) + p(3);
end

if isnan(T_engine)
    T_engine = 0;
end

T_gearbox = T_engine;
T_differential = T_gearbox * FinalDriveRatio; 

if strcmp(Config,'fwd') == 1
    T_FL = T_differential / 2;
    T_FR = T_FL;
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd') == 1
    T_FL = 0;
    T_FR = T_FL;
    T_RL = T_differential / 2;
    T_RR = T_RL;
else % 4wd
    T_FL = T_differential / 4;  % Need to find torque distribution across axles
    T_FR = T_FL;
    T_RL = T_differential / 4;
    T_RR = T_RL;
end

T = [T_FL;T_FR;T_RL;T_RR];