function [Laptime, CO2_Usage] = Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation)


if Sweep.Choose_Param == 1
    nSweeps = length(Sweep.Values);
elseif Sweep.Choose_Carfile == 1
    nSweeps = length(Sweep.Carfile);
elseif Sweep.Choose_Weatherfile == 1
    nSweeps = length(Sweep.Weatherfile);
else
    nSweeps = 1;
end
if length(SimName) == length(Sweep.Values)
    SimName = SimName;
else
    for i = 1:nSweeps
        SimName{i} = ['Sim' num2str(i)];
    end
end


for iSweep = 1:nSweeps
    
    %% Loading Car and Stuff like weather
    [Car,Environment] = Load_Params();
  


    % Check which variables (if any) to change
    if Sweep.Choose_Param == 1
        % Override car param
        eval([Sweep.Param{1},'=',num2str(Sweep.Values(iSweep)),';']);
    elseif Sweep.Choose_Carfile == 1
        % Load in a new carfile
        clear Car
        load(Sweep.Carfile{iSweep});
        %if Validation ~= 1  % Only recheck mass for our own car (where we have component masses)
         %   Car.Mass.Total = Car.Mass.WheelFL + Car.Mass.WheelFR + Car.Mass.WheelRL + Car.Mass.WheelRR + ...
%                      Car.Mass.Driver + Car.Mass.Suspension + Car.Mass.Chassis + Car.Mass.Battery + ...
%                      Car.Mass.Engine + Car.Mass.Motors + Car.Mass.Steering + Car.Mass.Pedals + ...
%                      Car.Mass.Seat + Car.Mass.FireWall + Car.Mass.Cooling + Car.Mass.Electrics + ...
%                      Car.Mass.FrontWing + Car.Mass.RearWing + Car.Mass.Brakes + Car.Mass.Fueltank;
        
    elseif Sweep.Choose_Weatherfile == 1
        clear Environment
        load(Sweep.Weatherfile{iSweep});
    end

    
    %% Running Kinematics
    % Front_kine = run_kine_sim('Kinematics_Model',Car.Sus.Front.Hardpoints);
    % Rear_kine = run_kine_sim('Kinematics_Model',Car.Sus.Rear.Hardpoints);

    %% Powertrain Setup

    load('PowertrainData.mat');

    %% Loading Track

%     Track_Dist = 1375; %track distance in metres
%     Track_Width = 2.2; %track width in meteres
%     % Max_Track_Resolution = 1; %track points per metre
%     Steps = 1; %steps in optmisation smoothness
%     % Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
%     Resolution = 0.5;
%     Iterations = 5000; %max iterations for optmisation
% % 
% %     %[x,y,theta,curvature,radius,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing,Line_Optim,Track_Width,Optim_Iterations)
%  [x,y,theta_d,curve_d,radius_d,dist] = Track_Gen('FSUK Track Endurance.csv',Track_Dist*Resolution,Track_Dist,'On','Off',Track_Width,Iterations);
% 
    % Load racing line to skip repeatedely optimising the same track everytime
       load(trackmap)
%      [x_new,y_new] = Path_Optim(x,y,x0,y0,theta_d,Track_Width,Iterations);
    radius_d = interp1([1:length(radius_d)],radius_d,[1:length(dist)]);
    radius_d(isnan(radius_d)) = 1e5; % Replace NaN's with straights

    %% Running Sim
    ControlSystemDriverModel = Simulink.Variant('Driver_Model == 1');
    InputDefinedDriverModel = Simulink.Variant('Driver_Model == 2');
    Driver_Model = 1;

    % Distribute mass based on CoG location
    Fz_log = [];
    dist_log = [];
    Fz_log.Data = Car.Mass.Total .* Environment.Gravity .* ones(length(dist),4) ./ 2; % Total weight split evenly across each axis
    Fz_log.Data(:,[1,2]) = Fz_log.Data(:,[1,2]) * (1 - Car.Balance.CoG(1));
    Fz_log.Data(:,[3,4]) = Fz_log.Data(:,[3,4]) * (Car.Balance.CoG(1));
    Fz_log.Time = linspace(0,120,length(dist))';
    dist_log.Data = dist;
    dist_log.Time = linspace(0,120,length(dist))';

    vCar = Vel_update(Fz_log,dist,dist_log,radius_d,Environment,Car,BoundaryConditions);
    sLap = dist;
    tLap = [];
    for i = 1:(length(vCar)-1)
        tLap(i,1) = 2*(sLap(i+1)-sLap(i))/(vCar(i)+vCar(i+1));
    end
%     for i = 1:(length(vCar)-1)
%         tLap(i,1) = (sLap(i+1)-sLap(i))/(vCar(i));
%     end
    Brake_Fx = Brake_Model(Car.Brakes) ./ ...
                    [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                    Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    Force.Brakes.FL(i,1) = Brake_Fx(1);
    Force.Brakes.FR(i,1) = Brake_Fx(2);
    Force.Brakes.RL(i,1) = Brake_Fx(3);
    Force.Brakes.RR(i,1) = Brake_Fx(4);
    for i = 1:length(vCar)
        Engine_Fx = Engine_Torque(vCar(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Engine) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
        Motor_Fx = Motor_Torque(vCar(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Motor) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
        Powertrain_Fx = Engine_Fx + Motor_Fx;
        Force.Powertrain.Thrust.FL(i,1) = Powertrain_Fx(1);
        Force.Powertrain.Thrust.FR(i,1) = Powertrain_Fx(2);
        Force.Powertrain.Thrust.RL(i,1) = Powertrain_Fx(3);
        Force.Powertrain.Thrust.RR(i,1) = Powertrain_Fx(4);
        [Force.Aero.Downforce(i,1), Force.Aero.Drag(i,1)] = Aero_Forces(vCar(i),Environment,Car);
    end
    Force.Powertrain.Thrust.Total = Force.Powertrain.Thrust.FL + Force.Powertrain.Thrust.FR + Force.Powertrain.Thrust.RL + Force.Powertrain.Thrust.RR;
    Force.Brakes.Total = -(Force.Brakes.FL + Force.Brakes.FR + Force.Brakes.RL + Force.Brakes.RR);
    a_x = diff(vCar)./tLap;
    a_x = [a_x; a_x(end-1)];
%     a_x = interp1([1:(length(vCar)-1)]',a_x,[1:length(vCar)]');
    Fx_real = Car.Mass.Total * a_x;
    a_y = (vCar.^2)./radius_d';
    for i = 1:length(a_x)
        [Fz_FL(i,1), Fz_FR(i,1), Fz_RL(i,1), Fz_RR(i,1)] = WeightTransfer(Car,a_x(i),a_y(i));
    end
    Fz.FL = ((Car.Mass.Total*Environment.Gravity*ones(length(vCar),1) * (1 - Car.Balance.CoG(1))) /2) - ((Force.Aero.Downforce * (1 - Car.Balance.CoP(1)))/2) + (Fz_FL);
    Fz.FR = ((Car.Mass.Total*Environment.Gravity*ones(length(vCar),1) * (1 - Car.Balance.CoG(1))) /2) - ((Force.Aero.Downforce * (1 - Car.Balance.CoP(1)))/2) + (Fz_FR);
    Fz.RL = ((Car.Mass.Total*Environment.Gravity*ones(length(vCar),1) * (Car.Balance.CoG(1))) /2) - ((Force.Aero.Downforce * (Car.Balance.CoP(1)))/2) + (Fz_RL);
    Fz.RR = ((Car.Mass.Total*Environment.Gravity*ones(length(vCar),1) * (Car.Balance.CoG(1))) /2) - ((Force.Aero.Downforce * (Car.Balance.CoP(1)))/2) + (Fz_RR);
    Fx_rollres = -(Fz.FL+ Fz.FR + Fz.RL + Fz.RR) * Car.Tyres.Coefficients.RollingResistance;
    Fx_mechanical = Fx_real + Force.Aero.Drag + Fx_rollres;
    fwd_T = Fx_mechanical;
    fwd_T(fwd_T <= 0) = 0;
    bkd_T = -Fx_mechanical;
    bkd_T(bkd_T <= 0) = 0;
    rThrottle = fwd_T ./ Force.Powertrain.Thrust.Total;
    rThrottle(isnan(rThrottle)) = 1;
    rThrottle(rThrottle > 1) = 1;
%     rBrake = bkd_T ./ Force.Brakes.Total;
    rBrake = bkd_T ./ max(bkd_T); % A hacky-hack because ^^^ doesn't cap at 1
    % Tyre forces
    % Fx, Fy
    % Replace NaN Fz's
    idx = find(isnan(Fz.FL));
    Fz.FL(idx) = Fz.FL(idx-1);
    idx = find(isnan(Fz.FR));
    Fz.FR(idx) = Fz.FR(idx-1);
    idx = find(isnan(Fz.RL));
    Fz.RL(idx) = Fz.RL(idx-1);
    idx = find(isnan(Fz.RR));
    Fz.RR(idx) = Fz.RR(idx-1);
    for i = 1:length(vCar)
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),...
            F_xFLmin(:,:,i),F_yFLmin(:,:,i)] = tyre_fmax(Fz.FL(i),10);
        Fy.FL(i) = interp1(F_yFLmax(:,1,i),F_yFLmax(:,2,i),0,'spline');
        Fy_real(i) = (Car.Mass.Total * vCar(i)^2)/radius_d(i);
        Fy_FLreal = (Fz.FL(i) / sum(Fz.FL(i)+Fz.FR(i)+Fz.RL(i)+Fz.RR(i))) * Fy_real(i);
        Fx.FL(i) = interp1(F_xFLmax(:,2,i),F_xFLmax(:,1,i),Fy_FLreal);        
        
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),...
            F_xRLmin(:,:,i),F_yRLmin(:,:,i)] = tyre_fmax(Fz.RL(i),10);
        Fy.RL(i) = interp1(F_yRLmax(:,1,i),F_yRLmax(:,2,i),0,'spline');
        Fy_RLreal = (Fz.RL(i) / sum(Fz.FL(i)+Fz.FR(i)+Fz.RL(i)+Fz.RR(i))) * Fy_real(i);
        Fx.RL(i) = interp1(F_xRLmax(:,2,i),F_xRLmax(:,1,i),Fy_RLreal);  
    end
    a_y = Fy_real / Car.Mass.Total;
    Fy.FR = Fy.FL';
    Fy.RR = Fy.RL';
    Fx.FL = min(Fx.FL',Force.Powertrain.Thrust.FL);
    Fx.FR = Fx.FL;
    Fx.RL = min(Fx.RL',Force.Powertrain.Thrust.RL);
    Fx.RR = Fx.RL;
    % Wheel forces
    Force.Wheel.Fx.FL = Fx.FL;
    Force.Wheel.Fx.FR = Fx.FR;
    Force.Wheel.Fx.RL = Fx.RL;
    Force.Wheel.Fx.RR = Fx.RR;
    Force.Wheel.Fy.FL = Fy.FL;
    Force.Wheel.Fy.FR = Fy.FR;
    Force.Wheel.Fy.RL = Fy.RL;
    Force.Wheel.Fy.RR = Fy.RR;
    Force.Wheel.Fz.FL = Fz.FL;
    Force.Wheel.Fz.FR = Fz.FR;
    Force.Wheel.Fz.RL = Fz.RL;
    Force.Wheel.Fz.RR = Fz.RR;
    
    aSteeringWheel = curve_d;
    gLat = a_y / abs(Environment.Gravity);
    gLong = a_x / abs(Environment.Gravity);
    tLap = [0; cumsum(tLap)];
    Laptime = tLap(end);
    
    % Use throttle to find fuel/energy consumption
    if strcmp(Car.Category,'ICE') == 1
        MassFlowRate = (rThrottle * 0.0023) + 5.2842e-5; % Linear relationship to include idle fuel flow
        MassFlowRate(isnan(MassFlowRate)) = 5.2842e-5;
        mFuelBurn = trapz(tLap,MassFlowRate); % (kg)
        vFuelBurn = (mFuelBurn / 719.7) * 1000; % (litres)
        CO2_Usage = 2.31 * vFuelBurn;
        MotorPower = zeros(1,length(vCar));
    elseif strcmp(Car.Category,'EV') == 1
        % Get thrust from motors
        if strcmp(Car.Powertrain.Motor.Config,'fwd') == 1
            CombinedMotorThrust = Force.Powertrain.Thrust.FL + Force.Powertrain.Thrust.FR;
        elseif strcmp(Car.Powertrain.Motor.Config,'rwd') == 1
            CombinedMotorThrust = Force.Powertrain.Thrust.RL + Force.Powertrain.Thrust.RR;
        elseif strcmp(Car.Powertrain.Motor.Config,'4wd') == 1
            CombinedMotorThrust = Force.Powertrain.Thrust.FL + Force.Powertrain.Thrust.FR + Force.Powertrain.Thrust.RL + Force.Powertrain.Thrust.RR;
        else
            error('Incorrect motor configuration! How has the sim got this far???')
        end
        CombinedMotorThrust = CombinedMotorThrust.*rThrottle; % Find when motors are being applied
        MotorPower = CombinedMotorThrust .* vCar; % (W)
        EPower_avg = (trapz(tLap,MotorPower)) / Laptime;
        E_kwh = EPower_avg*(Laptime/3600)/1000;
        CO2_Usage = (0.65*E_kwh);
    elseif strcmp(Car.Category,'Hybrid') == 1% Assume half throttle for energy and fuel consumption each
        MassFlowRate = ((0.5*rThrottle) * 0.0023) + 5.2842e-5; % Linear relationship to include idle fuel flow
        MassFlowRate(isnan(MassFlowRate)) = 5.2842e-5;
        mFuelBurn = trapz(tLap,MassFlowRate); % (kg)
        vFuelBurn = (mFuelBurn / 719.7) * 1000; % (litres)
        CO2_Usage = 2.31 * vFuelBurn;
        % Get thrust from motors
        if strcmp(Car.Powertrain.Motor.Config,'fwd') == 1
            CombinedMotorThrust = Force.Powertrain.Thrust.FL + Force.Powertrain.Thrust.FR;
        elseif strcmp(Car.Powertrain.Motor.Config,'rwd') == 1
            CombinedMotorThrust = Force.Powertrain.Thrust.RL + Force.Powertrain.Thrust.RR;
        elseif strcmp(Car.Powertrain.Motor.Config,'4wd') == 1
            CombinedMotorThrust = Force.Powertrain.Thrust.FL + Force.Powertrain.Thrust.FR + Force.Powertrain.Thrust.RL + Force.Powertrain.Thrust.RR;
        else
            error('Incorrect motor configuration! How has the sim got this far???')
        end
        CombinedMotorThrust = CombinedMotorThrust.*rThrottle; % Find when motors are being applied
        MotorPower = CombinedMotorThrust .* vCar; % (W)
        EPower_avg = (trapz(tLap,MotorPower)) / Laptime;
        E_kwh = EPower_avg*(Laptime/3600)/1000;
        CO2_Usage = CO2_Usage + (0.65*E_kwh);
    end
    
    
    if SaveResults == 1
        % Save results to desired location
        yourFolder = [SaveLocation '\' FolderName];
        if ~exist(yourFolder, 'dir')
           mkdir(yourFolder)
        end
        sim_output_vars = {'Car','Environment','vCar','sLap','tLap','Force','Laptime','gLong','gLat','aSteeringWheel','rThrottle','rBrake','CO2_Usage','MotorPower'};
        save([SaveLocation '\' FolderName '\' SimName{iSweep} '.mat'],sim_output_vars{:})
    end

    disp(['Sims completed:  ' num2str(iSweep) '/' num2str(nSweeps) '       Laptime: ' num2str(Laptime) 's'])
end
    
end