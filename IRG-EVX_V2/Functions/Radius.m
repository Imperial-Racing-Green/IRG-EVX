function R = Radius(x,y)

R = zeros(length(x)-2,1);

for i = 2:length(x) - 1
    A = ((x(i) - x(i-1))^2 + (y(i) - y(i-1))^2)^0.5;
    B = ((x(i+1) - x(i))^2 + (y(i+1) - y(i))^2)^0.5;
    C = ((x(i+1) - x(i-1))^2 + (y(i+1) - y(i-1))^2)^0.5;
    P = (A+B+C)/2;
    K = (abs(P*(P-A)*(P-B)*(P-C)))^0.5;
    if K == 0
        R(i-1) = Inf;
    else
        R(i-1) = (A*B*C)/(4*K);
    end
end

R(isinf(R)) = 1000000; %remove infonite radius entries

% Distance = Track_Dist(x,y);

oldn = linspace(1,length(R)-1,length(R))';
newn = linspace(0,length(R),length(x))';
R = interp1(oldn,R,newn,'spline');

end