close all
clear
clc

% Trackmap1 = load('C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Endurance_Track_1000.mat');
% Track_Dist = 1000; 
% %% First slalom
% Slalom1.A = 5;
% Slalom1.cone_dist = 13;
% Slalom1.cone_number = 5;
% Slalom1.x1 = -183.5;
% Slalom1.y1 = 119.1;
% Slalom1.slalom_number = 1;
% %% Second slalom
% Slalom2.A = 5;
% Slalom2.cone_dist = 9;
% Slalom2.cone_number = 3;
% Slalom2.x1 = -61.85;
% Slalom2.y1 = 21.17;
% Slalom2.slalom_number = 2;

Trackmap1 = load('C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Autocross_Track_800.mat');
Track_Dist = 900;
%% First slalom
Slalom1.A = 5;
Slalom1.cone_dist = 13;
Slalom1.cone_number = 5;
Slalom1.x1 = -238.2;
Slalom1.y1 = 73.81;
Slalom1.slalom_number = 1;
%% Second slalom
Slalom2.A = -5;
Slalom2.cone_dist = 9;
Slalom2.cone_number = 3;
Slalom2.x1 = -109.3;
Slalom2.y1 = -30.48;
Slalom2.slalom_number = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(Trackmap1.x,Trackmap1.y); axis equal; hold on;

dist = Trackmap1.distanceTrack;
x = Trackmap1.x;
y = Trackmap1.y;
[coords] = slalom_gen(Slalom1.A,Slalom1.cone_dist,Slalom1.cone_number,Slalom1.x1,Slalom1.y1,x,y,dist,Slalom1.slalom_number);
x = coords(:,1);
y = coords(:,2);

%% Will's code to sort the other params
Direction = 1;
Track_Width = 3; %track width in meteres
% Max_Track_Resolution = 1; %track points per metre
Steps = 1; %steps in optmisation smoothness
% Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
Resolution = 0.5;
Iterations = 5000; %max iterations for optmisation
Interpolation = Track_Dist*Resolution;
Length = Track_Dist;
Line_Optim = 'Off';
Smoothing = 'On';

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

curve_d = curvature;
distanceTrack = Distance;
theta_d = theta;
radius_d = radius;

% Second slalom
dist = distanceTrack;
[coords] = slalom_gen(Slalom2.A,Slalom2.cone_dist,Slalom2.cone_number,Slalom2.x1,Slalom2.y1,x,y,dist,Slalom2.slalom_number);
x = coords(:,1);
y = coords(:,2);

%% Will's code to sort the other params
Direction = 1;
Track_Width = 3; %track width in meteres
% Max_Track_Resolution = 1; %track points per metre
Steps = 1; %steps in optmisation smoothness
% Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
Resolution = 0.5;
Iterations = 5000; %max iterations for optmisation
Interpolation = Track_Dist*Resolution;
Length = Track_Dist;
Line_Optim = 'Off';
Smoothing = 'On';

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

curve_d = curvature;
distanceTrack = Distance;
theta_d = theta;
radius_d = radius;

plot(x,y)

% save('Endurance_Track_1000_new.mat','curve_d','distanceTrack','radius_d','theta_d','x','y')
save('Autocross_Track_800.mat','curve_d','distanceTrack','radius_d','theta_d','x','y')