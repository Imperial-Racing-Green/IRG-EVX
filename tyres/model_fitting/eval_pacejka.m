function [pac_fit, slip] = eval_pacejka(coef)
%PLOT_PACEJKA Summary of this function goes here
%   Detailed explanation goes here
pac_fit = zeros(500,1);
slip = linspace(-1,1,500);
for idx = 1:500
    pac_fit(idx) = pacejka4(coef,slip(idx));
end
end

