function [mu_lat,F_max] = tyre_mu_long(tyre_model,P,IA,FZ)
%TYRE_MAX_F Summary of this function goes here
%   Detailed explanation goes here
coef = tyre_model.get_coefficients_long(P,IA,FZ);
fun = @(x) -abs(tyre_model.pacejka4(coef,x));
[~,F_max] = fminbnd(fun,-10,10);
mu_lat = -F_max./FZ;
end