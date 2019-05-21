function [T] = Motor_Torque(velocity,radius,Motor_Info)

Ratio = Motor_Info.TransmissionRatio;
Torque = Motor_Info.MaxTorque;
Power = Motor_Info.MaxPower;
Config = Motor_Info.Config;

wheel_rad = velocity / radius;

motorspeed = wheel_rad * Ratio;

torque_line = abs(Power / motorspeed);

motor_torque = min(Torque,torque_line);

if strcmp(Config,'fwd') == 1
    T_FL = (motor_torque * Ratio) / 2;
    T_FR = T_FL;
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd') == 1
    T_FL = 0;
    T_FR = T_FL;
    T_RL = (motor_torque * Ratio) / 2;
    T_RR = T_RL;
else % 4wd
    T_FL = (motor_torque * Ratio) / 4;  % Need to find torque distribution across axles
    T_FR = T_FL;
    T_RL = (motor_torque * Ratio) / 4;
    T_RR = T_RL;
end

T = [T_FL;T_FR;T_RL;T_RR];