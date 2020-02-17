function [F_x,F_y,F_xmax,F_ymax,F_xmin,F_ymin,SA_xmax,SA_xmin,SL_xmax,SL_xmin,SA_ymax,SA_ymin,SL_ymax,SL_ymin] = tyre_fmax(Car,Environment,Fz,IA,points,corner)

% Slip ratio
SL = linspace(-0.5,0.5,points);

% Slip angle
SA = linspace(-15,15,points);

[SA,SL] = meshgrid(SA,SL);

%% Combined slip additions based on Pacejka's 'Tyre and Vehicle Dynamics 4.2.2)
S_x = SL./(1+SL);
S_y = tand(SA)./(1+SL); % Alpha should be equal to alpha + Sh_y
S = sqrt((S_x.^2) + (S_y.^2));
if strcmp(corner,'FL') || strcmp(corner,'FR')
    [F_x0,F_y0,M_z0] = Pacejka_Tyre_Model(-Fz,S_x,S_y,deg2rad(IA),Car.Tyres.Front,Environment.track_conditions);
else
    [F_x0,F_y0,M_z0] = Pacejka_Tyre_Model(-Fz,S_x,S_y,deg2rad(IA),Car.Tyres.Rear,Environment.track_conditions);
end
F_x = F_x0.*(abs(S_x)./S);
F_y = F_y0.*(abs(S_y)./S);
M_z = M_z0;

% [F_x,F_y,~] = PacejkaTest(Car,SA,SL,Fz,IA);

% % Slip ratio
% figure
% for i = 1:size(F_x,1)
%     scatter(SL(:,i),F_x(:,i))
%     hold on
% end
% % Slip angle
% figure
% for i = 1:size(F_x,1)
%     scatter(SA(i,:),F_y(i,:))
%     hold on
% end
% % Self-aligning torque
% figure
% for i = 1:size(F_x,1)
%     scatter(SA(i,:),M_z(i,:))
%     hold on
% end
% % Friction ellipse
% figure
% for i = 1:size(F_x,1)
%     scatter(F_y(:,i),F_x(:,i))
%     hold on
% end

% Columns of F_x are the the lateral loading capability of a tyre under a
% set Fz. Each row is at a different slip ratio. Same format for F_y
% F_x = rmmissing(F_x);
% F_y = rmmissing(F_y);
F_x(isnan(F_x)) = 0;
F_y(isnan(F_y)) = 0;

% figure
% surf(SA,SL,F_y)
% figure
% hold on
% Force = zeros(length(F_x),length(F_x));
Force = [];
SlipAngle = [];
SlipRatio = [];
for i = 1:size(F_x,1)
    for j = 1:size(F_x,2)
%         scatter(F_x(i,j),F_y(i,j))
%         Force(j + (length(F_x)*(i-1)),1) = F_x(i,j);
%         Force(j + (length(F_x)*(i-1)),2) = F_y(i,j);
%         SlipAngle(j + (length(F_x)*(i-1)),1) = SA(i,j);
%         SlipRatio(j + (length(F_x)*(i-1)),1) = SL(i,j);
        Force = [Force; F_x(i,j), F_y(i,j)];
        SlipAngle = [SlipAngle; SA(i,j)];
        SlipRatio = [SlipRatio; SL(i,j)];
    end
end
% xlabel('Fx')
% ylabel('Fy')

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
for theta = 0:2.5:180
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
% Clean up SA and SL with some sketchy curve fitting
coeff = polyfit(Fx_interp,SL_interp,1);
SL_interp = polyval(coeff,Fx_interp);
coeff = polyfit(Fy_interp,SA_interp,1);
SA_interp = polyval(coeff,Fy_interp);
% Find outer edge boundary of tyre potential forces
k = boundary(Fy_interp,Fx_interp,0);
% Remove repeated point
k = k(1:end-1);
% Separate into four quadrants
k_xmax = k(Fx_interp >= 0);
k_xmin = k(Fx_interp <= 0);
k_ymax = k(Fy_interp >= 0);
k_ymin = k(Fy_interp <= 0);

% % Separate into four quadrants
% k_xmax = k(Fx >= 0);
% k_xmin = k(Fx <= 0);
% k_ymax = k(Fy >= 0);
% k_ymin = k(Fy <= 0);

% scatter(Fy,Fx,50,Slip.Angle,'filled'); colorbar

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
%     F_xmax = [Force(k_xmax,1),Force(k_xmax,2)];
%     F_xmin = [Force(k_xmin,1),Force(k_xmin,2)];
%     SA_xmax = SlipAngle(k_xmax);
%     SA_xmin = SlipAngle(k_xmin);
%     SL_xmax = SlipRatio(k_xmax);
%     SL_xmin = SlipRatio(k_xmin);
%     F_ymax = [Force(k_ymax,1),Force(k_ymax,2)];
%     F_ymin = [Force(k_ymin,1),Force(k_ymin,2)];
%     SA_ymax = SlipAngle(k_ymax);
%     SA_ymin = SlipAngle(k_ymin);
%     SL_ymax = SlipRatio(k_ymax);
%     SL_ymin = SlipRatio(k_ymin);
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

% figure
% hold on;
% scatter(F_xmax(:,1),F_xmax(:,2),1)
% scatter(F_ymax(:,1),F_ymax(:,2),1)
% scatter(F_xmin(:,1),F_xmin(:,2),1)
% scatter(F_ymin(:,1),F_ymin(:,2),1)
% title('Tyre Force Potential')
% xlabel('Tyre Fx Max (N)')
% ylabel('Tyre Fy Max (N)')