function fy = fx_model(a_slip,Fz)
x1  =  500*0.0174533*a_slip;  %Slip ratio, with fudge factor
x2  = Fz;  % Fz
P = [2 1 12.5 1.55]; %Fitted to FSAE TTC Round 6 Run 2
D1  = P(1);
D2  = P(2);
B   = P(3);
C   = P(4);
D   = (D1 + D2/1000.*x2).*x2;   % peak value (normalized)
fy  = D.*sin(C.*atan(B.*x1));   