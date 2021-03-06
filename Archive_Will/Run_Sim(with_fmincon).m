%% Run Sim Here
clear all
close all
%% Loading Car and Stuff like weather
[Car,Environment] = Load_Params();

%% Running Kinematics
% Front_kine = run_kine_sim('Kinematics_Model',Car.Sus.Front.Hardpoints);
% Rear_kine = run_kine_sim('Kinematics_Model',Car.Sus.Rear.Hardpoints);

%% Powertrain Setup

load('PowertrainData.mat');

%% Loading Track

Track_Dist = 1200; %track distance in metres
Track_Width = 5; %track width in meteres
% Max_Track_Resolution = 1; %track points per metre
Steps = 1; %steps in optmisation smoothness
% Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
Resolution = 0.5;
Iterations = 5000; %max iterations for optmisation

%[x,y,theta,curvature,radius,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing,Line_Optim,Track_Width,Optim_Iterations)
[x,y,theta_d,curve_d,radius_d,dist] = Track_Gen('FSUK Track Endurance.csv',Track_Dist*Resolution,Track_Dist,'On','On',Track_Width,Iterations);

%     [x_new,y_new] = Path_Optim(x,y,x0,y0,theta_d,Track_Width,Iterations);


%% Running Sim
ControlSystemDriverModel = Simulink.Variant('Driver_Model == 1');
InputDefinedDriverModel = Simulink.Variant('Driver_Model == 2');
Driver_Model = 1;

mass = 270;

Fz_log.Data = mass .* -9.81 .* ones(length(dist),4) ./ 4;
Fz_log.Time = linspace(0,120,length(dist))';
dist_log.Data = dist;
dist_log.Time = linspace(0,120,length(dist))';

velocity_d = zeros(length(dist),1);
velocity_dmax = Vel_update(Fz_log,dist,dist_log,radius_d,mass);
velocity_dnew = velocity_d + 0.4 .* (velocity_dmax - velocity_d);

% velocity_d = Vel_Init(dist,10);
% 
[velocity_t,theta_t,time] = dist2time(velocity_dnew,theta_d,dist);
% 
% Track = table(x(1:end-1),y(1:end-1),theta_d,velocity_dnew);

sim('EVX_Lap_Simulation',max(time)*3);

velocity_log = diff(dist_log.Data)./diff(dist_log.Time);
lap_time = max(dist_log.Time);

scatter(car_path.Data(1:end-1,1),car_path.Data(1:end-1,2),1,velocity_log);

%% Lap Optimisation
Driver_Model = 2;
Pedal = Driver_Inputs.Pedal_Position.Data;
Steering = Driver_Inputs.Steering_Wheel_Angle.Data;
Time = Driver_Inputs.Steering_Wheel_Angle.Time;
Dist_log = dist_log.Data;
% Pedal_new = interp1(Dist_log,Pedal,dist,'linear');
% Steering_new = interp1(Dist_log,Steering,dist,'linear');
z = [Steering,Pedal];
global Steering_run
global Pedal_run
[lap_time] = Lap_Optim(z,Time);

initial = [Steering,Pedal];

fun = @(z) Lap_Optim(z,Time);
A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = @(z) Lap_Con(z,x,y);
ub = [90*ones(length(Time),1),100*ones(length(Time),1)];
lb = [-90*ones(length(Time),1),-100*ones(length(Time),1)];
Iterations = 1; %max iterations for optmisation
opts = optimset('Display','iter','Algorithm','interior-point', 'MaxIter', Iterations, 'MaxFunEvals', Inf...
    ,'TolCon',1e-10,'TolX',1e-10);
new_Inputs = fmincon(fun,initial,A,b,Aeq,beq,lb,ub,nonlcon,opts);



%% Stuff
velocity_log = [0;velocity_log];
xlog = car_path.Data(:,1);
ylog = car_path.Data(:,2);

z = zeros(length(xlog),length(ylog));

% for i = 1:length(xlog)
%     for j = 1:length(ylog)
%         if i == j
%             z(i,j) = velocity_log(i);
%         end
%     end
% end
% 
% surf(xlog,ylog,z,EdgeColor,'none');