function [c,ceq] = PathCon(z)

c = [];

end_angle = atan2(z(end,2)-z(end-1,2),z(end,1)-z(end-1,1));
start_angle = atan2(z(2,2)-z(1,2),z(2,1)-z(1,1));
error_angle = abs(start_angle - end_angle);
error_position = abs(z(1,2) - z(end,2));
ceq = [error_angle,error_position];
