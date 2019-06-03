function[K, SM, SI, UG] = calcK_SM(m, Cf, Cr, a, b, V)
% Function to calculate the stability factor (p170) and static margin eq(5.48) from the stability
% derivatives defined in Milliken equation(5.9)

% m = mass
% Cf = cornering stiffness front (IN RADIANS^-1)
% Cr = cornering stiffness rear (IN RADIANS^-1)
% a = distance between cg and front axle
% b = distance between cg and rear axle
% V = velocity
l = a+b;
%% Stability derivatives %%

Y_beta = Cf +Cr;
Y_r = (1/V)*(a*Cf - b*Cr);
Y_delta = -Cf;

N_beta = a*Cf - b*Cr;
N_r = (1/V)*(a^2*Cf + b^2*Cr);
N_delta = -a*Cf;

%% Calc stability factor K %%
K = (m*N_beta)/(l*(N_beta*Y_delta - Y_beta*N_delta));
%% Calc static margin %%
SM = -(1/l)*(N_beta/Y_beta);
%% Calc stability index %%
SI = (1/(l*(Cf + Cr)))*N_beta + 1/(m*l*V)*N_r;
%% Calc understeer gradient %%
UG = m*9.81*(N_beta/(Y_delta*N_beta - N_delta*Y_beta))*57.3;
end