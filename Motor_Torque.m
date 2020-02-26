function [T,RPM_motor,pMotor] = Motor_Torque(vWheels,radius,Motor_Info)

Ratio = Motor_Info.TransmissionRatio;
P_max = Motor_Info.P_max;
Kv = Motor_Info.Kv;
rated_voltage = Motor_Info.RatedVoltage;
Config = Motor_Info.Config;
nMotors = Motor_Info.nMotors;

% FSAE power limit
pLim = 80000;

% Get wheel speed
if strcmp(Config,'fwd') == 1
   vWheel = mean(vWheels(1:2)); 
elseif strcmp(Config,'rwd') == 1
    vWheel = mean(vWheels(3:4)); 
else % 4wd
    vWheel = mean(vWheels); 
end

% Wheel rotational speed in RPM
wheel_rad = (vWheel / radius) * (30/pi); % wheel speed in RPM

% motorspeed = wheel_rad * Ratio;
motorspeed = wheel_rad * (Ratio * Motor_Info.Efficiencies.Gears);

% Find no load RPM (max RPM limit) from RPM constant and rated voltage
RPM_no_load = Kv * rated_voltage;

% Limit RPM of motor
RPM_motor = min(motorspeed,RPM_no_load);

% Find RPM at max power
RPM_maxP = 0.5 * RPM_no_load;

% Find maximum torque
T_maxP = (P_max/RPM_maxP)*(30/pi);

% Find stall torque 
T_stall = 2 * T_maxP;

% Find capped torque
T_cap = 0.5 * T_stall;

% Find torque of motor from RPM of motor based on linear graph:
T_motor =  T_stall - ((RPM_motor/RPM_no_load)*T_stall);

% Apply torque cap
T_motor = min(T_motor,T_cap)*Motor_Info.Efficiencies.Motor;

% Make sure motor power is not exceeding 80kW limit in regulations
% pMotor = (T_motor*RPM_motor)*(pi/30);
pMotor = min( (P_max/RPM_maxP)*RPM_motor , P_max );
if pMotor > pLim
%     T_motor = (9.5488 * pMotor * Motor_Info.Efficiencies.Motor) / RPM_motor;
    T_motor = T_motor*(pLim/pMotor);
    pMotor = pLim;
end

if isnan(T_motor)
    T_motor = 0;
end

% Distribute torque onto the wheels depending on drivetrain and motor
% configuration
if strcmp(Config,'fwd')
    if nMotors == 1 
       % One motor on the axle
       T_FL = (T_motor * Ratio)/2;
       T_FR = T_FL; 
    elseif nMotors == 2  
       % In-hub motors
       T_FL = (T_motor * Ratio);
       T_FR = T_FL; 
    else
        error('Incorrect number of motors inputted for this drivetrain configuration')
    end
    T_RL = 0;
    T_RR = T_RL;    
elseif strcmp(Config,'rwd')
    % One motor on the axle
    T_FL = 0;
    T_FR = T_FL;
    if nMotors == 1
        T_RL = (T_motor * Ratio)/2;
        T_RR = T_RL;
    elseif nMotors == 2 
        % In-hub motors
        T_RL = (T_motor * Ratio);
        T_RR = T_RL;
    else
        error('Incorrect number of motors inputted for this drivetrain configuration')
    end   
elseif strcmp(Config,'4wd')
    % May be a torque distribution across axles?
    if nMotors == 2
        % One motor on the axle
        T_FL = (T_motor * Ratio)/2;
        T_FR = T_FL;
        T_RL = T_FL;
        T_RR = T_FL;
    elseif nMotors == 4
         % In-hub motors
         T_FL = (T_motor * Ratio);
         T_FR = T_FL;
         T_RL = T_FL;
         T_RR = T_FL;
    else
        error('Incorrect number of motors inputted for this drivetrain configuration')
    end
end

T = [T_FL;T_FR;T_RL;T_RR];