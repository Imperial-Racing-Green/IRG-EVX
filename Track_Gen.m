function [x,y,theta,curvature,radius,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing,Line_Optim,Track_Width,Optim_Iterations)

%% Set Up
Direction = 1;
% Interpolation = 100;
% Length = 1200;
% Smoothing = 'On';
Plots = 'On';

%% Read Data
csv_data = csvread(filename);

x = csv_data(:,1);
y = csv_data(:,2);

%% Adjust Start Finish
dist = (x.^2 + y.^2).^0.5;
[~,start] = min(dist);

x = circshift(x,length(x) - start + 1);
y = circshift(y,length(y) - start + 1);
x = x - x(1);
y = y - y(1);

%% Interpolation
npoint_old = linspace(0,1,length(x))';
npoint_new = linspace(0,1,Interpolation)';

method = 'spline'; 
x = (interp1( npoint_old, x, npoint_new, method));
y = (interp1( npoint_old, y, npoint_new, method));

%% Change Direction

if Direction == -1
    x = fliplr(x);
    y = fliplr(y);
end

%% Path Length Adjust
Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
Distance = cumsum(Spacing);                       	%Cumulative segment/path length
% Distance = Distance - Distance(1)/3;

if Length > 0
    
    Ratio = Length/max(Distance);
    x = Ratio .* x;
    y = Ratio .* y;
    Distance = Ratio .* Distance;
end

%% Yaw Angle
theta = atan2(diff(y),diff(x));

% Address Discontinuities
for k = 2:1:length(theta)
    dChange = theta(k) - theta(k-1);
    if (abs(dChange) > 0.9*pi)
        r = round(dChange/pi);
        theta(k) = theta(k) - r*pi;
    end
end

%% Driving Line Optimisation
if strcmpi(Line_Optim,'On') == 1
    x0 = x;
    y0 = y;
    [x_new,y_new] = Path_Optim(x,y,x0,y0,theta,Track_Width,Optim_Iterations);
    
%     if strcmpi(Plots,'On') == 1
%         plot(x_new,y_new,'r')
%     end
    x = x_new;
    y = y_new;
    
    %Yaw Angle again
    theta = atan2(diff(y),diff(x));
    
    % Address Discontinuities
    for k = 2:1:length(theta)
        dChange = theta(k) - theta(k-1);
        if (abs(dChange) > 0.9*pi)
            r = round(dChange/pi);
            theta(k) = theta(k) - r*pi;
        end
    end
    Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
    Distance = cumsum(Spacing);                       	%Cumulative segment/path length
%     Distance = Distance - Distance(1)/3;
end

%% Curvature
curvature = diff(theta)./diff(Distance);

%% Smoothing
if strcmpi(Smoothing,'On') == 1
    windowSize = round(length(x) / 500);
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    theta_filtered = filter(b,a,theta);
    windowSize = round(length(x) / 50);
    b = (1/windowSize)*ones(1,windowSize);
    curvature_filtered = filter(b,a,curvature);
end

%% Radius
radius = 1./curvature;
if strcmpi(Smoothing,'On') == 1
    radius_filtered = 1./curvature_filtered;
end

%% Plot
if strcmpi(Plots,'On') == 1

%     hold on
%     plot(Distance,theta);
%     if strcmpi(Smoothing,'On') == 1
%         plot(Distance,theta_filtered);
%         legend('Original','Smoothed')
%     end
%     title('Yaw Angle')
%     xlabel('Distance (m)')
%     ylabel('Yaw Angle (rad)')
%     
%     figure
%     hold on
%     plot(Distance(1:end-1),curvature);
%     if strcmpi(Smoothing,'On') == 1
%         plot(Distance(1:end-1),curvature_filtered);
%         legend('Original','Smoothed')
%     end
%     title('Curvature')
%     xlabel('Distance (m)')
%     ylabel('Curvature (1/m)')
%     
%     figure
%     hold on
%     plot(Distance(1:end-1),radius);
%     if strcmpi(Smoothing,'On') == 1
%         plot(Distance(1:end-1),radius_filtered);
%         legend('Original','Smoothed')
%     end
%     title('Radius')
%     xlabel('Distance (m)')
%     ylabel('Radius (1/m)')
    
%     figure
    hold on
    plot(x,y,'r');
    scatter(x(1),y(1),'x','r');
    title('Track Map')
    xlabel('x Direction (m)')
    ylabel('y Direction (m)')
end

%% Outputs
x = x - x(1);
y = y - y(1);
Distance = [0;Distance];
if strcmpi(Smoothing,'On') == 1
    curvature = curvature_filtered;
    theta = theta_filtered;
    radius = radius_filtered;
end
theta = [theta(1);theta];
% theta(1)=0;
% theta(2)=0;
% theta(end-1)=2*pi;
% theta(end)=2*pi;
% 
% curvature(1)=0;
% curvature(2)=0;
% curvature(end-1)=0;
% curvature(end)=0;
% 
% radius(1)=1e5;
% radius(2)=1e5;
% radius(end-1)=1e5;
% radius(end)=1e5;
% 
% x(end)=0;
% y(end)=0;



