function [F_x,F_y,F_xmax,F_ymax,F_xmin,F_ymin,SA_xmax,SA_xmin,SL_xmax,SL_xmin,SA_ymax,SA_ymin,SL_ymax,SL_ymin] = tyre_fmax(Car,Environment,Fz,IA,points,corner)

% Slip ratio
SL = linspace(-0.3,0.3,points);
% Slip angle
SA = linspace(-20,20,points);

[SA,SL] = meshgrid(SA,SL);

if strcmp(corner,'FL') || strcmp(corner,'FR')
    axle = 'Front';
else
    axle = 'Rear';
end
if strcmp(Car.Tyres.(axle).Name,'Hoosier_16.0x7.5-10_R25B')
    [F_x,F_y,~] = PacejkaTest(Car.Tyres.(axle),SA,SL,-Fz,IA);
else
    % Combined slip additions based on Pacejka's 'Tyre and Vehicle Dynamics 4.2.2)
    S_x = SL./(1+SL);
    S_y = tand(SA)./(1+SL); % Alpha should be equal to alpha + Sh_y
    S = sqrt((S_x.^2) + (S_y.^2));
    [F_x0,F_y0,~] = Pacejka_Tyre_Model(-Fz,S_x,S_y,deg2rad(IA),Car.Tyres.(axle),Environment.track_conditions);
    F_x = F_x0.*(abs(S_x)./S);
    F_y = F_y0.*(abs(S_y)./S);
end

% Columns of F_x are the the lateral loading capability of a tyre under a
% set Fz. Each row is at a different slip ratio. Same format for F_y
F_x(isnan(F_x)) = 0;
F_y(isnan(F_y)) = 0;

Force = [F_x(:), F_y(:)];
SlipAngle = SA(:);
SlipRatio = SL(:);

% Find outer edge boundary of tyre potential forces
k = boundary(Force(:,1),Force(:,2),0);
% Remove repeated point
k = k(1:end-1);

Fx = Force(k,1);
Fy = Force(k,2);
Slip.Angle = SlipAngle(k);
Slip.Ratio = SlipRatio(k);

% Fit ellipse to data points to define friction 'circle' and define a set
% number of points on this circle for consistency
% ay² + bxy + cx + dy + e = x²
x = Fy;
y = Fx;
coeffs = [y.^2,x.*y,x,y,ones(numel(x),1)]\x.^2;
% Solve for r in polar coordinate form
i = 1;
for theta = 0:5:180
    a = (coeffs(1)*((sind(theta))^2)) + (coeffs(2)*cosd(theta)*sind(theta)) - ((cosd(theta))^2);
    b = (coeffs(3)*cosd(theta)) + (coeffs(4)*sind(theta));
    c = coeffs(5);
    theta1(i) = theta; 
    r1(i) = (- b + sqrt((b^2) - (4*a*c)))/(2*a);
    theta2(i) = theta;
    r2(i) = (- b - sqrt((b^2) - (4*a*c)))/(2*a);
    i = i + 1;
end
Fx_interp = [r1.*sind(theta1), r2.*sind(theta2)]';
Fy_interp = [r1.*cosd(theta1), r2.*cosd(theta2)]';
temp = unique([Fy_interp,Fx_interp],'rows','stable');
Fy_interp = temp(:,1);
Fx_interp = temp(:,2);
[~, idx] = unique(Fx);
SL_interp = interp1(Fx(idx),Slip.Ratio(idx)',Fx_interp,'nearest','extrap');
[~, idx] = unique(Fy);
SA_interp = interp1(Fy(idx),Slip.Angle(idx)',Fy_interp,'nearest','extrap');
% Clean up SA and SL with some sketchy curve fitting (temporarily disable
% warnings)
orig_state = warning;
warning('off','all');
coeff = polyfit(Fx_interp,SL_interp,3);
SL_interp = polyval(coeff,Fx_interp);
coeff = polyfit(Fy_interp,SA_interp,3);
SA_interp = polyval(coeff,Fy_interp);
warning('on','all'); 
% Find outer edge boundary of tyre potential forces
k = boundary(Fy_interp,Fx_interp,0);
% Remove repeated point
k = k(1:end-1);
% Separate into four quadrants
k_xmax = k(Fx_interp >= 0);
k_xmin = k(Fx_interp <= 0);
k_ymax = k(Fy_interp >= 0);
k_ymin = k(Fy_interp <= 0);

if abs(Fz) == 0
    F_xmax = 0;
    F_xmin = 0;
    F_ymax = 0;
    F_ymin = 0;
    SA_xmax = 0;
    SA_xmin = 0;
    SL_xmax = 0;
    SL_xmin = 0;
    SA_ymax = 0;
    SA_ymin = 0;
    SL_ymax = 0;
    SL_ymin = 0;
else
    F_xmax = [Fx_interp(k_xmax), Fy_interp(k_xmax)];
    F_xmin = [Fx_interp(k_xmin), Fy_interp(k_xmin)];
    SA_xmax = SA_interp(k_xmax);
    SA_xmin = SA_interp(k_xmin);
    SL_xmax = SL_interp(k_xmax);
    SL_xmin = SL_interp(k_xmin);
    F_ymax = [Fx_interp(k_ymax), Fy_interp(k_ymax)];
    F_ymin = [Fx_interp(k_ymin), Fy_interp(k_ymin)];
    SA_ymax = SA_interp(k_ymax);
    SA_ymin = SA_interp(k_ymin);
    SL_ymax = SL_interp(k_ymax);
    SL_ymin = SL_interp(k_ymin);
end