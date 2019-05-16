%% Run Sim Here
clear all
close all
% Save results location
SaveLocation = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP';
FolderName = 'Test1_CoG';
SimName = {'Test'};

 trackmap = 'Racing_Line.mat';
%trackmap = 'Acceleration_Track.mat';
% trackmap = 'SkidPad_Track.mat';

%% Sweep inputs
sweep = 1;                      % Choose whether to sweep or not
sweep_param = {'Car.Balance.CoG'};    % Variable within car structure to be swept
sweep_values = [0.40 0.45 0.50 0.55 0.60 0.65];
if sweep == 1
    nSweeps = length(sweep_values);
    if length(SimName) == length(sweep_values)
        SimName = SimName;
    else
        for i = 1:length(sweep_values)
            SimName{i} = ['Sim' num2str(i)];
        end
    end
else
    nSweeps = 1;
end
%% End of sim inputs!!!

for iSweep = 1:nSweeps

    %% Loading Car and Stuff like weather
    [Car,Environment] = Load_Params();
    
    % Override car params for sweep
    if sweep == 1
      eval([sweep_param{1},'=',num2str(sweep_values(iSweep)),';']);
    end
       

    %% Running Kinematics
    % Front_kine = run_kine_sim('Kinematics_Model',Car.Sus.Front.Hardpoints);
    % Rear_kine = run_kine_sim('Kinematics_Model',Car.Sus.Rear.Hardpoints);

    %% Powertrain Setup

    load('PowertrainData.mat');

    %% Loading Track

    Track_Dist = 1200; %track distance in metres
    Track_Width = 4; %track width in meteres
    % Max_Track_Resolution = 1; %track points per metre
    Steps = 1; %steps in optmisation smoothness
    % Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
    Resolution = 0.5;
    Iterations = 5000; %max iterations for optmisation

    %[x,y,theta,curvature,radius,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing,Line_Optim,Track_Width,Optim_Iterations)
    %% [x,y,theta_d,curve_d,radius_d,dist] = Track_Gen('FSUK Track Endurance.csv',Track_Dist*Resolution,Track_Dist,'On','On',Track_Width,Iterations);

    % Load racing line to skip repeatedely optimising the same track everytime
    load(trackmap)
    %     [x_new,y_new] = Path_Optim(x,y,x0,y0,theta_d,Track_Width,Iterations);


    %% Running Sim
    ControlSystemDriverModel = Simulink.Variant('Driver_Model == 1');
    InputDefinedDriverModel = Simulink.Variant('Driver_Model == 2');
    Driver_Model = 1;

    mass = Car.Mass.Total;

    % Distribute mass based on CoG location
    Fz_log = [];
    dist_log = [];
    Fz_log.Data = mass .* Environment.Gravity .* ones(length(dist),4) ./ 2; % Total weight split evenly across each axis
    Fz_log.Data(:,[1,2]) = Fz_log.Data(:,[1,2]) * (1 - Car.Balance.CoG);
    Fz_log.Data(:,[3,4]) = Fz_log.Data(:,[3,4]) * (Car.Balance.CoG);
    Fz_log.Time = linspace(0,120,length(dist))';
    dist_log.Data = dist;
    dist_log.Time = linspace(0,120,length(dist))';

    velocity_d = zeros(length(dist),1);
    velocity_dmax = Vel_update(Fz_log,dist,dist_log,radius_d,mass,Environment,Car);
    velocity_dnew = velocity_d + 0.9 .* (velocity_dmax - velocity_d);

    % velocity_d = Vel_Init(dist,10);
    % 
    [velocity_t,theta_t,time] = dist2time(velocity_dnew,theta_d,dist);
    % 
    % Track = table(x(1:end-1),y(1:end-1),theta_d,velocity_dnew);
    initial_velocity = velocity_dnew(1);

    sim('EVX_Lap_Simulation',max(time)*1.5);

    velocity_log = diff(dist_log.Data)./diff(dist_log.Time);
    lap_time = max(dist_log.Time);

    scatter(car_path.Data(1:end-1,1),car_path.Data(1:end-1,2),1,velocity_log);
    
    % Create vCar trace from interpoloated input velocity
% %     vCar = interp1(dist,velocity_dnew,dist_log.Data);
    vCar = ((Horizontal_Dynamics.Velocities.v_x.Data.^2) + (Horizontal_Dynamics.Velocities.v_y.Data.^2)).^0.5;
    % Separate pedal position into throttle and brake
    Driver_Inputs.rThrottle = Driver_Inputs.Pedal_Position;
    Driver_Inputs.rThrottle.Data(Driver_Inputs.rThrottle.Data < 0) = 0;
    Driver_Inputs.rBrake = Driver_Inputs.Pedal_Position;
    Driver_Inputs.rBrake.Data(Driver_Inputs.rBrake.Data > 0) = 0;
    Driver_Inputs.rBrake.Data = - Driver_Inputs.rBrake.Data;
    % Save results to desired location
    if iSweep == 1
        mkdir([SaveLocation '\' FolderName])
    end
    sim_output_vars = {'Vertical_Dynamics','car_path','Fz_log','dist_log',...
                   'Horizontal_Dynamics','Limits','Driver_Inputs','vCar'};
    save([SaveLocation '\' FolderName '\' SimName{iSweep} '.mat'],sim_output_vars{:})
    
end

%% Optimisation
figure
iter = 1;
Limit_d = 0;
Limit_Perc = sum(Limit_d)/length(Limit_d);
while min(Limit_Perc) < 0.95
Power_Lim = Limits.signals.values(:,1);
Traction_Lim = Limits.signals.values(:,2);
Brake_Lim = Limits.signals.values(:,3);
Corner_Lim = Limits.signals.values(:,4);
Brake_Lim(1:end-1) = Brake_Lim(2:end);
Limit = sign(Power_Lim + Traction_Lim + Brake_Lim + Corner_Lim);
Limit_d = interp1(dist_log.Data,Limit,dist,'nearest');
Limit_d(isnan(Limit_d)) = 1;
Limit_Perc = sum(Limit_d)/length(Limit_d);
velocity_step = 0.25;
velocity_dnew = velocity_step .* (1-Limit_d) + velocity_dnew;
sim('EVX_Lap_Simulation',max(time)*1.5);
lap_time = max(dist_log.Time);
subplot(2,2,1)
hold on
ylabel('Velocity Target (m/s)')
xlabel('Distance (m)')
plot(dist,velocity_dnew);
subplot(2,2,2)
ylabel('Lap Time (s)')
xlabel('Iteration Number')
hold on
scatter(iter,lap_time);
subplot(2,2,3)
hold off
plot(dist,Limit_d);
ylabel('Limit Found (1/0)')
xlabel('Distance (m)')
ylim([0 2])
subplot(2,2,4)
hold on
scatter(iter,Limit_Perc * 100);
ylabel('Limit Percentage (%)')
xlabel('Iteration Number')
iter = iter + 1;
end
velocity_log = diff(dist_log.Data)./diff(dist_log.Time);
lap_time = max(dist_log.Time);

scatter(car_path.Data(1:end-1,1),car_path.Data(1:end-1,2),1,velocity_log);

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