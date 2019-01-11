%% Run Sim Here
clear all
close all

[x,y,theta_d,dist] = Track_Gen('FSUK Track Centreline.csv',1,1200,'On');

velocity_d = Vel_Init(dist,10);

[velocity_t,theta_t,time] = dist2time(velocity_d,theta_d,dist);

sim('EVX_Lap_Simulation',max(time));

% plot(time,theta_t);
% figure
% plot(dist,theta_d);
% figure
% plot(time,velocity_t);
% figure
% plot(dist,velocity_d);