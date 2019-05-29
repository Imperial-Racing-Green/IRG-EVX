clear
clc

x = zeros(601,1);
y = [0:(800/600):800]';

dist = y;  

radius_d = 1e6*ones(601,1);
curve_d = 1./radius_d;
theta_d = x;

% save('DragRace_Track','x','y','radius_d','curve_d','theta_d','dist')

% theta_d = atan2(diff(y),diff(x));

% for k = 2:1:length(theta_d)
%     dChange = theta_d(k) - theta_d(k-1);
%     if (abs(dChange) > 0.9*pi)
%         r = round(dChange/pi);
%         theta_d(k) = theta_d(k) - r*pi;
%     end
% end

% curve_d = diff(theta_d)./diff(dist);

% windowSize = round(length(x) / 500);
% b = (1/windowSize)*ones(1,windowSize);
% a = 1;
% theta_d = filter(b,a,theta_d);
% windowSize = round(length(x) / 50);
% b = (1/windowSize)*ones(1,windowSize);
% curve_d = filter(b,a,curve_d);
    
% radius_d = 1./curve_d;