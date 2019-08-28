function result = PathFun3D(v,z,w,t,initial,x_left,y_left,x_right,y_right)

Path_x = v(:,1);
Path_y = v(:,2);
x = initial(:,1);
y = initial(:,2);

Deviation_C = ((x-Path_x).^2+(y-Path_y).^2).^0.5;
Deviation_L = ((x_left-Path_x).^2+(y_left-Path_y).^2).^0.5;
Deviation_R = ((x_right-Path_x).^2+(y_right-Path_y).^2).^0.5;
Side = sign(abs(Deviation_R-Deviation_C)-abs(Deviation_L-Deviation_C));
Path_z = z + Side.*Deviation_C.*sind(t);

P1 = [diff(Path_x) diff(Path_y) diff(Path_z)];
P2 = [ones(length(v)-1,1) zeros(length(v)-1,1) zeros(length(v)-1,1)];
angle = atan2(vecnorm(cross(P1,P2),2,2).*sign(diff(Path_y)),dot(P1,P2,2));
curve = diff(angle);
curve = curve - round(curve./(2*pi)) * 2*pi;

result = sum(abs(curve).^2);