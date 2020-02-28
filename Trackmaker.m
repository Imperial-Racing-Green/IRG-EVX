close all
clear
clc

Trackmap1 = load('C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Endurance_Track_old.mat');
newTrackName = 'Endurance_Track.mat';
Track_Dist = 1000; 
%% First slalom
Slalom1.A = 2.5;
Slalom1.cone_dist = 13;
Slalom1.cone_number = 5;
Slalom1.x1 = -183.5;
Slalom1.y1 = 119.1;
Slalom1.slalom_number = 1;
%% Second slalom
Slalom2.A = -2.5;
Slalom2.cone_dist = 9;
Slalom2.cone_number = 3;
Slalom2.x1 = -61.85;
Slalom2.y1 = 21.17;
Slalom2.slalom_number = 2;

% Trackmap1 = load('C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Autocross_Track.mat');
% newTrackName = 'Autocross_Track_new.mat';
% Track_Dist = 900;
% %% First slalom
% Slalom1.A = 2.5;
% Slalom1.cone_dist = 13;
% Slalom1.cone_number = 5;
% Slalom1.x1 = -238.2;
% Slalom1.y1 = 73.81;
% Slalom1.slalom_number = 1;
% %% Second slalom
% Slalom2.A = -2.5;
% Slalom2.cone_dist = 9;
% Slalom2.cone_number = 3;
% Slalom2.x1 = -109.3;
% Slalom2.y1 = -30.48;
% Slalom2.slalom_number = 2;

%%%%%%%%%%%%%%% MINI SCRIPT %%%%%%%%%%%%%%%
% Run this section if you want to make the autocross track using an endurance track
Endurance = load('Endurance_Track.mat');
plot(Endurance.x,Endurance.y)
AutocrossStart = [44.26, 52.3];
AutocrossEnd = [-16.3, 0.002201];

[~,iStart] = min(abs([Endurance.x,Endurance.y] - AutocrossStart));
iStart = iStart(1);
[~,iEnd] = min(abs([Endurance.x,Endurance.y] - AutocrossEnd));
iEnd = iEnd(1);

x = Endurance.x(iStart:iEnd);
y = Endurance.y(iStart:iEnd);
curve_d = Endurance.curve_d(iStart:iEnd);
radius_d = Endurance.radius_d(iStart:iEnd);
theta_d = Endurance.theta_d(iStart:iEnd);
distanceTrack = Endurance.distanceTrack(iStart:iEnd);
distanceTrack = distanceTrack - distanceTrack(1);
save('Autocross_Track_new.mat','curve_d','distanceTrack','radius_d','theta_d','x','y')
%%%%%%%%%%%%%%% End of mini script %%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(Trackmap1.x,Trackmap1.y); axis equal; hold on;

%% Apply slaloms
dist = Trackmap1.distanceTrack;
% First slalom
x = Trackmap1.x;
y = Trackmap1.y;
[coords] = slalom_gen(Slalom1.A,Slalom1.cone_dist,Slalom1.cone_number,Slalom1.x1,Slalom1.y1,x,y,dist,Slalom1.slalom_number);
x = coords(:,1);
y = coords(:,2);

% Second slalom
[coords] = slalom_gen(Slalom2.A,Slalom2.cone_dist,Slalom2.cone_number,Slalom2.x1,Slalom2.y1,x,y,dist,Slalom2.slalom_number);
x = coords(:,1);
y = coords(:,2);

% Smooth out discontinuous points where slalom begins
idx = [find(abs(diff(x)) >= 3); find(abs(diff(y)) >= 3)];
idx = unique(idx);
for i = 1:length(idx)
    x_sam = interp1([1,4],[x(idx(i)-1),x(idx(i)+2)],[1,2,3,4]);
    x(idx(i)-1:idx(i)+2) = x_sam;
    y_sam = interp1([1,4],[y(idx(i)-1),y(idx(i)+2)],[1,2,3,4]);
    y(idx(i)-1:idx(i)+2) = y_sam;
end

%% Will's code to sort the other params
Direction = 1;
Track_Width = 3; %track width in meteres
% Max_Track_Resolution = 1; %track points per metre
Steps = 1; %steps in optmisation smoothness
% Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
Resolution = 0.5;
Iterations = 5000; %max iterations for optmisation
% Interpolation = Track_Dist*Resolution;
Interpolation = 600;
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
%     windowSize = round(length(x) / 500);
%     b = (1/windowSize)*ones(1,windowSize);
%     a = 1;
%     theta_filtered = filter(b,a,theta);
    sample = 1:length(theta);
    f = fit(sample',theta,'smoothingspline','SmoothingParam',0.8);
    theta_filtered = f(sample);
%     windowSize = round(length(x) / 50);
%     b = (1/windowSize)*ones(1,windowSize);
%     curvature_filtered = filter(b,a,curvature);    
    sample = 1:length(curvature);
    f = fit(sample',curvature,'smoothingspline','SmoothingParam',0.5);
    curvature_filtered = f(sample);
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

% % Second slalom
% dist = distanceTrack;
% [coords] = slalom_gen(Slalom2.A,Slalom2.cone_dist,Slalom2.cone_number,Slalom2.x1,Slalom2.y1,x,y,dist,Slalom2.slalom_number);
% x = coords(:,1);
% y = coords(:,2);
% 
% % Smooth out discontinuous points where slalom begins
% idx = [find(abs(diff(x)) >= 3); find(abs(diff(y)) >= 3)];
% idx = unique(idx);
% for i = 1:length(idx)
%     x_sam = interp1([1,4],[x(idx(i)-1),x(idx(i)+2)],[1,2,3,4]);
%     x(idx(i)-1:idx(i)+2) = x_sam;
%     y_sam = interp1([1,4],[y(idx(i)-1),y(idx(i)+2)],[1,2,3,4]);
%     y(idx(i)-1:idx(i)+2) = y_sam;
% end
% 
% %% Will's code to sort the other params
% Direction = 1;
% Track_Width = 3; %track width in meteres
% % Max_Track_Resolution = 1; %track points per metre
% Steps = 1; %steps in optmisation smoothness
% % Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
% Resolution = 0.5;
% Iterations = 5000; %max iterations for optmisation
% % Interpolation = Track_Dist*Resolution;
% Interpolation = 600;
% Length = Track_Dist;
% Line_Optim = 'Off';
% Smoothing = 'On';
% 
% %% Adjust Start Finish
% dist = (x.^2 + y.^2).^0.5;
% [~,start] = min(dist);
% 
% x = circshift(x,length(x) - start + 1);
% y = circshift(y,length(y) - start + 1);
% x = x - x(1);
% y = y - y(1);
% 
% %% Interpolation
% npoint_old = linspace(0,1,length(x))';
% npoint_new = linspace(0,1,Interpolation)';
% 
% method = 'spline'; 
% x = (interp1( npoint_old, x, npoint_new, method));
% y = (interp1( npoint_old, y, npoint_new, method));
% 
% %% Change Direction
% 
% if Direction == -1
%     x = fliplr(x);
%     y = fliplr(y);
% end
% 
% %% Path Length Adjust
% Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
% Distance = cumsum(Spacing);                       	%Cumulative segment/path length
% % Distance = Distance - Distance(1)/3;
% 
% if Length > 0
%     Ratio = Length/max(Distance);
%     x = Ratio .* x;
%     y = Ratio .* y;
%     Distance = Ratio .* Distance;
% end
% 
% %% Yaw Angle
% theta = atan2(diff(y),diff(x));
% 
% % Address Discontinuities
% for k = 2:1:length(theta)
%     dChange = theta(k) - theta(k-1);
%     if (abs(dChange) > 0.9*pi)
%         r = round(dChange/pi);
%         theta(k) = theta(k) - r*pi;
%     end
% end
% 
% %% Driving Line Optimisation
% if strcmpi(Line_Optim,'On') == 1
%     x0 = x;
%     y0 = y;
%     [x_new,y_new] = Path_Optim(x,y,x0,y0,theta,Track_Width,Optim_Iterations);
%     
% %     if strcmpi(Plots,'On') == 1
% %         plot(x_new,y_new,'r')
% %     end
%     x = x_new;
%     y = y_new;
%     
%     %Yaw Angle again
%     theta = atan2(diff(y),diff(x));
%     
%     % Address Discontinuities
%     for k = 2:1:length(theta)
%         dChange = theta(k) - theta(k-1);
%         if (abs(dChange) > 0.9*pi)
%             r = round(dChange/pi);
%             theta(k) = theta(k) - r*pi;
%         end
%     end
%     Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
%     Distance = cumsum(Spacing);                       	%Cumulative segment/path length
% %     Distance = Distance - Distance(1)/3;
% end
% 
% %% Curvature
% curvature = diff(theta)./diff(Distance);
% 
% %% Smoothing
% if strcmpi(Smoothing,'On') == 1
%     windowSize = round(length(x) / 500);
%     b = (1/windowSize)*ones(1,windowSize);
%     a = 1;
%     theta_filtered = filter(b,a,theta);
%     windowSize = round(length(x) / 50);
%     b = (1/windowSize)*ones(1,windowSize);
%     curvature_filtered = filter(b,a,curvature);
% end
% 
% %% Radius
% radius = 1./curvature;
% if strcmpi(Smoothing,'On') == 1
%     radius_filtered = 1./curvature_filtered;
% end
% 
% %% Outputs
% x = x - x(1);
% y = y - y(1);
% Distance = [0;Distance];
% if strcmpi(Smoothing,'On') == 1
%     curvature = curvature_filtered;
%     theta = theta_filtered;
%     radius = radius_filtered;
% end
% theta = [theta(1);theta];
% 
% curve_d = curvature;
% distanceTrack = Distance;
% theta_d = theta;
% radius_d = radius;

plot(x,y)

save(newTrackName,'curve_d','distanceTrack','radius_d','theta_d','x','y')