%% 8 DOF Chassis Model
% William Foster 7/11/2018

%% Car Parameters
% Masses
m_C = 200; %car sprung mass (kg)
m_WFR = 5; %front right wheel mass (kg)
m_WFL = 5; %front left wheel mass (kg)
m_WRR = 5; %rear right wheel mass (kg)
m_WRL = 5; %rear left wheel mass (kg)

% Intertias
I_Cy = 100; %chassis interia around y (kg m^2)
I_CFx = 25; %chassis front inertia around x (kg m^2)
I_CRx = 25; %chassis rear inertia around x (kg m^2)

% Geometries
a = 0.7; %distance of COG from front axle (m)
b = 0.8; %distance of COG from rear axle (m)
d_F = 0.6; %distance of COG from front left tire (m)
e_F = 0.6; %distance of COG from front right tire (m)
d_R = 0.6; %distance of COG from rear left tire (m)
e_R = 0.6; %distance of COG from rear right tire (m)

% Suspension Stifnesses
k_SFR = 10000; %suspension stiffness front right (N/m)
k_SFL = 10000; %suspension stiffness front left (N/m)
k_SRR = 10000; %suspension stiffness rear right (N/m)
k_SRL = 10000; %suspension stiffness rear left (N/m)

% Tire Stifnesses
k_TFR = 5000; %tire stiffness front right (N/m)
k_TFL = 5000; %tire stiffness front left (N/m)
k_TRR = 5000; %tire stiffness rear right (N/m)
k_TRL = 5000; %tire stiffness rear left (N/m)

% Suspension Damping Coefficients
c_SFR = 1000; %suspension damping coefficient front right (Ns/m)
c_SFL = 1000; %suspension damping coefficient front left (Ns/m)
c_SRR = 1000; %suspension damping coefficientv rear right (Ns/m)
c_SRL = 1000; %suspension damping coefficient rear left (Ns/m)

% Tire Damping Coefficients
c_TFR = 1000; %tire damping coefficient front right (Ns/m)
c_TFL = 1000; %tire damping coefficient front left (Ns/m)
c_TRR = 1000; %tire damping coefficientv rear right (Ns/m)
c_TRL = 1000; %tire damping coefficient rear left (Ns/m)

%% Model
% Initial Conditions
z_c = 0;
y_thetaC = 0;
x_thetaCF = 0;
x_thetaCR = 0;
x_WFR = 0;
x_WFL = 0;
x_WRR = 0;
x_WRL = 0;

initial = [z_c y_thetaC x_thetaCF x_thetaCR x_WFR x_WFL x_WRR x_WRL];
