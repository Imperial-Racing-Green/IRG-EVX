function [T] = Motor_Torque(velocity,radius,ratio,Torque,Power)

wheel_rad = velocity / radius;

motorspeed = wheel_rad * ratio;

torque_line = abs(Power / motorspeed);

motor_torque = min(Torque,torque_line);

T_FR = 0;
T_FL = T_FR;
T_RR = (motor_torque * ratio) / 2;
T_RL = T_RR;

T = [T_FL;T_FR;T_RL;T_RR];