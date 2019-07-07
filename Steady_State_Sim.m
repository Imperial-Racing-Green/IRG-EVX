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
%         if ~exist(Sweep.Param{1})
%             error('Parameter being swept does not exist. Check carfile for sweepable parameters')
%         else
            % Override car param
            eval([Sweep.Param{1},'=',num2str(Sweep.Values(iSweep)),';']);
%         end
    elseif Sweep.Choose_Carfile == 1
        % Load in a new carfile
        clear Car
        load(Sweep.Carfile{iSweep});
        if Validation ~= 1  % Only recheck mass for our own car (where we have component masses)
            Car.Mass.Total = Car.Mass.WheelFL + Car.Mass.WheelFR + Car.Mass.WheelRL + Car.Mass.WheelRR + ...
                 Car.Mass.Driver + Car.Mass.Suspension + Car.Mass.Chassis + Car.Mass.Battery + ...
                 Car.Mass.Engine + Car.Mass.Motors + Car.Mass.MotorControllers + Car.Mass.MotorGears + ...
                 Car.Mass.Steering + Car.Mass.Pedals + Car.Mass.Seat + Car.Mass.FireWall + ...
                 Car.Mass.Cooling + Car.Mass.FrontWing + Car.Mass.RearWing + Car.Mass.Floor + ...
                 Car.Mass.Bodywork + Car.Mass.Brakes + Car.Mass.Fueltank + Car.Mass.Misc;            
        end
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

    Track_Dist = 1200; %track distance in metres
    Track_Width = 4; %track width in meteres
    % Max_Track_Resolution = 1; %track points per metre
    Steps = 1; %steps in optmisation smoothness
    % Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
    Resolution = 0.5;
    Iterations = 5000; %max iterations for optmisation

    %[x,y,theta,curvature,radius,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing,Line_Optim,Track_Width,Optim_Iterations)
    % %     [x,y,theta_d,curve_d,radius_d,distanceTrack] = Track_Gen('FSUK Track Endurance.csv',Track_Dist*Resolution,Track_Dist,'On','On',Track_Width,Iterations);

    % Load racing line to skip repeatedely optimising the same track everytime
    load(trackmap)
    %     [x_new,y_new] = Path_Optim(x,y,x0,y0,theta_d,Track_Width,Iterations);
    radius_d = interp1([1:length(radius_d)],radius_d,[1:length(distanceTrack)]);
    % Remove NaNs from interpolation
    [~,idx] = find(isnan(radius_d));
    for i = 1:length(idx)
        radius_d(idx(i)) = radius_d(idx(i)-1);
    end

    %% Running Sim
    ControlSystemDriverModel = Simulink.Variant('Driver_Model == 1');
    InputDefinedDriverModel = Simulink.Variant('Driver_Model == 2');
    Driver_Model = 1;

    % Distribute mass based on CoG location
    Fz_log = [];
    dist_log = [];
    Fz_log.Data = Car.Mass.Total .* Environment.Gravity .* ones(length(distanceTrack),4) ./ 2; % Total weight split evenly across each axis
    Fz_log.Data(:,[1,2]) = Fz_log.Data(:,[1,2]) * (1 - Car.Balance.CoG(1));
    Fz_log.Data(:,[3,4]) = Fz_log.Data(:,[3,4]) * (Car.Balance.CoG(1));
    Fz_log.Time = linspace(0,120,length(distanceTrack))';
    dist_log.Data = distanceTrack;
    dist_log.Time = linspace(0,120,length(distanceTrack))';
    %% Main simulation for tyre forces and velocity trace
    [vCar, Fx, Fy, Fz, SA, SL] = Vel_update(Fz_log,distanceTrack,dist_log,radius_d,Environment,Car,BoundaryConditions);
    
    %% Post-processing (simulation is over)
    sLap = distanceTrack;
    tLap = [];
    for i = 1:(length(vCar)-1)
        tLap(i,1) = 2*(sLap(i+1)-sLap(i))/(vCar(i)+vCar(i+1));
    end
    % Find maximum braking and powertrain forces
    Brake_Fx = Brake_Model(Car.Brakes) ./ ...
                    [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                    Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    Force.Brakes.FL = Brake_Fx(1);
    Force.Brakes.FR = Brake_Fx(2);
    Force.Brakes.RL = Brake_Fx(3);
    Force.Brakes.RR = Brake_Fx(4);
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
    % Find throttle and brake traces
    a_x = diff(vCar)./tLap;
    a_x = [a_x; a_x(end)];
    Fx_real = Car.Mass.Total * a_x;
    Fy_real = (Car.Mass.Total * (vCar.^2))./radius_d';
    a_y = Fy_real / Car.Mass.Total;
    Fx_rollres = -(Fz.FL+ Fz.FR + Fz.RL + Fz.RR) * Car.Tyres.Coefficients.RollingResistance;
    Fx_mechanical = Fx_real + Force.Aero.Drag + Fx_rollres;
    fwd_T = Fx_mechanical;
    fwd_T(fwd_T <= 0) = 0;
    bkd_T = -Fx_mechanical;
    bkd_T(bkd_T <= 0) = 0;
    rThrottle = fwd_T ./ Force.Powertrain.Thrust.Total;
    rBrake = bkd_T ./ Force.Brakes.Total;
    % Wheel forces (include drag and rolling resistance)
    Force.Wheel.Fx.FL = Fx.FL' - (Force.Aero.Drag/4)  + (Fz.FL*Car.Tyres.Coefficients.RollingResistance);
    Force.Wheel.Fx.FR = Fx.FR' - (Force.Aero.Drag/4)  + (Fz.FR*Car.Tyres.Coefficients.RollingResistance);
    Force.Wheel.Fx.RL = Fx.RL' - (Force.Aero.Drag/4)  + (Fz.RL*Car.Tyres.Coefficients.RollingResistance);
    Force.Wheel.Fx.RR = Fx.RR' - (Force.Aero.Drag/4)  + (Fz.RR*Car.Tyres.Coefficients.RollingResistance);
    Force.Wheel.Fy.FL = Fy.FL';
    Force.Wheel.Fy.FR = Fy.FR';
    Force.Wheel.Fy.RL = Fy.RL';
    Force.Wheel.Fy.RR = Fy.RR';
    Force.Wheel.Fz.FL = Fz.FL;
    Force.Wheel.Fz.FR = Fz.FR;
    Force.Wheel.Fz.RL = Fz.RL;
    Force.Wheel.Fz.RR = Fz.RR;
    % Calculate suspension effects (ride height, pitch and roll)
    dhRideFL = (Fz.FL - Fz_log.Data(:,1)) / Car.Sus.Front.Stiffness.Vertical;
    dhRideFR = (Fz.FR - Fz_log.Data(:,2)) / Car.Sus.Front.Stiffness.Vertical;
    dhRideRL = (Fz.RL - Fz_log.Data(:,3)) / Car.Sus.Rear.Stiffness.Vertical;
    dhRideRR = (Fz.RR - Fz_log.Data(:,4)) / Car.Sus.Rear.Stiffness.Vertical;
    dhRideF = 0.5*(dhRideFL + dhRideFR);
    dhRideR = 0.5*(dhRideRL + dhRideRR);
    hRideF = Car.AeroPerformance.hRideF + dhRideF;
    hRideR = Car.AeroPerformance.hRideR + dhRideR;
    theta_y = 0.5*(atan(dhRideF/(Car.Dimension.lWheelbase/2)) - atan(dhRideR/(Car.Dimension.lWheelbase/2)));
    theta_x = 0.5*(atan((0.5*(dhRideFL - dhRideFR))/(Car.Dimension.Front_track/2)) - atan((0.5*(dhRideRL - dhRideRR))/(Car.Dimension.Rear_track/2)));
    aPitch = rad2deg(theta_y);
    aRoll = rad2deg(theta_x);
    % Calculate tyre camber changes from static position
    Camber.FL = Car.Tyres.Camber.FL + (aRoll*Car.Tyres.CamberRollFactor.Front);
    Camber.FR = Car.Tyres.Camber.FR - (aRoll*Car.Tyres.CamberRollFactor.Front);
    Camber.RL = Car.Tyres.Camber.RL + (aRoll*Car.Tyres.CamberRollFactor.Rear);
    Camber.RR = Car.Tyres.Camber.RR - (aRoll*Car.Tyres.CamberRollFactor.Rear);
    
%     SlipAngle.Front = 0.5*(SA.FL + SA.FR);
%     SlipAngle.Rear = 0.5*(SA.RL + SA.RR);
    A = [SA.FL; SA.FR];
    [~,index] = max(abs(A));
    SlipAngle.Front = A(sub2ind(size(A),index,1:size(A,2)));
    A = [SA.RL; SA.RR];
    [~,index] = max(abs(A));
    SlipAngle.Rear = A(sub2ind(size(A),index,1:size(A,2)));
    aSteer = rad2deg((atan(Car.Dimension.lWheelbase ./ radius_d))) + (abs(SlipAngle.Front) - abs(SlipAngle.Rear));    % Tyre steer angle
    aSteeringWheel = aSteer * Car.Steering.Ratio;   % Steering wheel angle
    aUOSteer = abs(SlipAngle.Front) - abs(SlipAngle.Rear);    % Under/oversteer angle
    gLat = a_y / abs(Environment.Gravity);
    gLong = a_x / abs(Environment.Gravity);
    tLap = [0; cumsum(tLap)];
    Laptime = tLap(end);
    
    % Find tyre grip info
    Grip.FL.mu_x = Force.Wheel.Fx.FL ./ (-Force.Wheel.Fz.FL);
    Grip.FR.mu_x = Force.Wheel.Fx.FR ./ (-Force.Wheel.Fz.FR);
    Grip.RL.mu_x = Force.Wheel.Fx.RL ./ (-Force.Wheel.Fz.RL);
    Grip.RR.mu_x = Force.Wheel.Fx.RR ./ (-Force.Wheel.Fz.RR);
    Grip.FL.mu_y = Force.Wheel.Fy.FL ./ (-Force.Wheel.Fz.FL);
    Grip.FR.mu_y = Force.Wheel.Fy.FR ./ (-Force.Wheel.Fz.FR);
    Grip.RL.mu_y = Force.Wheel.Fy.RL ./ (-Force.Wheel.Fz.RL);
    Grip.RR.mu_y = Force.Wheel.Fy.RR ./ (-Force.Wheel.Fz.RR);
    Grip.FL.mu_total = sqrt((Grip.FL.mu_x.^2) + (Grip.FL.mu_y.^2));
    Grip.FR.mu_total = sqrt((Grip.FR.mu_x.^2) + (Grip.FR.mu_y.^2));
    Grip.RL.mu_total = sqrt((Grip.RL.mu_x.^2) + (Grip.RL.mu_y.^2));
    Grip.RR.mu_total = sqrt((Grip.RR.mu_x.^2) + (Grip.RR.mu_y.^2));
    
    
    % Use throttle to find fuel/energy consumption
    if strcmp(Car.Category,'ICE') == 1
        % Assume rear wheel drive
        MassFlowRate = ((Force.Wheel.Fx.RL + Force.Wheel.Fx.RR) * 1.42257529870920e-06) + 6.84678641286606e-05; % Linear relationship to include idle fuel flow
        MassFlowRate(MassFlowRate < 6.84678641286606e-05) = 6.84678641286606e-05;   % No gaining fuel under braking!
        mFuelBurn = trapz(tLap,MassFlowRate); % (kg)
        vFuelBurn = (mFuelBurn / 719.7) * 1000; % (litres)
        CO2_Usage = 2.31 * vFuelBurn;
        MotorPower = zeros(1,length(vCar));
    elseif strcmp(Car.Category,'EV') == 1
        % Get power from motors
        if strcmp(Car.Powertrain.Motor.Config,'fwd') == 1
            CombinedMotorThrust = Force.Wheel.Fx.FL + Force.Wheel.Fx.FR;    
            MotorPower = CombinedMotorThrust .* vCar; % (W)
            MotorPower(MotorPower < 0) = 0; % No motor power when tyres have negative thrust (under braking)
            MotorPower(MotorPower > (2*Car.Powertrain.Motor.P_max)) = Car.Powertrain.Motor.P_max * 2;
        elseif strcmp(Car.Powertrain.Motor.Config,'rwd') == 1
            CombinedMotorThrust = Force.Wheel.Fx.RL + Force.Wheel.Fx.RR;    
            MotorPower = CombinedMotorThrust .* vCar; % (W)
            MotorPower(MotorPower < 0) = 0; % No motor power when tyres have negative thrust (under braking)
            MotorPower(MotorPower > (2*Car.Powertrain.Motor.P_max)) = Car.Powertrain.Motor.P_max * 2;
        elseif strcmp(Car.Powertrain.Motor.Config,'4wd') == 1
            CombinedMotorThrust = Force.Wheel.Fx.FL + Force.Wheel.Fx.FR + Force.Wheel.Fx.RL + Force.Wheel.Fx.RR; 
            MotorPower = CombinedMotorThrust .* vCar; % (W)
            MotorPower(MotorPower < 0) = 0; % No motor power when tyres have negative thrust (under braking)
            MotorPower(MotorPower > (4*Car.Powertrain.Motor.P_max)) = Car.Powertrain.Motor.P_max * 4;
        else
            error('Incorrect motor configuration! How has the sim got this far???')
        end
        EPower_avg = (trapz(tLap,MotorPower)) / Laptime;
        E_kwh = EPower_avg*(Laptime/3600)/1000;
        CO2_Usage = (0.65*E_kwh);
    elseif strcmp(Car.Category,'Hybrid') == 1
        % Assume rear wheel drive
        MassFlowRate = ((Force.Wheel.Fx.RL + Force.Wheel.Fx.RR) * 1.42257529870920e-06) + 6.84678641286606e-05; % Linear relationship to include idle fuel flow
        MassFlowRate(MassFlowRate < 6.84678641286606e-05) = 6.84678641286606e-05; % No gaining fuel under braking!
        mFuelBurn = trapz(tLap,MassFlowRate); % (kg)
        vFuelBurn = (mFuelBurn / 719.7) * 1000; % (litres)
        CO2_Usage = 2.31 * vFuelBurn;
        % Get power from motors
        if strcmp(Car.Powertrain.Motor.Config,'fwd') == 1
            CombinedMotorThrust = Force.Wheel.Fx.FL + Force.Wheel.Fx.FR;    
            MotorPower = CombinedMotorThrust .* vCar; % (W)
            MotorPower(MotorPower < 0) = 0; % No motor power when tyres have negative thrust (under braking)
            MotorPower(MotorPower > (2*Car.Powertrain.Motor.P_max)) = Car.Powertrain.Motor.P_max * 2;
        elseif strcmp(Car.Powertrain.Motor.Config,'rwd') == 1
            CombinedMotorThrust = Force.Wheel.Fx.RL + Force.Wheel.Fx.RR;    
            MotorPower = CombinedMotorThrust .* vCar; % (W)
            MotorPower(MotorPower < 0) = 0; % No motor power when tyres have negative thrust (under braking)
            MotorPower(MotorPower > (2*Car.Powertrain.Motor.P_max)) = Car.Powertrain.Motor.P_max * 2;
        elseif strcmp(Car.Powertrain.Motor.Config,'4wd') == 1
            CombinedMotorThrust = Force.Wheel.Fx.FL + Force.Wheel.Fx.FR + Force.Wheel.Fx.RL + Force.Wheel.Fx.RR; 
            MotorPower = CombinedMotorThrust .* vCar; % (W)
            MotorPower(MotorPower < 0) = 0; % No motor power when tyres have negative thrust (under braking)
            MotorPower(MotorPower > (4*Car.Powertrain.Motor.P_max)) = Car.Powertrain.Motor.P_max * 4;
        else
            error('Incorrect motor configuration! How has the sim got this far???')
        end
        EPower_avg = (trapz(tLap,MotorPower)) / Laptime;
        E_kwh = EPower_avg*(Laptime/3600)/1000;
        CO2_Usage = CO2_Usage + (0.65*E_kwh);
    end
    
    %% Stability analasis checks
    vCar_avg_corner = 20;   % Avergae cornering speed (m/s)
    % Static stability
    [K,SM,SI,UG,V_tangent,V_crit,V_char,K_Aero,SM_Aero,SI_Aero,UG_Aero,V_tangent_Aero,V_crit_Aero,V_char_Aero,delta_neutral] = s_stab(Car.Mass.Total,vCar_avg_corner,Car.Dimension.lWheelbase,Car.Balance.CoG(1),Car.Balance.CoP(1),-Car.AeroPerformance.SC_L,radius_d);
    Stability.Static.K = K;
    Stability.Static.SM = SM;
    Stability.Static.SI = SI;
    Stability.Static.UG = UG;
    Stability.Static.V_tangent = V_tangent;
    Stability.Static.V_crit = V_crit;
    Stability.Static.V_char = V_char;
    Stability.Static.K_Aero = K_Aero;
    Stability.Static.SM_Aero = SM_Aero;
    Stability.Static.SI_Aero = SI_Aero;
    Stability.Static.UG_Aero = UG_Aero;
    Stability.Static.V_tangent_Aero = V_tangent_Aero;
    Stability.Static.V_crit_Aero = V_crit_Aero;
    Stability.Static.V_char_Aero = V_char_Aero;
    Stability.Static.delta_neutral = delta_neutral;
    % Dynamic Stability
    [E_Values] = d_stab(Car.Mass.Total,vCar_avg_corner,Car.Dimension.lWheelbase,Car.Balance.CoG(1),Car.Balance.CoP(1),-Car.AeroPerformance.SC_L);
    Stability.Dynamic.E_Values = E_Values;

    if SaveResults == 1
        % Save results to desired location
        yourFolder = [SaveLocation '\' FolderName];
        if ~exist(yourFolder, 'dir')
           mkdir(yourFolder)
        end
        sim_output_vars = {'Car','Environment','vCar','sLap','tLap','Force','Laptime','gLong','gLat','aSteeringWheel','rThrottle',...
                           'rBrake','CO2_Usage','MotorPower','Stability','aUOSteer','hRideF','hRideR','aPitch','aRoll','Camber','Grip'};
        save([SaveLocation '\' FolderName '\' SimName{iSweep} '.mat'],sim_output_vars{:})
    end

    disp(['Sims completed:  ' num2str(iSweep) '/' num2str(nSweeps) '       Laptime: ' num2str(Laptime) 's'])
    disp('--------------------------------------------------------')
end
    
end