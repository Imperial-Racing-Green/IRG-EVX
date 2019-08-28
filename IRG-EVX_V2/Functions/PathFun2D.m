function result = PathFun2D(v,z,w,t,initial,x_left,y_left,x_right,y_right)

angle = atan2(diff(v(:,2)),diff(v(:,1)));
curve = diff(angle);
curve = curve - round(curve./(2*pi)) * 2*pi;

result = sum(abs(curve).^2);