function [F_L,F_D] = Aero_Forces(v_x,Environment,Car)

F_L = 0.5*Environment.Density*(v_x^2)*Car.Dimension.FrontalArea*Car.AeroPerformance.C_L;
F_D = 0.5*Environment.Density*(v_x^2)*Car.Dimension.FrontalArea*Car.AeroPerformance.C_D;

