% close all
clear
clc

%% Load inputs
csv_data = csvread('/Users/Foster/OneDrive/ME4/FYP/Track Generation/FSUK Track Centreline.csv');      	%Load csv data
dLength = 1000;
bPlot = true;

%% Proccess the axis coordinates
x = fliplr(csv_data(:,1)');                                              %X coordinate
y = fliplr(csv_data(:,2)');                                              %Y coordinate

adGrid_Old              = linspace(0,1,length(x))';           	%Original path vector
adGrid_New              = linspace(0,1,100*length(x))';          	%Fine path vector

adPos = find(abs(x - 40) < 20);
x = circshift(x,adPos(1));
y = circshift(y,adPos(1));

method = 'spline';                                              %Interpolation method
x = (interp1( adGrid_Old, x, adGrid_New, method));        %Interpolate to finer coordinates
y = (interp1( adGrid_Old, y, adGrid_New, method));        %Interpolate to finer coordinates

%% Calculate the path vector
dSpacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
adPath = cumsum(dSpacing);                       	%Cumulative segment/path length
rLength = dLength/max(adPath);

x = rLength.*x;
y = rLength.*y;

dSpacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
adPath = cumsum(dSpacing);                       	%Cumulative segment/path length

%% Calculate the curvature --- Fun begins here
yaw_angle = atan2(diff(y),diff(x));             	%Yaw angle

%Ensure that there are no sudden changes in yaw_angle due to atan2 quadrants
for k = 2:1:length(yaw_angle)
    dChange = yaw_angle(k) - yaw_angle(k-1);        %Change in angle of successive segments
    if (abs(dChange) > 0.9*pi)                      %Case where there was a "jump" after reaching +/-pi
        r = round(dChange/pi);
        yaw_angle(k) = yaw_angle(k) - r*pi;
    end
end
yaw_angle = smoothdata(yaw_angle,'sgolay',200);
adCurvature = (diff(yaw_angle))./dSpacing(1:end-1); %Calculate curvature using dl = rdTheta

%% Plot the results

if (bPlot)
    nFig = figure(1);                           %Create a new figure
    set(nFig, 'Name', 'Track Parameters');      %Set the name of the figure
    subplot(3,1,1)                              %Upper subplot
    plot(x,y,'b');                            	%Plot the track coordinates
    title('Track Layout')
    subplot(3,1,2)                              %Middle subplot
    plot(adPath, yaw_angle);                    %Yaw angle vs. lap position
    title('Yaw Angle vs. Position')
    subplot(3,1,3)                              %Bottom subplot
  	plot(adPath(1:end-1), adCurvature);         %Curvature vs. lap position
    title('Curvature vs. Position')
    hold off
end

