function [x_left,y_left,x_right,y_right,lb,ub] = Track_Boundary(x,y,w,Car)

if nargin < 4 || isempty(Car)
    Car.d_F = 0;
    Car.e_F = 0;
    Car.d_R = 0;
    Car.e_R = 0;
    Car.W_wFL = 0;
    Car.W_wFR = 0;
    Car.W_wRL = 0;
    Car.W_wRR = 0;
end

theta = Theta([x,y]);

x_left = x - sin(theta).*(w./2-max(Car.d_F+Car.W_wFL/2,Car.d_R+Car.W_wRL/2));
x_right = x + sin(theta).*(w./2-max(Car.e_F+Car.W_wFR/2,Car.e_R+Car.W_wRR/2));
y_left = y + cos(theta).*(w./2-max(Car.d_F+Car.W_wFL/2,Car.d_R+Car.W_wRL/2));
y_right = y - cos(theta).*(w./2-max(Car.e_F+Car.W_wFR/2,Car.e_R+Car.W_wRR/2));

x_min = min(x_left,x_right);
x_max = max(x_left,x_right);
y_min = min(y_left,y_right);
y_max = max(y_left,y_right);

ub = [x_max,y_max];
lb = [x_min,y_min];

end