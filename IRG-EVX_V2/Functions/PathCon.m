function [c,ceq] = PathCon(z,x_left,y_left,x_right,y_right,Options)

x = z(:,1);
y = z(:,2);

c = [];

m = (y_left-y_right)./(x_left-x_right);
ceq = y - m .* (x - x_left) - y_left;

if strcmpi(Options.Rolling_Start,'On') == 1
    Gap = ((x(1)-x(end))^2 + (y(1)-y(end))^2)^0.5;
    if Gap <= 1
        end_angle = atan2(z(end,2)-z(end-1,2),z(end,1)-z(end-1,1));
        start_angle = atan2(z(2,2)-z(1,2),z(2,1)-z(1,1));
        error_angle = abs(start_angle - end_angle);
        error_position = Gap;
        ceq = [ceq;error_angle;error_position];
    end
    
end