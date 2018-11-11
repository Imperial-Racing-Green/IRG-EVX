%% 8 DOF Chassis Model
% William Foster 7/11/2018

clear all
close all
clc

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
a = 0.8; %distance of COG from front axle (m)
b = 0.7; %distance of COG from rear axle (m)
d_F = 0.6; %distance of COG from front left tire (m)
e_F = 0.6; %distance of COG from front right tire (m)
d_R = 0.6; %distance of COG from rear left tire (m)
e_R = 0.6; %distance of COG from rear right tire (m)

% Suspension Stifnesses
k_SFR = 200000; %suspension stiffness front right (N/m)
k_SFL = 200000; %suspension stiffness front left (N/m)
k_SRR = 200000; %suspension stiffness rear right (N/m)
k_SRL = 200000; %suspension stiffness rear left (N/m)

% Tire Stifnesses
k_TFR = 500000; %tire stiffness front right (N/m)
k_TFL = 500000; %tire stiffness front left (N/m)
k_TRR = 500000; %tire stiffness rear right (N/m)
k_TRL = 500000; %tire stiffness rear left (N/m)

% Suspension Damping Coefficients
c_SFR = 500; %suspension damping coefficient front right (Ns/m)
c_SFL = 500; %suspension damping coefficient front left (Ns/m)
c_SRR = 500; %suspension damping coefficientv rear right (Ns/m)
c_SRL = 500; %suspension damping coefficient rear left (Ns/m)

% Tire Damping Coefficients
c_TFR = 800; %tire damping coefficient front right (Ns/m)
c_TFL = 800; %tire damping coefficient front left (Ns/m)
c_TRR = 800; %tire damping coefficientv rear right (Ns/m)
c_TRL = 800; %tire damping coefficient rear left (Ns/m)

% Other Stiffnesses
k_C = 20000;

% Other Damping Coefficients
c_C = 100;

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
zdot_c = 0;
ydot_thetaC = 0;
xdot_thetaCF = 0;
xdot_thetaCR = 0;
xdot_WFR = 0;
xdot_WFL = 0;
xdot_WRR = 0;
xdot_WRL = 0;

initial = [z_c, zdot_c,...
    y_thetaC, ydot_thetaC,...
    x_thetaCF, xdot_thetaCF,...
    x_thetaCR, xdot_thetaCR,...
    x_WFR, xdot_WFR,...
    x_WFL, xdot_WFL,...
    x_WRR, xdot_WRR,...
    x_WRL, xdot_WRL];

% initial = [z_C

time = [0 5];

% Forces & Moments
g = 9.81;
F_z = -m_C * g;
M_y = 1500;
M_xF = 700;
M_xR = -700;

% Floor Displacements & Velocities
y_FR = 0;
y_FL = 0;
y_RR = 0;
y_RL = 0;
ydot_FR = 0;
ydot_FL = 0;
ydot_RR = 0;
ydot_RL = 0;

% Run Simulation
[t,z] = ode45(@(t,z) Chassis8(t,z,m_C,m_WFR,m_WFL,m_WRR,m_WRL,...
    I_Cy,I_CFx,I_CRx,a,b,d_F,e_F,d_R,e_R,k_SFR,k_SFL,k_SRR,k_SRL,...
    k_TFR,k_TFL,k_TRR,k_TRL,c_SFR,c_SFL,c_SRR,c_SRL,c_TFR,c_TFL,...
    c_TRR,c_TRL,k_C,c_C,F_z,M_y,M_xF,M_xR,y_FR,y_FL,y_RR,y_RL,...
    ydot_FR,ydot_FL,ydot_RR,ydot_RL),time,initial);

%% Plot Results
z_c = z(:,1);
y_thetaC = z(:,3);
x_thetaCF = z(:,5);
x_thetaCR = z(:,7);
x_WFR = z(:,11);
x_WFL = z(:,13);
x_WRR = z(:,9);
x_WRL = z(:,15);
zdot_c = z(:,2);
ydot_thetaC = z(:,4);
xdot_thetaCF = z(:,6);
xdot_thetaCR = z(:,8);
xdot_WFR = z(:,12);
xdot_WFL = z(:,14);
xdot_WRR = z(:,10);
xdot_WRL = z(:,16);

subplot(4,2,1)
plot(t ,z_c)
title('Chassis Body Position vs Time');
grid on

subplot(4,2,2)
plot(t ,zdot_c)
title('Chassis Body Velocity vs Time');
grid on

subplot(4,2,3)
plot(t ,y_thetaC)
title('Pitch Position vs Time');
grid on

subplot(4,2,4)
plot(t ,ydot_thetaC)
title('Pitch Velocity vs Time');
grid on

subplot(4,2,5)
plot(t ,x_thetaCF)
title('Front Roll Position vs Time');
grid on

subplot(4,2,6)
plot(t ,xdot_thetaCF)
title('Front Roll Velocity vs Time');
grid on

subplot(4,2,7)
plot(t ,x_thetaCR)
title('Rear Roll Position vs Time');
grid on

subplot(4,2,8)
plot(t ,xdot_thetaCR)
title('Rear Roll Velocity vs Time');
grid on

figure

subplot(4,2,1)
plot(t ,x_WFR)
title('Front Right Wheel Position vs Time');
grid on

subplot(4,2,2)
plot(t ,xdot_WFR)
title('Front Right Wheel Velocity vs Time');
grid on

subplot(4,2,3)
plot(t ,x_WFL)
title('Front Left Wheel Position vs Time');
grid on

subplot(4,2,4)
plot(t ,xdot_WFL)
title('Front Left Wheel Velocity vs Time');
grid on

subplot(4,2,5)
plot(t ,x_WRR)
title('Rear Right Wheel Position vs Time');
grid on

subplot(4,2,6)
plot(t ,xdot_WRR)
title('Rear Right Wheel Velocity vs Time');
grid on

subplot(4,2,7)
plot(t ,x_WRL)
title('Rear Left Wheel Position vs Time');
grid on

subplot(4,2,8)
plot(t ,xdot_WRL)
title('Rear Left Wheel Velocity vs Time');
grid on

%% Visualise Chassis Ride
h_ride = 0.05;
h_FR = h_ride + z_c - a * y_thetaC - e_F * x_thetaCF;
h_FL = h_ride + z_c - a * y_thetaC + d_F * x_thetaCF;
h_RR = h_ride + z_c + b * y_thetaC - e_R * x_thetaCR;
h_RL = h_ride + z_c + b * y_thetaC + d_R * x_thetaCR;

time = length(h_FR);

figure
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

for i = 1:time
    X = [a a -b -b];
    Y = [-e_F d_F d_R -e_R];
    Z = [h_FR(i) h_FL(i) h_RL(i) h_RR(i)];
    Z = 1000 * Z;
    C = [1 1 1 1];
    fill3(X,Y,Z,C)
    
    hold on
    
    XFR = [a a];
    YFR = [-e_F -e_F];
    ZFR = [y_FR h_FR(i)];
    plot3(XFR,YFR,ZFR*1000);
    
    XFL = [a a];
    YFL = [d_F d_F];
    ZFL = [y_FL h_FL(i)];
    plot3(XFL,YFL,ZFL*1000);
    
    XRR = [-b -b];
    YRR = [-e_F -e_F];
    ZRR = [y_RR h_RR(i)];
    plot3(XRR,YRR,ZRR*1000);
    
    XRL = [-b -b];
    YRL = [d_F d_F];
    ZRL = [y_RL h_RL(i)];
    plot3(XRL,YRL,ZRL*1000);
    
    scatter3(a,-e_F,(x_WFR(i) + (h_ride/2))*1000,100);
    scatter3(a,d_F,(x_WFL(i) + (h_ride/2))*1000,100);
    scatter3(-b,d_R,(x_WRR(i) + (h_ride/2))*1000,100);
    scatter3(-b,-e_R,(x_WRL(i) + (h_ride/2))*1000,100);
    
    xlim([-1 1]);
    ylim([-1 1]);
    zlim([0 h_ride * 2000]);
    xlabel('length (m)');
    ylabel('width (m)');
    zlabel('ride height (mm)');
    title('Chassis 8DOF Simulation');
    grid on
    pause(0.001)
    
    disp(num2str(i));
    
    hold off
end

