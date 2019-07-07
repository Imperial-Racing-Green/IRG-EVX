clear
clc

R = 9.13;
centre = [-R 0];
th = 0:pi/300:2*pi;
x = [R * cos(th) + centre(1)]';
y = [R * sin(th) + centre(2)]';
plot(x,y);
axis equal

Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;
dist = cumsum(Spacing);  
distanceTrack = [ 0 ; dist ; 2*pi*R];
radius_d = [R*(ones(1,length(x)))]';
curve_d = 1./radius_d;
theta_d = [0 ; cumsum(diff(distanceTrack).*curve_d)];

% save('SkidPad_Track.mat','x','y','radius_d','curve_d','theta_d','distanceTrack')

