function [F_L,F_D] = Aero_Forces(v_x,Environment,Car)

% Incorporate an aeromap where dynamic front and rear ride heights are
% inputted into this function along with roll pitch and yaw angles
% Using thesevalues, the values of SC_L, SC_D and xCoP location can be
% looked up
% SC_L and SC_D can be looked up while xCoP can be outputted from the
% function before being applied - would be useful to save that as a
% variable and monitor movement of CoP throughout lap
F_L = 0.5*Environment.Density*(v_x^2)*Car.AeroPerformance.SC_L;
F_D = 0.5*Environment.Density*(v_x^2)*Car.AeroPerformance.SC_D;

