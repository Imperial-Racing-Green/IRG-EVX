function [force] = pacejka4(coef, slip)
%PACEJKA4 Summary of this function goes here
%   Detailed explanation goes here
B = coef(1);
C = coef(2);
D = coef(3);
E = coef(4);
Sv = coef(5); %Vertical shift
Sh = coef(6); %Horizontal shift

x = slip + Sh;
y = D*sin(C*atan(B*x - E*(B*x - atan(B*x))));
force = y + Sv;
end

