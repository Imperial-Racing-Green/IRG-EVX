function [T] = Engine_Torque(velocity,radius,Engine_Info)

Ratio = Engine_Info.TransmissionRatio;
% Torque = Engine_Info.MaxTorque;
% Power = Engine_Info.MaxPower;
Config = Engine_Info.Config;
RPM_Limit = Engine_Info.RPM_Limit;
T_Max = Engine_Info.T_Max;
RPM_Max_T = Engine_Info.RPM_Max_T;

% wheel_rad = velocity / radius;
wheel_rad = (velocity / radius) * (30/pi);

RPM_engine = wheel_rad * (Ratio * Engine_Info.Efficiencies.Gears); 

RPM_engine = min(RPM_engine,RPM_Limit);
% Ensure starting RPM is set as minimum (hard codes value for 3-cylinder
% engine)
RPM_engine = max(RPM_engine,(0.6*RPM_Max_T));

% torque_line = abs(Power / RPM_engine);

% engine_torque = min(Torque,torque_line);

% Find torque of motor from RPM of motor based on quadratic assumption graph:
T_engine = T_Max - ((T_Max/(RPM_Max_T^2))*((RPM_engine-RPM_Max_T)^2));

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