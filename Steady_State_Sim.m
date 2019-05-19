function Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,BoundaryConditions,Sweep,Solver)

if Sweep.Choose == 1
    nSweeps = length(Sweep.Values);
    if length(SimName) == length(Sweep.Values)
        SimName = SimName;
    else
        for i = 1:length(Sweep.Values)
            SimName{i} = ['Sim' num2str(i)];
        end
    end
else
    nSweeps = 1;
end

for iSweep = 1:nSweeps
    
    %% Loading Car and Stuff like weather
    [Car,Environment] = Load_Params();

    % Override car params for sweep
    if Sweep.Choose == 1
        eval([Sweep.Param{1},'=',num2str(Sweep.Values(iSweep)),';']);
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
    % %     [x,y,theta_d,curve_d,radius_d,dist] = Track_Gen('FSUK Track Endurance.csv',Track_Dist*Resolution,Track_Dist,'On','On',Track_Width,Iterations);

    % Load racing line to skip repeatedely optimising the same track everytime
    load(trackmap)
    %     [x_new,y_new] = Path_Optim(x,y,x0,y0,theta_d,Track_Width,Iterations);
    radius_d = interp1([1:length(radius_d)],radius_d,[1:length(dist)]);

    %% Running Sim
    ControlSystemDriverModel = Simulink.Variant('Driver_Model == 1');
    InputDefinedDriverModel = Simulink.Variant('Driver_Model == 2');
    Driver_Model = 1;

    % Distribute mass based on CoG location
    Fz_log = [];
    dist_log = [];
    Fz_log.Data = Car.Mass.Total .* Environment.Gravity .* ones(length(dist),4) ./ 2; % Total weight split evenly across each axis
    Fz_log.Data(:,[1,2]) = Fz_log.Data(:,[1,2]) * (1 - Car.Balance.CoG);
    Fz_log.Data(:,[3,4]) = Fz_log.Data(:,[3,4]) * (Car.Balance.CoG);
    Fz_log.Time = linspace(0,120,length(dist))';
    dist_log.Data = dist;
    dist_log.Time = linspace(0,120,length(dist))';

    vCar = Vel_update(Fz_log,dist,dist_log,radius_d,Environment,Car,BoundaryConditions);
    sLap = dist;
    for i = 1:length(vCar) - 1
        tLap(i,1) = 2*(sLap(i+1)-sLap(i))/(vCar(i)+vCar(i+1));
    end
    tLap = cumsum(tLap);
    for i = 1:length(vCar)
        T = Motor_Torque(vCar(i),0.175,3,240,80000)' ./ [Car.Dimension.WheelFL.Radius Car.Dimension.WheelFR.Radius Car.Dimension.WheelRL.Radius Car.Dimension.WheelRR.Radius];
        Force.Engine.Thrust.FL(i,1) = T(1);
        Force.Engine.Thrust.FR(i,1) = T(2);
        Force.Engine.Thrust.RL(i,1) = T(3);
        Force.Engine.Thrust.RR(i,1) = T(4);
        [Force.Aero.Downforce(i,1),Force.Aero.Drag(i,1)] = Aero_Forces(vCar(i),Environment,Car);
    end
    % Tyre forces
    % Fz
    Fz.FL = ((Car.Mass.Total*Environment.Gravity*ones(length(vCar),1) * (1 - Car.Balance.CoG)) /2) - (Force.Aero.Downforce * (1 - Car.Balance.Aerobalance))/2;
    Fz.FR = Fz.FL;
    Fz.RL = ((Car.Mass.Total*Environment.Gravity*ones(length(vCar),1) * (Car.Balance.CoG)) /2) - (Force.Aero.Downforce * (Car.Balance.Aerobalance))/2;
    Fz.RR = Fz.RL;
    %Fx
    for i = 1:length(vCar)
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),...
            F_xFLmin(:,:,i),F_yFLmin(:,:,i)] = tyre_fmax(Fz.FL(i),20);
        Fy.FL(i) = interp1(F_yFLmax(:,1,i),F_yFLmax(:,2,i),0,'spline');
        Fy_real = (Car.Mass.Total * vCar(i)^2)/radius_d(i);
        Fy_FLreal = (Fz.FL(i) / sum(Fz.FL(i)+Fz.FR(i)+Fz.RL(i)+Fz.RR(i))) * Fy_real;
        Fx.FL(i) = interp1(F_xFLmax(:,2,i),F_xFLmax(:,1,i),Fy_FLreal);        
        
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),...
            F_xRLmin(:,:,i),F_yRLmin(:,:,i)] = tyre_fmax(Fz.RL(i),20);
        Fy.RL(i) = interp1(F_yRLmax(:,1,i),F_yRLmax(:,2,i),0,'spline');
        Fy_RLreal = (Fz.RL(i) / sum(Fz.FL(i)+Fz.FR(i)+Fz.RL(i)+Fz.RR(i))) * Fy_real;
        Fx.RL(i) = interp1(F_xRLmax(:,2,i),F_xRLmax(:,1,i),Fy_RLreal);  
    end
    Fy.FR = Fy.FL;
    Fx.FR = Fx.FL;
    Fy.RR = Fy.RL;
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
    
    % Save results to desired location
    if iSweep == 1
        mkdir([SaveLocation '\' FolderName])
    end
    sim_output_vars = {'vCar','sLap','tLap','Force'};
    save([SaveLocation '\' FolderName '\' SimName{iSweep} '.mat'],sim_output_vars{:})
    
    disp(['Sims completed:  ' num2str(iSweep) '/' num2str(nSweeps) '       Laptime: ' num2str(tLap(end)) 's'])
end
    
end