function [velocity_d, Fx, Fy, Fz, SA, SL] = Vel_update(Fz_log,distanceTrack,dist_log,radius_d,Environment,Car,BoundaryConditions)

%% Finding max velocity at each curvature
radius_d(radius_d == 0) = 1e-5;

Fz_FL_t = Fz_log.Data(:,1);
Fz_FR_t = Fz_log.Data(:,2);
Fz_RL_t = Fz_log.Data(:,3);
Fz_RR_t = Fz_log.Data(:,4);

% time_d = interp1(dist_log.Data .* (max(distanceTrack)/max(dist_log.Data)),dist_log.Time,distanceTrack);
time_d = dist_log.Time;

Fz_FL_d = interp1(Fz_log.Time,Fz_FL_t,time_d);
Fz_FR_d = interp1(Fz_log.Time,Fz_FR_t,time_d);
Fz_RL_d = interp1(Fz_log.Time,Fz_RL_t,time_d);
Fz_RR_d = interp1(Fz_log.Time,Fz_RR_t,time_d);

% Define static forces before downforce is added
Fz_FL_static = Fz_FL_d;
Fz_FR_static = Fz_FR_d;
Fz_RL_static = Fz_RL_d;
Fz_RR_static = Fz_RR_d;

% Prepare dynamic zCoG position for load transfers
zCoG_dyn = Car.Dimension.CoG(3)*ones(length(radius_d),1);

% Prepare gears
NGear = ones(length(radius_d),1);
RPM_engine = ones(length(radius_d),1);

eps = 1;
eps_lim = 0.01;
v_x_check = zeros(1,length(distanceTrack));
while eps >= eps_lim

    for i = 1:length(distanceTrack)
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),F_xFLmin(:,:,i),F_yFLmin(:,:,i),...
            SA_FL_xmax(:,i),SA_FL_xmin(:,i),SL_FL_xmax(:,i),SL_FL_xmin(:,i),...
            SA_FL_ymax(:,i),SA_FL_ymin(:,i),SL_FL_ymax(:,i),SL_FL_ymin(:,i)] = tyre_fmax(Fz_FL_d(i),10);
        [F_xFR(:,:,i),F_yFR(:,:,i),F_xFRmax(:,:,i),F_yFRmax(:,:,i),F_xFRmin(:,:,i),F_yFRmin(:,:,i),...
            SA_FR_xmax(:,i),SA_FR_xmin(:,i),SL_FR_xmax(:,i),SL_FR_xmin(:,i),...
            SA_FR_ymax(:,i),SA_FR_ymin(:,i),SL_FR_ymax(:,i),SL_FR_ymin(:,i)] = tyre_fmax(Fz_FR_d(i),10);
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),F_xRLmin(:,:,i),F_yRLmin(:,:,i),...
            SA_RL_xmax(:,i),SA_RL_xmin(:,i),SL_RL_xmax(:,i),SL_RL_xmin(:,i),...
            SA_RL_ymax(:,i),SA_RL_ymin(:,i),SL_RL_ymax(:,i),SL_RL_ymin(:,i)] = tyre_fmax(Fz_RL_d(i),10);
        [F_xRR(:,:,i),F_yRR(:,:,i),F_xRRmax(:,:,i),F_yRRmax(:,:,i),F_xRRmin(:,:,i),F_yRRmin(:,:,i),...
            SA_RR_xmax(:,i),SA_RR_xmin(:,i),SL_RR_xmax(:,i),SL_RR_xmin(:,i),...
            SA_RR_ymax(:,i),SA_RR_ymin(:,i),SL_RR_ymax(:,i),SL_RR_ymin(:,i)] = tyre_fmax(Fz_RR_d(i),10);
    end

    for i = 1:length(radius_d)
        if sum(abs(F_yFLmax(:,1,i))) == 0
            Fy_FL(i) = 0;
        else
            Fy_FL(i) = interp1(F_yFLmax(:,1,i),F_yFLmax(:,2,i),0,'spline');
        end
        if sum(abs(F_yFRmax(:,1,i))) == 0
            Fy_FR(i) = 0;
        else
            Fy_FR(i) = interp1(F_yFRmax(:,1,i),F_yFRmax(:,2,i),0,'spline');
        end
        if sum(abs(F_yRLmax(:,1,i))) == 0
            Fy_RL(i) = 0;
        else
            Fy_RL(i) = interp1(F_yRLmax(:,1,i),F_yRLmax(:,2,i),0,'spline');
        end
        if sum(abs(F_yRRmax(:,1,i))) == 0
            Fy_RR(i) = 0;
        else
            Fy_RR(i) = interp1(F_yRRmax(:,1,i),F_yRRmax(:,2,i),0,'spline');
        end
    end
    Fy_total = Fy_FL + Fy_FR + Fy_RL + Fy_RR;
    v_x = (abs((Fy_total .* radius_d)/Car.Mass.Total)).^0.5;

    v_x(v_x > 75) = 75;

    % Add downforce
    for i = 1:length(v_x)
        [F_L,~] = Aero_Forces(v_x(i),Environment,Car);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    end
    
    % Check for convergence of velocities
    v_diff = (v_x - v_x_check)./v_x_check;
    eps = sqrt(mean(v_diff.^2));
    disp(['Approaching vCar convergence criterion: ' num2str(min((eps_lim/eps),1)*100) ' %'])
    v_x_check = v_x;
end
    
%% Applying power limit
disp('Applying power limits...')
v_x2 = zeros(length(distanceTrack),1);
if ~isempty(BoundaryConditions.vCar_start)
    v_x2(1) = BoundaryConditions.vCar_start;
end
Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;

for i = 1:length(distanceTrack)
    v_x2(i) = min(v_x2(i),v_x(i));
    
    [F_L,F_D] = Aero_Forces(v_x2(i),Environment,Car);
    % Recalculate downforce
    Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;
       
    Fy_real = (Car.Mass.Total * (v_x2(i)^2))/radius_d(i);
    
    [Engine_T,Gear,RPM_engine(i)] = Engine_Torque(v_x2(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Engine,Car.Gears,NGear(i));
    Engine_Fx = Engine_T ./ [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    NGear(i:end) = Gear;
    
    Motor_T = Motor_Torque(v_x2(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Motor);
    Motor_Fx = Motor_T ./ [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    
    Powertrain_Fx = Engine_Fx + Motor_Fx;
        
    eps = 1;
    Fz_check = [0 0 0 0];
    eps_lim = 0.01;
    while eps > eps_lim
        
        % Re-evaluate tyre potential
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),F_xFLmin(:,:,i),F_yFLmin(:,:,i),...
            SA_FL_xmax(:,i),SA_FL_xmin(:,i),SL_FL_xmax(:,i),SL_FL_xmin(:,i),...
            SA_FL_ymax(:,i),SA_FL_ymin(:,i),SL_FL_ymax(:,i),SL_FL_ymin(:,i)] = tyre_fmax(Fz_FL_d(i),10);
        [F_xFR(:,:,i),F_yFR(:,:,i),F_xFRmax(:,:,i),F_yFRmax(:,:,i),F_xFRmin(:,:,i),F_yFRmin(:,:,i),...
            SA_FR_xmax(:,i),SA_FR_xmin(:,i),SL_FR_xmax(:,i),SL_FR_xmin(:,i),...
            SA_FR_ymax(:,i),SA_FR_ymin(:,i),SL_FR_ymax(:,i),SL_FR_ymin(:,i)] = tyre_fmax(Fz_FR_d(i),10);
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),F_xRLmin(:,:,i),F_yRLmin(:,:,i),...
            SA_RL_xmax(:,i),SA_RL_xmin(:,i),SL_RL_xmax(:,i),SL_RL_xmin(:,i),...
            SA_RL_ymax(:,i),SA_RL_ymin(:,i),SL_RL_ymax(:,i),SL_RL_ymin(:,i)] = tyre_fmax(Fz_RL_d(i),10);
        [F_xRR(:,:,i),F_yRR(:,:,i),F_xRRmax(:,:,i),F_yRRmax(:,:,i),F_xRRmin(:,:,i),F_yRRmin(:,:,i),...
            SA_RR_xmax(:,i),SA_RR_xmin(:,i),SL_RR_xmax(:,i),SL_RR_xmin(:,i),...
            SA_RR_ymax(:,i),SA_RR_ymin(:,i),SL_RR_ymax(:,i),SL_RR_ymin(:,i)] = tyre_fmax(Fz_RR_d(i),10);
    
        Fy_FLreal(i) = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FL_d(i) == 0
            Fx_FLreal = 0;
            SA.FL(i) = 0;
            SL.FL(i) = 0;
        else
            Fx_FLreal = interp1(F_xFLmax(:,2,i),F_xFLmax(:,1,i),Fy_FLreal(i),'spline');
            SA.FL(i) = interp1(F_xFLmax(:,2,i),SA_FL_xmax(:,i),Fy_FLreal(i),'spline');
            SL.FL(i) = interp1(F_xFLmax(:,2,i),SL_FL_xmax(:,i),Fy_FLreal(i),'spline');
        end

        Fy_FRreal(i) = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FR_d(i) == 0
            Fx_FRreal = 0;
            SA.FR(i) = 0;
            SL.FR(i) = 0;
        else
            Fx_FRreal = interp1(F_xFRmax(:,2,i),F_xFRmax(:,1,i),Fy_FRreal(i),'spline');
            SA.FR(i) = interp1(F_xFRmax(:,2,i),SA_FR_xmax(:,i),Fy_FRreal(i),'spline');
            SL.FR(i) = interp1(F_xFRmax(:,2,i),SL_FR_xmax(:,i),Fy_FRreal(i),'spline');
        end

        Fy_RLreal(i) = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RL_d(i) == 0
            Fx_RLreal = 0;
            SA.RL(i) = 0;
            SL.RL(i) = 0;
        else
            Fx_RLreal = interp1(F_xRLmax(:,2,i),F_xRLmax(:,1,i),Fy_RLreal(i),'spline');
            SA.RL(i) = interp1(F_xRLmax(:,2,i),SA_RL_xmax(:,i),Fy_RLreal(i),'spline');
            SL.RL(i) = interp1(F_xRLmax(:,2,i),SL_RL_xmax(:,i),Fy_RLreal(i),'spline');
        end

        Fy_RRreal(i) = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RR_d(i) == 0
            Fx_RRreal = 0;
            SA.RR(i) = 0;
            SL.RR(i) = 0;
        else
            Fx_RRreal = interp1(F_xRRmax(:,2,i),F_xRRmax(:,1,i),Fy_RRreal(i),'spline');
            SA.RR(i) = interp1(F_xRRmax(:,2,i),SA_RR_xmax(:,i),Fy_RRreal(i),'spline');
            SL.RR(i) = interp1(F_xRRmax(:,2,i),SL_RR_xmax(:,i),Fy_RRreal(i),'spline');
        end
        Fx_traction = [Fx_FLreal; Fx_FRreal; Fx_RLreal; Fx_RRreal];
        
        % Check if throttle modulation required
%         Fx_real = min(Powertrain_Fx,Fx_traction);
        rThrottle = min(min(Fx_traction./Powertrain_Fx),1);
        Fx_real = Powertrain_Fx * rThrottle;
        Fx.FL(i) = Fx_real(1);
        Fx.FR(i) = Fx_real(2);
        Fx.RL(i) = Fx_real(3);
        Fx.RR(i) = Fx_real(4);

        Fx_sum = sum(Fx_real);
        % Account for drag and rolling resistance
        Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
        Fx_sum = Fx_sum - F_D - Fx_rollres;    

        a_x = Fx_sum / Car.Mass.Total;
        a_y = (v_x2(i)^2) / radius_d(i);
        
        % Carry out mass transfer checks
        [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y,zCoG_dyn(i));
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FL;
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FR;
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RL;
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RR;
        % If tyres lift from ground set force to 0
        Fz_FL_d(i) = min(Fz_FL_d(i),0);
        Fz_FR_d(i) = min(Fz_FR_d(i),0);
        Fz_RL_d(i) = min(Fz_RL_d(i),0);
        Fz_RR_d(i) = min(Fz_RR_d(i),0);
        % Calculate suspension effects (ride height, pitch and roll)
        dhRideFL(i) = (Fz_FL_d(i) - Fz_FL_static(i)) / Car.Sus.Front.Stiffness.Vertical;
        dhRideFR(i) = (Fz_FR_d(i) - Fz_FR_static(i)) / Car.Sus.Front.Stiffness.Vertical;
        dhRideRL(i) = (Fz_RL_d(i) - Fz_RL_static(i)) / Car.Sus.Rear.Stiffness.Vertical;
        dhRideRR(i) = (Fz_RR_d(i) - Fz_RR_static(i)) / Car.Sus.Rear.Stiffness.Vertical;
        dhRideF(i) = 0.5*(dhRideFL(i) + dhRideFR(i));
        dhRideR(i) = 0.5*(dhRideRL(i) + dhRideRR(i));
        hRideF(i) = Car.AeroPerformance.hRideF + dhRideF(i);
        hRideR(i) = Car.AeroPerformance.hRideR + dhRideR(i);
        theta_y(i) = 0.5*(atan(dhRideF(i)/(Car.Dimension.lWheelbase/2)) - atan(dhRideR(i)/(Car.Dimension.lWheelbase/2)));
%         theta_x(i) = 0.5*(atan((0.5*(dhRideFL(i) - dhRideFR(i)))/(Car.Dimension.Front_track/2)) + atan((0.5*(dhRideRL(i) - dhRideRR(i)))/(Car.Dimension.Rear_track/2)));
        aPitch(i) = rad2deg(theta_y(i));
        thetaF_x(i) = atan((0.5*(dhRideFL(i) - dhRideFR(i)))/(Car.Dimension.Front_track/2));
        thetaR_x(i) = atan((0.5*(dhRideRL(i) - dhRideRR(i)))/(Car.Dimension.Rear_track/2));
        aRollF(i) = rad2deg(thetaF_x(i));
        aRollR(i) = rad2deg(thetaR_x(i));
        % Update zCoG position for load transfers
        zCoG_dyn(i) = Car.Dimension.CoG(3) + (dhRideF(i)*(1-Car.Balance.CoG(1))) + (dhRideR(i)*Car.Balance.CoG(1));
        % Calculate tyre camber changes from static position
        Camber.FL(i) = Car.Tyres.Camber.FL + (aRollF(i)*Car.Tyres.CamberRollFactor.Front);
        Camber.FR(i) = Car.Tyres.Camber.FR - (aRollF(i)*Car.Tyres.CamberRollFactor.Front);
        Camber.RL(i) = Car.Tyres.Camber.RL + (aRollR(i)*Car.Tyres.CamberRollFactor.Rear);
        Camber.RR(i) = Car.Tyres.Camber.RR - (aRollR(i)*Car.Tyres.CamberRollFactor.Rear);
        
        eps = max(abs((Fz_check - [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)])./Fz_check));
        Fz_check = [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)];
        
    end   
    if i ~= length(distanceTrack)
        v_x2(i+1) = (v_x2(i)^2 + (2*a_x*(distanceTrack(i+1) - distanceTrack(i))))^0.5;
    end
end
Fz.FL = Fz_FL_d;
Fz.FR = Fz_FR_d;
Fz.RL = Fz_RL_d;
Fz.RR = Fz_RR_d;
Fy.FL = Fy_FLreal;
Fy.FR = Fy_FRreal;
Fy.RL = Fy_RLreal;
Fy.RR = Fy_RRreal;

%% Apply Braking Limit
disp('Applying brake limits...')
v_x3 = zeros(length(distanceTrack),1);
if ~isempty(BoundaryConditions.vCar_end)
    v_x3(end) = BoundaryConditions.vCar_end;
else
    v_x3(end) = v_x2(end);
end

for i = length(distanceTrack):-1:1
    v_x3(i) = min(v_x3(i),v_x2(i));
    
    [F_L,F_D] = Aero_Forces(v_x3(i),Environment,Car);
    % Recalculate downforce
    Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;
    
    Fy_real = (Car.Mass.Total * v_x3(i)^2)/radius_d(i);
    
    Brake_Fx = Brake_Model(Car.Brakes) ./ ...
                    [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                    Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius]; 
    
    eps = 1;
    Fz_check = [0 0 0 0];
    eps_lim = 0.01;
    while eps > eps_lim
        
        % Re-evaluate tyre potential
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),F_xFLmin(:,:,i),F_yFLmin(:,:,i),...
            SA_FL_xmax(:,i),SA_FL_xmin(:,i),SL_FL_xmax(:,i),SL_FL_xmin(:,i),...
            SA_FL_ymax(:,i),SA_FL_ymin(:,i),SL_FL_ymax(:,i),SL_FL_ymin(:,i)] = tyre_fmax(Fz_FL_d(i),10);
        [F_xFR(:,:,i),F_yFR(:,:,i),F_xFRmax(:,:,i),F_yFRmax(:,:,i),F_xFRmin(:,:,i),F_yFRmin(:,:,i),...
            SA_FR_xmax(:,i),SA_FR_xmin(:,i),SL_FR_xmax(:,i),SL_FR_xmin(:,i),...
            SA_FR_ymax(:,i),SA_FR_ymin(:,i),SL_FR_ymax(:,i),SL_FR_ymin(:,i)] = tyre_fmax(Fz_FR_d(i),10);
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),F_xRLmin(:,:,i),F_yRLmin(:,:,i),...
            SA_RL_xmax(:,i),SA_RL_xmin(:,i),SL_RL_xmax(:,i),SL_RL_xmin(:,i),...
            SA_RL_ymax(:,i),SA_RL_ymin(:,i),SL_RL_ymax(:,i),SL_RL_ymin(:,i)] = tyre_fmax(Fz_RL_d(i),10);
        [F_xRR(:,:,i),F_yRR(:,:,i),F_xRRmax(:,:,i),F_yRRmax(:,:,i),F_xRRmin(:,:,i),F_yRRmin(:,:,i),...
            SA_RR_xmax(:,i),SA_RR_xmin(:,i),SL_RR_xmax(:,i),SL_RR_xmin(:,i),...
            SA_RR_ymax(:,i),SA_RR_ymin(:,i),SL_RR_ymax(:,i),SL_RR_ymin(:,i)] = tyre_fmax(Fz_RR_d(i),10);
        
        Fy_FLreal(i) = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FL_d(i) == 0
            Fx_FLreal = 0;
            SA_FL = 0;
            SL_FL = 0;
        else
            Fx_FLreal = interp1(F_xFLmin(:,2,i),F_xFLmin(:,1,i),Fy_FLreal(i),'spline');
            SA_FL = interp1(F_xFLmin(:,2,i),SA_FL_xmin(:,i),Fy_FLreal(i),'spline');
            SL_FL = interp1(F_xFLmin(:,2,i),SL_FL_xmin(:,i),Fy_FLreal(i),'spline');
        end

        Fy_FRreal(i) = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FR_d(i) == 0
            Fx_FRreal = 0;
            SA_FR = 0;
            SL_FR = 0;
        else
            Fx_FRreal = interp1(F_xFRmin(:,2,i),F_xFRmin(:,1,i),Fy_FRreal(i),'spline');
            SA_FR = interp1(F_xFRmin(:,2,i),SA_FR_xmin(:,i),Fy_FRreal(i),'spline');
            SL_FR = interp1(F_xFRmin(:,2,i),SL_FR_xmin(:,i),Fy_FRreal(i),'spline');
        end

        Fy_RLreal(i) = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RL_d(i) == 0
            Fx_RLreal = 0;
            SA_RL = 0;
            SL_RL = 0;
        else
            Fx_RLreal = interp1(F_xRLmin(:,2,i),F_xRLmin(:,1,i),Fy_RLreal(i),'spline');
            SA_RL = interp1(F_xRLmin(:,2,i),SA_RL_xmin(:,i),Fy_RLreal(i),'spline');
            SL_RL = interp1(F_xRLmin(:,2,i),SL_RL_xmin(:,i),Fy_RLreal(i),'spline');
        end

        Fy_RRreal(i) = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RR_d(i) == 0
            Fx_RRreal = 0;
            SA_RR = 0;
            SL_RR = 0;
        else
            Fx_RRreal = interp1(F_xRRmin(:,2,i),F_xRRmin(:,1,i),Fy_RRreal(i),'spline');
            SA_RR = interp1(F_xRRmin(:,2,i),SA_RR_xmin(:,i),Fy_RRreal(i),'spline');
            SL_RR = interp1(F_xRRmin(:,2,i),SL_RR_xmin(:,i),Fy_RRreal(i),'spline');
        end

        Fx_traction = [Fx_FLreal; Fx_FRreal; Fx_RLreal; Fx_RRreal];
        
        % Check if brake modulation required
%         Fx_real = max(Brake_Fx,Fx_traction);
        rBrake = min(min(Fx_traction./Brake_Fx),1);
        Fx_real = Brake_Fx * rBrake;
        
        Fx_sum = sum(Fx_real);
        % Account for drag and rolling resistance
        Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
        Fx_sum = Fx_sum - F_D - Fx_rollres;

        a_x = Fx_sum / Car.Mass.Total;
        a_y = (v_x3(i)^2) / radius_d(i);

        % Carry out mass transfer checks
        [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y,zCoG_dyn(i));
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FL;
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FR;
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RL;
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RR;
        % If tyres lift from ground set force to 0
        Fz_FL_d(i) = min(Fz_FL_d(i),0);
        Fz_FR_d(i) = min(Fz_FR_d(i),0);
        Fz_RL_d(i) = min(Fz_RL_d(i),0);
        Fz_RR_d(i) = min(Fz_RR_d(i),0);
        % Calculate suspension effects (ride height, pitch and roll)
        dhRideFL(i) = (Fz_FL_d(i) - Fz_FL_static(i)) / Car.Sus.Front.Stiffness.Vertical;
        dhRideFR(i) = (Fz_FR_d(i) - Fz_FR_static(i)) / Car.Sus.Front.Stiffness.Vertical;
        dhRideRL(i) = (Fz_RL_d(i) - Fz_RL_static(i)) / Car.Sus.Rear.Stiffness.Vertical;
        dhRideRR(i) = (Fz_RR_d(i) - Fz_RR_static(i)) / Car.Sus.Rear.Stiffness.Vertical;
        dhRideF(i) = 0.5*(dhRideFL(i) + dhRideFR(i));
        dhRideR(i) = 0.5*(dhRideRL(i) + dhRideRR(i));
        hRideF(i) = Car.AeroPerformance.hRideF + dhRideF(i);
        hRideR(i) = Car.AeroPerformance.hRideR + dhRideR(i);
        theta_y(i) = 0.5*(atan(dhRideF(i)/(Car.Dimension.lWheelbase/2)) - atan(dhRideR(i)/(Car.Dimension.lWheelbase/2)));
%         theta_x(i) = 0.5*(atan((0.5*(dhRideFL(i) - dhRideFR(i)))/(Car.Dimension.Front_track/2)) + atan((0.5*(dhRideRL(i) - dhRideRR(i)))/(Car.Dimension.Rear_track/2)));
        aPitch(i) = rad2deg(theta_y(i));
        thetaF_x(i) = atan((0.5*(dhRideFL(i) - dhRideFR(i)))/(Car.Dimension.Front_track/2));
        thetaR_x(i) = atan((0.5*(dhRideRL(i) - dhRideRR(i)))/(Car.Dimension.Rear_track/2));
        aRollF(i) = rad2deg(thetaF_x(i));
        aRollR(i) = rad2deg(thetaR_x(i));
        % Update zCoG position for load transfers
        zCoG_dyn(i) = Car.Dimension.CoG(3) + (dhRideF(i)*(1-Car.Balance.CoG(1))) + (dhRideR(i)*Car.Balance.CoG(1));
        % Calculate tyre camber changes from static position
        Camber.FL(i) = Car.Tyres.Camber.FL + (aRollF(i)*Car.Tyres.CamberRollFactor.Front);
        Camber.FR(i) = Car.Tyres.Camber.FR - (aRollF(i)*Car.Tyres.CamberRollFactor.Front);
        Camber.RL(i) = Car.Tyres.Camber.RL + (aRollR(i)*Car.Tyres.CamberRollFactor.Rear);
        Camber.RR(i) = Car.Tyres.Camber.RR - (aRollR(i)*Car.Tyres.CamberRollFactor.Rear);
        
        eps = max(abs((Fz_check - [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)])./Fz_check));
        Fz_check = [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)];
        
    end
    if i ~= 1
        v_x3(i-1) = ((v_x3(i)^2) - (2*a_x*(distanceTrack(i) - distanceTrack(i-1))))^0.5;
        if v_x3(i-1) < v_x2(i-1)
            % Override tyre forces if brake limits is applied
            Fx.FL(i) = Fx_real(1);
            Fx.FR(i) = Fx_real(2);
            Fx.RL(i) = Fx_real(3);
            Fx.RR(i) = Fx_real(4);
            Fy.FL(i) = Fy_FLreal(i);
            Fy.FR(i) = Fy_FRreal(i);
            Fy.RL(i) = Fy_RLreal(i);
            Fy.RR(i) = Fy_RRreal(i);
            Fz.FL(i) = Fz_FL_d(i);
            Fz.FR(i) = Fz_FR_d(i);
            Fz.RL(i) = Fz_RL_d(i);
            Fz.RR(i) = Fz_RR_d(i);
            SA.FL(i) = SA_FL;
            SA.FR(i) = SA_FR;
            SA.RL(i) = SA_RL;
            SA.RR(i) = SA_RR;
            SL.FL(i) = SL_FL;
            SL.FR(i) = SL_FR;
            SL.RL(i) = SL_RL;
            SL.RR(i) = SL_RR;
        end
    end    
end
v_x3(1) = min(v_x3(1),v_x2(1));

%% Output
velocity_d = v_x3;

