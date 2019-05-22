function [Fz_F Fz_R] = WeightTransfer(Car,a_x)

% Clockwise moment about CoG
M = Car.Mass.Total*a_x*Car.Dimension.zCoG;
dF = (M*Car.Dimension.lWheelbase)/2;    % Weight transfer at each wheel (+ve upwards)
Fz_F = dF;
Fz_R = - dF;



