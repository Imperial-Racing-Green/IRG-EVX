function [velocity_t,theta_t,time] = dist2time(velocity_d,theta_d,dist)

time = 0;
step = 0.1;
dist_i = 0;
i = 1;
dist = dist(2:end);
velocity_d = velocity_d(2:end);
% while dist_i <= max(dist)
%     dist_i = dist_i + interp1(dist,velocity_d,dist_i,'spline','extrap') * step;
%     dist_cum(i) = dist_i;
%     time = time + step;
%     i = i + 1;
% end
time = 300;
% time = linspace(0,time,i-1)';
% dist_cum = dist_cum';

% velocity_t = interp1(dist,velocity_d,dist_cum,'nearest','extrap');
% theta_t = interp1(dist,theta_d,dist_cum,'nearest','extrap');
velocity_t = 0;
theta_t = 0;