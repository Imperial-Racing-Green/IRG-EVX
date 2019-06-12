function [T] = Engine_Torque(velocity,radius,Engine_Info)

Ratio = Engine_Info.TransmissionRatio;
Config = Engine_Info.Config;
RPM_Idle = Engine_Info.RPM_Idle;
T_Idle = Engine_Info.T_Idle;
RPM_Max_T = Engine_Info.RPM_Max_T;
T_Max = Engine_Info.T_Max;
RPM_Limit = Engine_Info.RPM_Limit;
T_Limit = Engine_Info.T_Limit;

% wheel_rad = velocity / radius;
wheel_rad = (velocity / radius) * (30/pi);

RPM_engine = wheel_rad * (Ratio * Engine_Info.Efficiencies.Gears); 

% Enforce max RPM limit
RPM_engine = min(RPM_engine,RPM_Limit);

% Ensure RPM never goes below idle
RPM_engine = max(RPM_engine,RPM_Idle);


% Find torque of motor from RPM of motor based on quadratic assumption graph:
if Ratio ~= 0
    x = [RPM_Idle, RPM_Max_T, RPM_Limit];
    y = [T_Idle, T_Max, T_Limit];
    p = polyfit(x,y,2);
    T_engine = (p(1)*(RPM_engine^2)) + (p(2)*RPM_engine) + p(3);
else
    T_engine = 0;
end

if isnan(T_engine)
    T_engine = 0;
end

if strcmp(Config,'fwd') == 1
    T_FL = (T_engine * Ratio);
    T_FR = T_FL;
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd') == 1
    T_FL = 0;
    T_FR = T_FL;
    T_RL = (T_engine * Ratio);
    T_RR = T_RL;
else % 4wd
    T_FL = (T_engine * Ratio) / 2;  % Need to find torque distribution across axles
    T_FR = T_FL;
    T_RL = (T_engine * Ratio) / 2;
    T_RR = T_RL;
end

T = [T_FL;T_FR;T_RL;T_RR];