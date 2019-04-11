function velocity_d = Vel_update(Fz_log,dist,dist_log,radius_d,mass)


%% Finding max velocity at each curvature

Fz_FL_t = Fz_log.Data(:,1);
Fz_FR_t = Fz_log.Data(:,2);
Fz_RL_t = Fz_log.Data(:,3);
Fz_RR_t = Fz_log.Data(:,4);

time_d = interp1(dist_log.Data .* (max(dist)/max(dist_log.Data)),dist_log.Time,dist);

Fz_FL_d = interp1(Fz_log.Time,Fz_FL_t,time_d);
Fz_FR_d = interp1(Fz_log.Time,Fz_FR_t,time_d);
Fz_RL_d = interp1(Fz_log.Time,Fz_RL_t,time_d);
Fz_RR_d = interp1(Fz_log.Time,Fz_RR_t,time_d);

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
%     Fy(i) = Fy_FL(i) + Fy_FR(i) + Fy_RL(i) + Fy_RR(i);
%     v_x(i) = (abs((Fy(i) * radius_d(i))/mass))^0.5;
end
Fy = Fy_FL + Fy_FR + Fy_RL + Fy_RR;
v_x = (abs((Fy .* radius_d)/mass)).^0.5;

v_x(v_x > 200) = 200;

%% Applying power limit

v_x2 = zeros(length(dist),1);
% v_x2(1) = 0;
Fz_sum = Fz_FL_d + Fz_FR_d + Fz_RL_d + Fz_RR_d;

for i = 1:length(dist)-2
    v_x2(i) = min(v_x2(i),v_x(i));
    Fy_real = (mass * v_x2(i)^2)/radius_d(i);
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
    
    Motor_Fx = Motor_Torque(v_x2(i),0.175,3,240,80000) ./ 0.175;
    Fx_real = [Fx_FLreal;Fx_FRreal;Fx_RLreal;Fx_RRreal];
    
    Fx_real = min(Motor_Fx,Fx_real);
    
    Fx_sum = sum(Fx_real);
    
    [F_L,F_D] = Aero_Forces(v_x2(i));
    Fx_sum =  Fx_sum - F_D;
    
    a_x = Fx_sum / mass;
    
    v_x2(i+1) = (v_x2(i)^2 + (2*a_x*(dist(i+1) - dist(i))))^0.5;
end

%% Apply Braking Limit

v_x3 = zeros(length(dist),1);
v_x3(end) = v_x2(end);

for i = length(dist)-1:-1:2
    v_x3(i) = min(v_x3(i),v_x2(i));
    Fy_real = (mass * v_x2(i)^2)/radius_d(i-1);
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
    
    Fx_real = [Fx_FLreal;Fx_FRreal;Fx_RLreal;Fx_RRreal];
    
    Fx_sum = sum(Fx_real);
    
    [F_L,F_D] = Aero_Forces(v_x2(i));
    Fx_sum =  Fx_sum - F_D;
    
    a_x = Fx_sum / mass;
    
    v_x3(i-1) = (v_x3(i)^2 - (2*a_x*(dist(i) - dist(i-1))))^0.5;
end

%% Output

velocity_d = v_x3;