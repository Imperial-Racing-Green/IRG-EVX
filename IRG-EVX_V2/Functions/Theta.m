function [theta] = Theta(z)

x = z(:,1);
y = z(:,2);

theta = atan2(diff(y),diff(x));
for i = 2:length(theta)
    if theta(i) > theta(i-1) + 0.75 * 2 * pi
        theta(i) = theta(i) - 2 * pi;
    elseif theta(i) < theta(i-1) - 0.75 * 2 * pi
        theta(i) = theta(i) + 2 * pi;
    end
end

oldn = linspace(0,length(theta)-0.5,length(theta))';
newn = linspace(0,length(theta),length(x))';

theta = interp1(oldn,theta,newn,'spline');