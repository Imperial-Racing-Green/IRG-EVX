clear
clc

NPoints = 100;
R = 9.13;

centre = [-R 0];
th = linspace(0,2*pi,NPoints);
x = [R * cos(th) + centre(1)]';
y = [R * sin(th) + centre(2)]';
plot(x,y);
axis equal

distanceTrack = linspace(0,2*pi*R,NPoints);
radius_d = [R*(ones(1,length(x)))]';
curve_d = 1./radius_d;
theta_d = th;

save('SkidPad_Track.mat','x','y','radius_d','curve_d','theta_d','distanceTrack')

