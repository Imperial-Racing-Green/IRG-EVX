function [T] = Motor_Torque(velocity,radius,Powertrain_Info)

ratio = Powertrain_Info.TransmissionRatio;
Torque = Powertrain_Info.MaxTorque;
Power = Powertrain_Info.MaxPower;
Config = Powertrain_Info.Config;

wheel_rad = velocity / radius;

motorspeed = wheel_rad * ratio;

torque_line = abs(Power / motorspeed);

motor_torque = min(Torque,torque_line);

if strcmp(Config,'fwd') == 1
    T_FL = (motor_torque * ratio) / 2;
    T_FR = T_FL;
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd') == 1
    T_FL = 0;
    T_FR = T_FL;
    T_RL = (motor_torque * ratio) / 2;
    T_RR = T_RL;
else % 4wd
    T_FL = (motor_torque * ratio) / 4;  % Need to find torque distribution across axles
    T_FR = T_FL;
    T_RL = (motor_torque * ratio) / 4;
    T_RR = T_RL;
end

T = [T_FL;T_FR;T_RL;T_RR];