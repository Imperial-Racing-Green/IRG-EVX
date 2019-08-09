function [Track] = Track_Gen(File,Car,Options)

%% Read Data

% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["x", "y", "z", "w"];
opts.VariableTypes = ["double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
FSUK_Sprint = readtable(File, opts);

clear opts

%% Change Direction

if strcmpi(Options.Flip_Direction,'On') == 1
    FSUK_Sprint = flip(FSUK_Sprint);
end

%% Adjust Start Finish
dist = (FSUK_Sprint.x.^2 + FSUK_Sprint.y.^2).^0.5;
[~,start] = min(dist);

x = circshift(FSUK_Sprint.x,length(FSUK_Sprint.x) - start + 1);
y = circshift(FSUK_Sprint.y,length(FSUK_Sprint.y) - start + 1);
z = circshift(FSUK_Sprint.z,length(FSUK_Sprint.z) - start + 1);
w = circshift(FSUK_Sprint.w,length(FSUK_Sprint.w) - start + 1);
x = x - x(1);
y = y - y(1);
z = z - min(z);

%% Add Extra Point for Complete Laps
% Check if start and finish are in same place
Gap = ((x(1)-x(end))^2 + (y(1)-y(end))^2)^0.5;
if Gap <= 1
    x = [x;x(1)];
    y = [y;y(1)];
    z = [z;z(1)];
    w = [w;w(1)];
end

%% Caluclate Track Length
Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
Distance = cumsum(Spacing);                       	%Cumulative segment/path length

%% Interpolate to Default Track Resolution

DefaultRes = 2;
[x,y,z,w] = Track_Interp(x,y,z,w,max(Distance)*DefaultRes);

%% Get Track Boundaries
[x_left,y_left,x_right,y_right,~,~] = Track_Boundary(x,y,w);

%% Driving Line Optimisation
if strcmpi(Options.Driving_Line_Optimisation,'On') == 1
    
    % Interpolation to Reduce Resolution
    % Set Resolution
    if strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Very High') == 1
        Resolution = 1;
    elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'High') == 1
        Resolution = 0.75;
    elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Medium') == 1
        Resolution = 0.5;
    elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Low') == 1
        Resolution = 0.375;
    elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Very Low') == 1
        Resolution = 0.25;
    else
        disp('Driving Line Optimisation Accuracy setting invalid.');
        disp('Terminating Simulation.');
    end
    
    % [x,y,z,w] = Track_Interp(x,y,z,w,Resolution);
    [x_low,y_low,~,w_low] = Track_Interp(x,y,z,w,Resolution * max(Distance));
    
    % Line Optimisation
    % Get Path Boundaries
    [~,~,~,~,lb,ub] = Track_Boundary(x_low,y_low,w_low,Car);
    
    [xnew,ynew] = Path_Optim(x_low,y_low,lb,ub,Options);
    
    % Interpolate to Increase Path Resolution
    [Path.x_left,Path.y_left,Path.x_right,Path.y_right,~,~] = Track_Boundary(x,y,w,Car);
    Path.x = Interpolate(length(xnew),round(max(Distance)*DefaultRes),xnew,'spline')';
    Path.y = Interpolate(length(ynew),round(max(Distance)*DefaultRes),ynew,'spline')';
    
    % Erase Track Width Data
    w = zeros(length(w),1);
end

% Pass output variables to output structure
Track.x = x;
Track.y = y;
Track.z = z;
Track.w = w;
Track.x_left = x_left;
Track.x_right = x_right;
Track.y_left = y_left;
Track.y_right = y_right;
Track.Path.x = Path.x;
Track.Path.y = Path.y;
Track.Path.theta = Theta([Path.x,Path.y]);
Track.Path.x_left = Path.x_left;
Track.Path.x_right = Path.x_right;
Track.Path.y_left = Path.y_left;
Track.Path.y_right = Path.y_right;

end

