function [T] = Motor_Torque(velocity,radius,Motor_Info)

Ratio = Motor_Info.TransmissionRatio;
% Torque = Motor_Info.MaxTorque;
% Power = Motor_Info.MaxPower;
Config = Motor_Info.Config;
RPM_Lim = Motor_Info.RPM_Lim;
T_Stall = Motor_Info.T_Stall;
T_Cap = Motor_Info.T_Cap;

% wheel_rad = (velocity / radius)
wheel_rad = (velocity / radius) * (30/pi); % wheel speed in RPM

% motorspeed = wheel_rad * Ratio;
motorspeed = wheel_rad * (Ratio * Motor_Info.Efficiencies.Gears);

RPM_motor = min(motorspeed,RPM_Lim);

% torque_line = abs(Power / motorspeed);

% motor_torque = min(Torque,torque_line);

% Find torque of motor from RPM of motor based on linear graph:
T_motor =  T_Stall - ((RPM_motor/RPM_Lim)*T_Stall);
T_motor = min(T_motor,T_Cap);

p_Motor = (T_motor * RPM_motor) / 9.5488;
if p_Motor > 30000
    p_Motor = 30000;
    T_motor = (9.5488 * p_Motor) / RPM_motor;
end

if isnan(T_motor)
    T_motor = 0;
end

T_motor = T_motor * Motor_Info.Efficiencies.Motor;

if strcmp(Config,'fwd') == 1
    T_FL = (T_motor * Ratio);
    T_FR = T_FL;
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd') == 1
    T_FL = 0;
    T_FR = T_FL;
    T_RL = (T_motor * Ratio);
    T_RR = T_RL;
else % 4wd
    T_FL = (T_motor * Ratio);  % Need to find torque distribution across axles
    T_FR = T_FL;
    T_RL = T_FL;
    T_RR = T_FL;
end

T = [T_FL;T_FR;T_RL;T_RR];