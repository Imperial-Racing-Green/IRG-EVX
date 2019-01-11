function [x,y,theta,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing)

%% Set Up
Direction = 1;
% Interpolation = 100;
% Length = 1200;
% Smoothing = 'On';
Plots = 'Off';

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
npoint_new = linspace(0,1,Interpolation * length(x))';

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

%% Smoothing
if strcmpi(Smoothing,'On') == 1
    windowSize = round(length(x) / 700);
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    theta_filtered = filter(b,a,theta);
end

%% Plot
if strcmpi(Plots,'On') == 1
    hold on
    plot(x,y,'k');
    scatter(x(1),y(1),'x','r');
    title('Track Map')
    xlabel('x Direction (m)')
    ylabel('y Direction (m)')
    
    figure
    hold on
    plot(Distance,theta);
    if strcmpi(Smoothing,'On') == 1
        plot(Distance,theta_filtered);
        legend('Original','Smoothed')
    end
    title('Yaw Angle')
    xlabel('Distance (m)')
    ylabel('Yaw Angle (rad)')
end