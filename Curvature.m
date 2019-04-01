function [curve] = Curvature(z)

x = z(:,1);
y = z(:,2);

curve = diff(atan2(diff(y),diff(x)));
for i = 1: length(curve)
    if curve(i) > 0.9 * 2 * pi
        curve(i) = curve(i) - 2 * pi;
    elseif curve(i) < -0.9 * 2 * pi
        curve(i) = curve(i) + 2 * pi;
    end
end