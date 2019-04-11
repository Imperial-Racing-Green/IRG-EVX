function [lap_time] = Lap_Optim(z,Time)


global Steering_run
global Pedal_run
Steering_run = [Time,z(:,1)];
Pedal_run = [Time,z(:,2)];

sim('EVX_Lap_Simulation',300);

lap_time = max(dist_log.Time);

x_log = car_path.Data(:,1);
y_log = car_path.Data(:,2);
save('temp.mat','x_log','y_log');

velocity_log = diff(dist_log.Data)./diff(dist_log.Time);

scatter(car_path.Data(1:end-1,1),car_path.Data(1:end-1,2),1,velocity_log);