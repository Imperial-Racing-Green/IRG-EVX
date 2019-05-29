function [Fx_eff,Fy_eff] = estimate_effective_forces(tyre_model,P,IA,Fz_ts)
%ESTIMATE_LATERAL_FORCE Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(Fz_ts.Data)
    Fx_max(i) = fminsearch(@(x)-pacejka4(tyre_model.get_coefficients_long(P,IA,Fz_ts.Data(i)),x),0);
    Fy_max(i) = fminsearch(@(x)-pacejka4(tyre_model.get_coefficients_lat(P,IA,Fz_ts.Data(i)),x),0);
end

keyboard