%% Run Sim Here
clear
close all
%% Loading Car and Stuff like weather
[Car,Environment] = Load_Params();

%% Running Kinematics
Front_kine = run_kine_sim('Kinematics_Model',Car.Sus.Front.Hardpoints);
Rear_kine = run_kine_sim('Kinematics_Model',Car.Sus.Rear.Hardpoints);

%% Loading Track
Track_Dist = 1200; %track distance in metres
[x,y,theta_d,curve_d,radius_d,dist] = Track_Gen('FSUK Track Endurance.csv',1,Track_Dist,'On');

%% Powertrain Setup

load('PowertrainData.mat');


%% Running Sim
mass = 250;

Fz_log.Data = mass .* -9.81 .* ones(length(dist),4) ./ 4;
Fz_log.Time = linspace(0,120,length(dist))';
dist_log.Data = dist;
dist_log.Time = linspace(0,120,length(dist))';

velocity_d = zeros(length(dist),1);
velocity_dmax = Vel_update(Fz_log,dist,dist_log,radius_d,mass);
velocity_dnew = velocity_d + 1 .* (velocity_dmax - velocity_d);

% velocity_d = Vel_Init(dist,10);
% 
[velocity_t,theta_t,time] = dist2time(velocity_dnew,theta_d,dist);
% 
% Track = table(x(1:end-1),y(1:end-1),theta_d,velocity_dnew);

sim('EVX_Lap_Simulation',max(time)*2);

velocity_log = diff(dist_log.Data)./diff(dist_log.Time);
lap_time = max(dist_log.Time);

scatter(car_path.Data(1:end-1,1),car_path.Data(1:end-1,2),1,velocity_log);

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