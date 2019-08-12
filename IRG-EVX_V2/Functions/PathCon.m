function [c,ceq] = PathCon(z,x_left,y_left,x_right,y_right)

x = z(:,1);
y = z(:,2);

c = [];

m = (y_left-y_right)./(x_left-x_right);
ceq = y - m .* (x - x_left) - y_left;

% end_angle = atan2(z(end,2)-z(end-1,2),z(end,1)-z(end-1,1));
% start_angle = atan2(z(2,2)-z(1,2),z(2,1)-z(1,1));
% error_angle = abs(start_angle - end_angle);
% error_position = abs(z(1,2) - z(end,2));
% ceq = [error_angle,error_position];

