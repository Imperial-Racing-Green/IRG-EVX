function [T] = Engine_Torque(velocity,radius,Engine_Info)

Ratio = Engine_Info.TransmissionRatio;
Torque = Engine_Info.MaxTorque;
Power = Engine_Info.MaxPower;
Config = Engine_Info.Config;

wheel_rad = velocity / radius;

motorspeed = wheel_rad * Ratio;

torque_line = abs(Power / motorspeed);

engine_torque = min(Torque,torque_line);

if strcmp(Config,'fwd') == 1
    T_FL = (engine_torque * Ratio) / 2;
    T_FR = T_FL;
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd') == 1
    T_FL = 0;
    T_FR = T_FL;
    T_RL = (engine_torque * Ratio) / 2;
    T_RR = T_RL;
else % 4wd
    T_FL = (engine_torque * Ratio) / 4;  % Need to find torque distribution across axles
    T_FR = T_FL;
    T_RL = (engine_torque * Ratio) / 4;
    T_RR = T_RL;
end

T = [T_FL;T_FR;T_RL;T_RR];