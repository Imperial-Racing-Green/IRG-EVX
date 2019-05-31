function[A] = d_stab(m,V,WBASE,X_CG,CoP,C_L,A_frontal)

% Lateral Vehicle Dynamics 
% define states and input in symbolic toolbox
syms y y_dot psii psii_dot delta
% syms m Cf Cr a b Vx Iz
% defining the parameters

[Fzf,Fzr] = F_z_calc(m, V, X_CG, CoP, C_L, A_frontal); %needs to change based on Cl
Cf = -2*corner_stiffness(Fzf/2)*180/pi; %- cornering stiffness front in N/rad
Cr = -2*corner_stiffness(Fzr/2)*180/pi; %- cornering stiffness rear in N/rad

a_wb = X_CG*WBASE; %m dist cg to front wheels
b_wb = WBASE - a_wb; %m dist cg to rear wheels
Iz = 106; %kgm^2 moment of inertia - estimate (last year)

f1 = y_dot;
f2 = (1/m)*(2*Cf*(delta - (y_dot+a_wb*psii_dot)/(V)) + 2*Cr*(-(y_dot-b_wb*psii_dot)/(V))-m*psii_dot*V);
f3 = psii_dot;
f4 = (1/Iz)*(2*a_wb*Cf*(delta - (y_dot+a_wb*psii_dot)/(V))-2*b_wb*Cr*(-(y_dot-b_wb*psii_dot)/(V)));

f= [f1 f2 f3 f4];
v = [y y_dot psii psii_dot];
A = jacobian(f,v);
B = jacobian(f,delta);
C = eye(4);
D = 0;
A = subs(A);
B = subs(B);
A = double(A);
B = double(B);
sys = ss(A,B,C,D);
A = eig(sys);
end
