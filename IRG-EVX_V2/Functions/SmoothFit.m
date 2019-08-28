function [x,y] = SmoothFit(x,y,npoints,times,method)
x1 = x;
y1 = y;
if times > 0
    for j = 1:round(times)
        x2 = zeros(length(x)-1,1);
        y2 = zeros(length(x)-1,1);
        for i = 1:length(x)-1
            x2(i) = (x(i) + x(i+1))/2;
            y2(i) = (y(i) + y(i+1))/2;
        end
        odd = 1;
        x3 = zeros(length(x)+length(x2),1);
        y3 = zeros(length(x)+length(x2),1);
        for i = 1:length(x)+length(x2)
            if odd == 1
                x3(i) = x((i+1)/2);
                y3(i) = y((i+1)/2);
                odd = 0;
            else
                x3(i) = x2(i/2);
                y3(i) = y2(i/2);
                odd = 1;
            end
        end
        x = x3;
        y = y3;
    end
end
    x3 = x;
    x = linspace(1,max(x1),npoints)';
    y = interp1(x3,y,x,method);