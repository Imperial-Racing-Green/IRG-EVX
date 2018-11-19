function initial = Initial()
% Initial Conditions
z_c = -0.5;
y_thetaC = -0.5;
x_thetaCF = -0.5;
x_thetaCR = -0.5;
x_WFR = -0.5;
x_WFL = -0.5;
x_WRR = -0.5;
x_WRL = -0.5;
zdot_c = -0.5;
ydot_thetaC = -0.5;
xdot_thetaCF = -0.5;
xdot_thetaCR = -0.5;
xdot_WFR = -0.5;
xdot_WFL = -0.5;
xdot_WRR = -0.5;
xdot_WRL = -0.5;

initial = [z_c, zdot_c,...
    y_thetaC, ydot_thetaC,...
    x_thetaCF, xdot_thetaCF,...
    x_thetaCR, xdot_thetaCR,...
    x_WFR, xdot_WFR,...
    x_WFL, xdot_WFL,...
    x_WRR, xdot_WRR,...
    x_WRL, xdot_WRL];