function velocity_d = Vel_update(Fz_log,dist,dist_log,radius_d,Environment,Car,BoundaryConditions)

%% Finding max velocity at each curvature
radius_d(radius_d == 0) = 1e-5;

Fz_FL_t = Fz_log.Data(:,1);
Fz_FR_t = Fz_log.Data(:,2);
Fz_RL_t = Fz_log.Data(:,3);
Fz_RR_t = Fz_log.Data(:,4);

% time_d = interp1(dist_log.Data .* (max(dist)/max(dist_log.Data)),dist_log.Time,dist);
time_d = dist_log.Time;
delta_steer=atand(Car.Dimension.lWheelbase./radius_d);

Fz_FL_d = interp1(Fz_log.Time,Fz_FL_t,time_d);
Fz_FR_d = interp1(Fz_log.Time,Fz_FR_t,time_d);
Fz_RL_d = interp1(Fz_log.Time,Fz_RL_t,time_d);
Fz_RR_d = interp1(Fz_log.Time,Fz_RR_t,time_d);

% Define static forces before downforce is added
Fz_FL_static = Fz_FL_d;
Fz_FR_static = Fz_FR_d;
Fz_RL_static = Fz_RL_d;
Fz_RR_static = Fz_RR_d;


eps = 2001;
eps_lim = 2000;
v_x_check = zeros(1,length(dist));

while eps >= eps_lim

    for i = 1:length(dist)
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
    Fy = Fy_FL + Fy_FR + Fy_RL + Fy_RR;
    v_x = (abs((Fy .* radius_d)/Car.Mass.Total)).^0.5;

    v_x(v_x > 200) = 200;

    % Add downforce
    for i = 1:length(v_x)
        [F_L,~] = Aero_Forces(v_x(i),Environment,Car);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    end
    
    % Check for convergence of velocities
    eps = sum(v_x - v_x_check);
    disp(['Approaching vCar convergence criterion: ' num2str(min((eps_lim/eps),1)*100) ' %'])
    v_x_check = v_x;
    
end
   
%% Applying power limit
v_x2 = zeros(length(dist),1);


v_x = zeros(length(dist),1)+200;

if ~isempty(BoundaryConditions.vCar_start)
    v_x2(1) = BoundaryConditions.vCar_start;
end
Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;

for i = 1:length(dist)-1
    v_x2(i) = min(v_x2(i),v_x(i));
    
    [F_L,F_D] = Aero_Forces(v_x2(i),Environment,Car);
    % Recalculate downforce
    Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;
    
    Fz_front = [Fz_FL_d Fz_FR_d];
    Fz_rear  = [Fz_RL_d Fz_RR_d];
    
    Fy_real = (Car.Mass.Total * v_x2(i)^2)/radius_d(i);
    
%     Engine_nu=0.46;
%     Motor_nu=0.87;
     
    Engine_Fx = Engine_Torque(v_x2(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Engine) ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    %Engine_Fx=Engine_nu*Engine_Fx;                
    Torque_from_Motor = Motor_Torque(v_x2(i),Car.Dimension.WheelRL.Radius,Car.Powertrain.Motor);
    Motor_Fx= Torque_from_Motor ./ ...
                        [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                        Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius];
    %Motor_Fx=Motor_nu*Motor_Fx;           
    Powertrain_Fx = Engine_Fx + Motor_Fx;
        
    eps = 2;
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
    
        Fy_FLreal = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FL_d(i) == 0
            Fx_FLreal = 0;
            SA.FL(i) = 0;
            SL.FL(i) = 0;
        else
            Fx_FLreal = interp1(F_xFLmax(:,2,i),F_xFLmax(:,1,i),Fy_FLreal,'spline');
            SA.FL(i) = interp1(F_xFLmax(:,2,i),SA_FL_xmax(:,i),Fy_FLreal,'spline');
            SL.FL(i) = interp1(F_xFLmax(:,2,i),SL_FL_xmax(:,i),Fy_FLreal,'spline');
        end

        Fy_FRreal = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FR_d(i) == 0
            Fx_FRreal = 0;
            SA.FR(i) = 0;
            SL.FR(i) = 0;
        else
            Fx_FRreal = interp1(F_xFRmax(:,2,i),F_xFRmax(:,1,i),Fy_FRreal,'spline');
            SA.FR(i) = interp1(F_xFRmax(:,2,i),SA_FR_xmax(:,i),Fy_FRreal,'spline');
            SL.FR(i) = interp1(F_xFRmax(:,2,i),SL_FR_xmax(:,i),Fy_FRreal,'spline');
        end

        Fy_RLreal = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RL_d(i) == 0
            Fx_RLreal = 0;
            SA.RL(i) = 0;
            SL.RL(i) = 0;
        else
            Fx_RLreal = interp1(F_xRLmax(:,2,i),F_xRLmax(:,1,i),Fy_RLreal,'spline');
            SA.RL(i) = interp1(F_xRLmax(:,2,i),SA_RL_xmax(:,i),Fy_RLreal,'spline');
            SL.RL(i) = interp1(F_xRLmax(:,2,i),SL_RL_xmax(:,i),Fy_RLreal,'spline');
        end

        Fy_RRreal = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RR_d(i) == 0
            Fx_RRreal = 0;
            SA.RR(i) = 0;
            SL.RR(i) = 0;
        else
            Fx_RRreal = interp1(F_xRRmax(:,2,i),F_xRRmax(:,1,i),Fy_RRreal,'spline');
            SA.RR(i) = interp1(F_xRLmax(:,2,i),SA_RL_xmax(:,i),Fy_RLreal,'spline');
            SL.RR(i) = interp1(F_xRLmax(:,2,i),SL_RL_xmax(:,i),Fy_RLreal,'spline');
        end
       
        Fx_traction = [Fx_FLreal; Fx_FRreal; Fx_RLreal; Fx_RRreal];

        Fx_real = min(Powertrain_Fx,Fx_traction);
        
        
        Fx_sum = sum(Fx_real);
        
        % Account for drag and rolling resistance
        Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
        Fx_sum = Fx_sum - F_D - Fx_rollres;    

        a_x = Fx_sum / Car.Mass.Total;
        a_y = (v_x2(i)^2) / radius_d(i);
        
        % Carry out mass transfer checks
        [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FL;
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FR;
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RL;
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RR;
        eps = max(abs((Fz_check - [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)])./Fz_check));
        Fz_check = [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)];
        % Find corresponsing ride height changes
    end   
%     
%         Fy_tyres=[Fy_FLreal; Fy_FRreal; Fy_RLreal; Fy_RLreal];
%         
%         Delta_T(i)=(Torque_Vectoring(Car,Fy_tyres,delta_steer(i),v_x2(i),Fz_front(i),Fz_rear(i))/1000);
%         
%         
%         if delta_steer(i)>0
%              %Fx_real(1)=(Fx_real(1)-(Delta_T(i)*0.5))/Car.Dimension.WheelFL.Radius;
%               Fx_real(2)=(Fx_real(2)+(Delta_T(i)*0.5))/Car.Dimension.WheelFR.Radius;
%         else 
%               Fx_real(1)=(Fx_real(1)+(Delta_T(i)*0.5))/Car.Dimension.WheelFL.Radius;
%              %Fx_real(2)=(Fx_real(2)-(Delta_T(i)*0.5))/Car.Dimension.WheelFR.Radius;
%         end 
%         
%         Fx_sum = sum(Fx_real);
%         
%         % Account for drag and rolling resistance
%         Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
%         Fx_sum = Fx_sum - F_D - Fx_rollres;    
% 
%         a_x = Fx_sum / Car.Mass.Total;

    
       v_x2(i+1) = (v_x2(i)^2 + (2*a_x*(dist(i+1) - dist(i))))^0.5;
       
     b(i)=ceil(mod(i+1,length(dist)/10));  
     
     if b(i)==0
      disp(['Power limit: ' num2str((i+1)/(length(dist)/100)) ' % complete']);
     end 
end 
%% Apply Braking Limit

v_x3 = zeros(length(dist),1);
if ~isempty(BoundaryConditions.vCar_end)
    v_x3(end) = BoundaryConditions.vCar_end;
else
    v_x3(end) = v_x2(end);
end

j=0;

for i = length(dist):-1:2
    j=j+1;
    
    v_x3(i) = min(v_x3(i),v_x2(i));
    
    [F_L,F_D] = Aero_Forces(v_x3(i),Environment,Car);
    % Recalculate downforce
    Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2);
    Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2);
    Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;
    
    Fy_real = (Car.Mass.Total * v_x3(i)^2)/radius_d(i-1);
    
    Brake_Fx = Brake_Model(Car.Brakes) ./ ...
                    [Car.Dimension.WheelFL.Radius; Car.Dimension.WheelFR.Radius; ...
                    Car.Dimension.WheelRL.Radius; Car.Dimension.WheelRR.Radius]; 
    
    eps = 2;
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
        
        Fy_FLreal = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FL_d(i) == 0
            Fx_FLreal = 0;
            SA.FL(i) = 0;
            SL.FL(i) = 0;
        else
            Fx_FLreal = interp1(F_xFLmin(:,2,i),F_xFLmin(:,1,i),Fy_FLreal,'spline');
            SA.FL(i) = interp1(F_xFLmin(:,2,i),SA_FL_xmin(:,i),Fy_FLreal,'spline');
            SL.FL(i) = interp1(F_xFLmin(:,2,i),SL_FL_xmin(:,i),Fy_FLreal,'spline');
        end

        Fy_FRreal = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_FR_d(i) == 0
            Fx_FRreal = 0;
            SA.FR(i) = 0;
            SL.FR(i) = 0;
        else
            Fx_FRreal = interp1(F_xFRmin(:,2,i),F_xFRmin(:,1,i),Fy_FRreal,'spline');
            SA.FR(i) = interp1(F_xFRmin(:,2,i),SA_FR_xmin(:,i),Fy_FRreal,'spline');
            SL.FR(i) = interp1(F_xFRmin(:,2,i),SL_FR_xmin(:,i),Fy_FRreal,'spline');
        end

        Fy_RLreal = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RL_d(i) == 0
            Fx_RLreal = 0;
            SA.RL(i) = 0;
            SL.RL(i) = 0;
        else
            Fx_RLreal = interp1(F_xRLmin(:,2,i),F_xRLmin(:,1,i),Fy_RLreal,'spline');
            SA.RL(i) = interp1(F_xRLmin(:,2,i),SA_RL_xmin(:,i),Fy_RLreal,'spline');
            SL.RL(i) = interp1(F_xRLmin(:,2,i),SL_RL_xmin(:,i),Fy_RLreal,'spline');
        end

        Fy_RRreal = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
        if Fz_RR_d(i) == 0
            Fx_RRreal = 0;
            SA.RR(i) = 0;
            SL.RR(i) = 0;
        else
            Fx_RRreal = interp1(F_xRRmin(:,2,i),F_xRRmin(:,1,i),Fy_RRreal,'spline');
            SA.RR(i) = interp1(F_xRLmin(:,2,i),SA_RL_xmin(:,i),Fy_RLreal,'spline');
            SL.RR(i) = interp1(F_xRLmin(:,2,i),SL_RL_xmin(:,i),Fy_RLreal,'spline');
        end
        
%         Fy_FLreal = (Fz_FL_d(i) / Fz_sum(i)) * Fy_real;
%         if Fz_FL_d(i) == 0
%             Fx_FLreal = 0;
%         else
%             Fx_FLreal = interp1(F_xFLmin(:,2,i),F_xFLmin(:,1,i),Fy_FLreal);
%         end
% 
%         Fy_FRreal = (Fz_FR_d(i) / Fz_sum(i)) * Fy_real;
%         if Fz_FR_d(i) == 0
%             Fx_FRreal = 0;
%         else
%             Fx_FRreal = interp1(F_xFRmin(:,2,i),F_xFRmin(:,1,i),Fy_FRreal);
%         end
% 
%         Fy_RLreal = (Fz_RL_d(i) / Fz_sum(i)) * Fy_real;
%         if Fz_RL_d(i) == 0
%             Fx_RLreal = 0;
%         else
%             Fx_RLreal = interp1(F_xRLmin(:,2,i),F_xRLmin(:,1,i),Fy_RLreal);
%         end
% 
%         Fy_RRreal = (Fz_RR_d(i) / Fz_sum(i)) * Fy_real;
%         if Fz_RR_d(i) == 0
%             Fx_RRreal = 0;
%         else
%             Fx_RRreal = interp1(F_xRRmin(:,2,i),F_xRRmin(:,1,i),Fy_RRreal);
%         end
        Fx_traction = [Fx_FLreal; Fx_FRreal; Fx_RLreal; Fx_RRreal];
        
%         % Account for drag and rolling resistance
%         Fx_rollres = - Car.Tyres.Coefficients.RollingResistance*[Fz_FL_d(i); Fz_FR_d(i); Fz_RL_d(i); Fz_RR_d(i)]; 
%         Fx_decel = Brake_Fx - ((0.25*F_D)*ones(length(Brake_Fx),1)) - Fx_rollres;
%         Fx_real = max(Fx_decel,Fx_traction);
        Fx_real = max(Brake_Fx,Fx_traction);

        Fx_sum = sum(Fx_real);
        % Account for drag and rolling resistance
        Fx_rollres = -Fz_sum(i)*Car.Tyres.Coefficients.RollingResistance; % Assume all wheels (including driven wheels) contribute
        Fx_sum = Fx_sum - F_D - Fx_rollres;

        a_x = Fx_sum / Car.Mass.Total;
        a_y = (v_x3(i)^2) / radius_d(i);

        % Carry out mass transfer checks
        [Fz_FL, Fz_FR, Fz_RL, Fz_RR] = WeightTransfer(Car,a_x,a_y);
        Fz_FL_d(i) = Fz_FL_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FL;
        Fz_FR_d(i) = Fz_FR_static(i) - ((F_L * (1 - Car.Balance.CoP(1)))/2) + Fz_FR;
        Fz_RL_d(i) = Fz_RL_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RL;
        Fz_RR_d(i) = Fz_RR_static(i) - ((F_L * (Car.Balance.CoP(1)))/2) + Fz_RR;
        eps = max(abs((Fz_check - [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)])./Fz_check));
        Fz_check = [Fz_FL_d(i) Fz_FR_d(i) Fz_RL_d(i) Fz_RR_d(i)];
        % Find corresponsing ride height changes
        
    end
    
    v_x3(i-1) = (v_x3(i)^2 - (2*a_x*(dist(i) - dist(i-1))))^0.5;
    
    b=ceil(mod(j+1,length(dist)/10));  
     
     if b==0
      disp(['Brake limit: ' num2str((j+1)/(length(dist)/100)) ' % complete']);
     end 
     
end
v_x3(1) = min(v_x3(1),v_x2(1));

%% Output
velocity_d = v_x3;