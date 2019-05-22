function velocity_d = Vel_update(Fz_log,dist,dist_log,radius_d,Environment,Car,BoundaryConditions)

%% Finding max velocity at each curvature

Fz_FL_t = Fz_log.Data(:,1);
Fz_FR_t = Fz_log.Data(:,2);
Fz_RL_t = Fz_log.Data(:,3);
Fz_RR_t = Fz_log.Data(:,4);

% time_d = interp1(dist_log.Data .* (max(dist)/max(dist_log.Data)),dist_log.Time,dist);
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

eps = 1501;
eps_lim = 1500;
v_x_check = zeros(1,length(dist));
while eps >= eps_lim

    for i = 1:length(dist)
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),...
            F_xFLmin(:,:,i),F_yFLmin(:,:,i)] = tyre_fmax(Fz_FL_d(i),20);
        [F_xFR(:,:,i),F_yFR(:,:,i),F_xFRmax(:,:,i),F_yFRmax(:,:,i),...
            F_xFRmin(:,:,i),F_yFRmin(:,:,i)] = tyre_fmax(Fz_FR_d(i),20);
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),...
            F_xRLmin(:,:,i),F_yRLmin(:,:,i)] = tyre_fmax(Fz_RL_d(i),20);
        [F_xRR(:,:,i),F_yRR(:,:,i),F_xRRmax(:,:,i),F_yRRmax(:,:,i),...
            F_xRRmin(:,:,i),F_yRRmin(:,:,i)] = tyre_fmax(Fz_RR_d(i),20);
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
    Fy = Fy_FL + Fy_FR + Fy_RL + Fy_RR;
    v_x = (abs((Fy .* radius_d)/Car.Mass.Total)).^0.5;

    v_x(v_x > 200) = 200;

    % Add downforce
    for i = 1:length(v_x)
        [F_L,F_D] = Aero_Forces(v_x(i),Environment,Car);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2);
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2);
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.xCoP))/2);
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.xCoP))/2);
    end
    
    % Check for convergence of velocities
    eps = sum(v_x - v_x_check);
    disp(['Approaching vCar convergence criterion: ' num2str(min((eps_lim/eps),1)*100) ' %'])
    v_x_check = v_x;
end
    
%% Applying power limit
v_x2 = zeros(length(dist),1);
if ~isempty(BoundaryConditions.vCar_start)
    v_x2(1) = BoundaryConditions.vCar_start;
end
Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;

for i = 1:length(dist)-1
    v_x2(i) = min(v_x2(i),v_x(i));
    
    [F_L,F_D] = Aero_Forces(v_x2(i),Environment,Car);
    % Recalculate downforce
    Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2);
    Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2);
    Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.xCoP))/2);
    Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.xCoP))/2);
    Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;
       
    Fy_real = (Car.Mass.Total * v_x2(i)^2)/radius_d(i);
    
    Engine_Fx = Engine_Torque(v_x2(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Engine) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    Motor_Fx = Motor_Torque(v_x2(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Motor) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    Powertrain_Fx = Engine_Fx + Motor_Fx;
        
    eps = 2;
    Fz_check = [0 0 0 0];
    eps_lim = 1;
    while eps > eps_lim
        
        % Re-evaluate tyre potential
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),...
                F_xFLmin(:,:,i),F_yFLmin(:,:,i)] = tyre_fmax(Fz_FL_d(i),20);
        [F_xFR(:,:,i),F_yFR(:,:,i),F_xFRmax(:,:,i),F_yFRmax(:,:,i),...
            F_xFRmin(:,:,i),F_yFRmin(:,:,i)] = tyre_fmax(Fz_FR_d(i),20);
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),...
            F_xRLmin(:,:,i),F_yRLmin(:,:,i)] = tyre_fmax(Fz_RL_d(i),20);
        [F_xRR(:,:,i),F_yRR(:,:,i),F_xRRmax(:,:,i),F_yRRmax(:,:,i),...
            F_xRRmin(:,:,i),F_yRRmin(:,:,i)] = tyre_fmax(Fz_RR_d(i),20);
    
        Fy_FLreal = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FL_d(i) == 0
            Fx_FLreal = 0;
        else
            Fx_FLreal = interp1(F_xFLmax(:,2,i),F_xFLmax(:,1,i),Fy_FLreal);
        end

        Fy_FRreal = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FR_d(i) == 0
            Fx_FRreal = 0;
        else
            Fx_FRreal = interp1(F_xFRmax(:,2,i),F_xFRmax(:,1,i),Fy_FRreal);
        end

        Fy_RLreal = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RL_d(i) == 0
            Fx_RLreal = 0;
        else
            Fx_RLreal = interp1(F_xRLmax(:,2,i),F_xRLmax(:,1,i),Fy_RLreal);
        end

        Fy_RRreal = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RR_d(i) == 0
            Fx_RRreal = 0;
        else
            Fx_RRreal = interp1(F_xRRmax(:,2,i),F_xRRmax(:,1,i),Fy_RRreal);
        end
        Fx_real = [Fx_FLreal; Fx_FRreal; Fx_RLreal; Fx_RRreal];

        Fx_real = min(Powertrain_Fx,Fx_real);

        Fx_sum = sum(Fx_real);
        % Account for drag and rolling resistance
        Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
        Fx_sum = Fx_sum - F_D - Fx_rollres;    

        a_x = Fx_sum / Car.Mass.Total;

        % Carry out mass transfer checks
        [Fz_F, Fz_R] = WeightTransfer(Car,a_x);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2) + (Fz_F/2);
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2) + (Fz_F/2);
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.xCoP))/2) + (Fz_R/2);
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.xCoP))/2) + (Fz_R/2);
        eps = max(abs((Fz_check - [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)])./Fz_check));
        Fz_check = [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)];
        % Find corresponsing ride height changes
        
    end   
    
    v_x2(i+1) = (v_x2(i)^2 + (2*a_x*(dist(i+1) - dist(i))))^0.5;
end

%% Apply Braking Limit

v_x3 = zeros(length(dist),1);
if ~isempty(BoundaryConditions.vCar_end)
    v_x3(end) = BoundaryConditions.vCar_end;
else
    v_x3(end) = v_x2(end);
end

for i = length(dist):-1:2
    v_x3(i) = min(v_x3(i),v_x2(i));
    
    [F_L,F_D] = Aero_Forces(v_x3(i),Environment,Car);
    % Recalculate downforce
    Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2);
    Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2);
    Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.xCoP))/2);
    Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.xCoP))/2);
    Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;
    
    Fy_real = (Car.Mass.Total * v_x3(i)^2)/radius_d(i-1);
    
    Brake_Fx = Brake_Model(Car.Brakes) ./ ...
                    [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                    Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius]; 
    
    eps = 2;
    Fz_check = [0 0 0 0];
    eps_lim = 1;
    while eps > eps_lim
        
        % Re-evaluate tyre potential
        [F_xFL(:,:,i),F_yFL(:,:,i),F_xFLmax(:,:,i),F_yFLmax(:,:,i),...
                F_xFLmin(:,:,i),F_yFLmin(:,:,i)] = tyre_fmax(Fz_FL_d(i),20);
        [F_xFR(:,:,i),F_yFR(:,:,i),F_xFRmax(:,:,i),F_yFRmax(:,:,i),...
            F_xFRmin(:,:,i),F_yFRmin(:,:,i)] = tyre_fmax(Fz_FR_d(i),20);
        [F_xRL(:,:,i),F_yRL(:,:,i),F_xRLmax(:,:,i),F_yRLmax(:,:,i),...
            F_xRLmin(:,:,i),F_yRLmin(:,:,i)] = tyre_fmax(Fz_RL_d(i),20);
        [F_xRR(:,:,i),F_yRR(:,:,i),F_xRRmax(:,:,i),F_yRRmax(:,:,i),...
            F_xRRmin(:,:,i),F_yRRmin(:,:,i)] = tyre_fmax(Fz_RR_d(i),20);
        
        Fy_FLreal = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;

        if Fz_FL_d(i) == 0
            Fx_FLreal = 0;
        else
            Fx_FLreal = interp1(F_xFLmin(:,2,i),F_xFLmin(:,1,i),Fy_FLreal);
        end

        Fy_FRreal = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FR_d(i) == 0
            Fx_FRreal = 0;
        else
            Fx_FRreal = interp1(F_xFRmin(:,2,i),F_xFRmin(:,1,i),Fy_FRreal);
        end

        Fy_RLreal = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RL_d(i) == 0
            Fx_RLreal = 0;
        else
            Fx_RLreal = interp1(F_xRLmin(:,2,i),F_xRLmin(:,1,i),Fy_RLreal);
        end

        Fy_RRreal = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RR_d(i) == 0
            Fx_RRreal = 0;
        else
            Fx_RRreal = interp1(F_xRRmin(:,2,i),F_xRRmin(:,1,i),Fy_RRreal);
        end
        Fx_real = [Fx_FLreal; Fx_FRreal; Fx_RLreal; Fx_RRreal];

        Fx_real = max(Brake_Fx,Fx_real);

        Fx_sum = sum(Fx_real);
        % Account for drag and rolling resistance
        Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
        Fx_sum = Fx_sum - F_D - Fx_rollres;

        a_x = Fx_sum / Car.Mass.Total;

        % Carry out mass transfer checks
        [Fz_F, Fz_R] = WeightTransfer(Car,a_x);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2) + (Fz_F/2);
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.xCoP))/2) + (Fz_F/2);
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.xCoP))/2) + (Fz_R/2);
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.xCoP))/2) + (Fz_R/2);
        eps = max(abs((Fz_check - [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)])./Fz_check));
        Fz_check = [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)];
        % Find corresponsing ride height changes
        
    end
    
    v_x3(i-1) = (v_x3(i)^2 - (2*a_x*(dist(i) - dist(i-1))))^0.5;
end
v_x3(1) = min(v_x3(1),v_x2(1));

%% Output
velocity_d = v_x3;