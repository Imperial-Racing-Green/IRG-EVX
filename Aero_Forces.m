function [F_L,F_D] = Aero_Forces(v_x,Environment)

A = 1.5*1.5; % Frontal area (dependant on ride height) RANDOM - NEEDS UPDATING
C_L = 1; % Coefficient of lift RANDOM - NEEDS UPDATING
C_D = 0.5; % Coefficient of drag RANDOM - NEEDS UPDATING

F_L = 0.5*Environment.Density*(v_x^2)*A*C_L;
F_D = 0.5*Environment.Density*(v_x^2)*A*C_D;

