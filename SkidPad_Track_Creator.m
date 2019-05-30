clear
clc

R = 11.5;
centre = [-R 0];
th = 0:pi/300:2*pi;
x = [R * cos(th) + centre(1)]';
y = [R * sin(th) + centre(2)]';
plot(x,y);
axis equal

% R = 10.5;
% x1 = 0:-(2*R/150):(-2*R);
% y1 = sqrt(R^(2) - ((x1 + R).^(2)));
% x2 = (-2*R):(2*R/150):0;
% y2 = -sqrt(R^(2) - ((x2 + R).^(2)));
% % x3 = 0:(2*R/150):(2*R);
% % y3 = sqrt(R^(2) - ((x3 - R).^(2)));
% % x4 = (2*R):-(2*R/150):0;
% % y4 = -sqrt(R^(2) - ((x4 - R).^(2)));

% figure()
% plot(x1,y1)
% hold on
% plot(x2,y2)
% % plot(x3,y3)
% % plot(x4,y4)
% axis equal

% x = [x1 x2 x3 x4]';
% y = [y1 y2 y3 y4]';
% x = [x1 x2]';
% y = [y1 y2]';
Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;
dist = cumsum(Spacing);  
dist = [ 0 ; dist ; 2*pi*R];
radius_d = [R*(ones(1,length(x)))]';
curve_d = 1./radius_d;
theta_d = [0 ; cumsum(diff(dist).*curve_d)];

% save('SkidPad_Track_new','x','y','radius_d','curve_d','theta_d','dist')

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