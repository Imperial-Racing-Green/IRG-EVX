function [curve] = Curvature(z)

theta = Theta(z);

curve = diff(theta);

oldn = linspace(1,length(curve),length(curve))';
newn = linspace(1,length(curve),length(z))';

curve = interp1(oldn,curve,newn,'spline');