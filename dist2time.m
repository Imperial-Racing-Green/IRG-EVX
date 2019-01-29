function [velocity_t,theta_t,time] = dist2time(velocity_d,theta_d,dist)

time = 0;
step = 0.01;
dist_i = 0;
i = 1;
while dist_i <= max(dist)
    dist_i = dist_i + interp1(dist,velocity_d,dist_i,'spline') * step;
    dist_cum(i) = dist_i;
    time = time + step;
    i = i + 1;
end

time = linspace(0,time,i-1)';
dist_cum = dist_cum';

velocity_t = interp1(dist,velocity_d,dist_cum,'spline');
theta_t = interp1(dist,theta_d,dist_cum,'spline');