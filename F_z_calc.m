function[F_z_F,F_z_R] = F_z_calc(m,V,CoG,CoP,C_L,A_frontal)
%mass, m, is an input
%CoG position as a % of wheelbase is an input
%Wheelbase an input, but should not change
%V is an input
%C_L is an input (must be strictly negative!)
%A_frontal is an input (will change with Aero dev)
%CoP is an input (as a % of wheelbase)
if C_L > 0
   error('Error - need downforce, not lift')
end

W = m*9.81;
W_R = W*CoG;
W_F = W - W_R;

rho = 1.225;
L = -C_L*0.5*rho*V^2*A_frontal;
L_R = L*CoP;
L_F = L - L_R;

F_z_F = W_F + L_F;
F_z_R = W_R + L_R;
end