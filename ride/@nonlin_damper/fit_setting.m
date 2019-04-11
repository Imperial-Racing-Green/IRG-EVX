function [coef_compression, coef_rebound] = fit_setting(obj,C_valve, R_valve, setting_high, setting_low)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
setting_low = num2str(setting_low);
setting_high = num2str(setting_high);
datafile = [setting_low '-' setting_high ' ' setting_low '-' setting_high];
data = load(fullfile(pwd,'ride\Damper Data', obj.damper_spec,...
    ['R' num2str(R_valve) ' ' 'C' num2str(C_valve)],[datafile '.csv']));
keyboard
compression = data(data(:,1)>0,:);
rebound = data(data(:,1)<0,:);
coef_compression = polyfit(compression(:,2),compression(:,1),2);
% coef_compression = coef_compression(
coef_rebound = polyfit(rebound(:,2),-rebound(:,1),5);
figure
scatter(compression(:,2),compression(:,1))
hold on
plot(compression(:,2),polyval(coef_compression,compression(:,2)))
end

