function[K,SM,SI,UG,V_tangent,V_crit,V_char,K_Aero,SM_Aero,SI_Aero,UG_Aero,V_tangent_Aero,V_crit_Aero,V_char_Aero,delta_neutral] = s_stab(m,V,WBASE,X_CG,CoP,SC_L,radius_d)

%Function to determine Static Stability parameters, first without Aero
%effects, then with Aero effects. Finally determine neutral steer angle.
%All SI units.

[F_z_F,F_z_R] = F_z_calc(m,V,X_CG,CoP,0); %determine force distribution on axles front/rear 
Stiffness_Front = -corner_stiffness(F_z_F/2)*180/pi; %find tyre cornering stiffness
Stiffness_Rear = -corner_stiffness(F_z_R/2)*180/pi;

a = X_CG*WBASE;
b = WBASE - X_CG*WBASE;
[K, SM, SI, UG] = calcK_SM(m, 2*Stiffness_Front, 2*Stiffness_Rear, a, b, V);

V_tangent = sqrt(-(a + b)*9.81*b*2*Stiffness_Rear/(m*9.81*a));
if K >= 0
    V_char = sqrt(1/K);
    V_crit = NaN;
elseif K < 0
    V_char = NaN;
    V_crit = sqrt(-1/K);
end

%With Aero effects below

[F_z_F_Aero,F_z_R_Aero] = F_z_calc(m,V,X_CG,CoP,SC_L);
Stiffness_Front_Aero = -corner_stiffness(F_z_F_Aero/2)*180/pi;
Stiffness_Rear_Aero = -corner_stiffness(F_z_R_Aero/2)*180/pi;

[K_Aero, SM_Aero, SI_Aero, UG_Aero] = calcK_SM(m, 2*Stiffness_Front_Aero, 2*Stiffness_Rear_Aero, a, b, V);

V_tangent_Aero = sqrt(-(a + b)*9.81*b*2*Stiffness_Rear_Aero/(m*9.81*a));
if K_Aero >= 0
    V_char_Aero = sqrt(1/K_Aero);
    V_crit_Aero = NaN;
elseif K_Aero < 0
    V_char_Aero = NaN;
    V_crit_Aero = sqrt(-1/K_Aero);
end

%Neutral Steer Angle
delta_neutral = ((a+b)./radius_d)*180/pi; %compare to track data
end