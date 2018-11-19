function initial = Chassis8_Initial()
% Initial Conditions
z_c = -0.25;
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