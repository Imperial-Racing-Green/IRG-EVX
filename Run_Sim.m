%% Run Sim Here
% clear all
close all

[x,y,theta_d,curve_d,radius_d,dist] = Track_Gen('FSUK Track Centreline.csv',1,1200,'On');

velocity_d = Vel_Init(dist,10);

[velocity_t,theta_t,time] = dist2time(velocity_d,theta_d,dist);

velocity_t = [time,velocity_t];
theta_t = [time,theta_t];

% sim('EVX_Lap_Simulation',max(time));
% 
% plot(car_path.Data(:,1),car_path.Data(:,2));

mass = 250;
velocity_dmax = Vel_update(Fz_log,dist,dist_log,radius_d,mass);

velocity_dnew = velocity_d + 0.25 .* (velocity_dmax - velocity_d);

[velocity_t,theta_t,time] = dist2time(velocity_dnew,theta_d,dist);
velocity_t = [time,velocity_t];
theta_t = [time,theta_t];

sim('EVX_Lap_Simulation',max(time));

velocity_d = velocity_dnew;


% plot(time,theta_t);
% figure
% plot(dist,theta_d);
% figure
% plot(time,velocity_t);
% figure
% plot(dist,velocity_d);