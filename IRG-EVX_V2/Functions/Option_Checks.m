function [Run] = Option_Checks(Options,Plots)

%% Initialise Run variable
Run = 1;

%% User Simulation Options
% Check simulation options.
if strcmpi(Options.Quasi_Static_Simulation,'On') == 1
elseif strcmpi(Options.Quasi_Static_Simulation,'Off') == 1
else
    disp('Quasi_Static_Simulation option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Dynamic_Simulation,'On') == 1
elseif strcmpi(Options.Dynamic_Simulation,'Off') == 1
else
    disp('Dynamic_Simulation option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Driving_Line_Optimisation,'On') == 1
elseif strcmpi(Options.Driving_Line_Optimisation,'Off') == 1
else
    disp('Driving_Line_Optimisation option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Very Low') == 1
elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Low') == 1
elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Medium') == 1
elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'High') == 1
elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Very High') == 1
else
    disp('Driving_Line_Optimisation_Accuracy option invalid...')
    disp('Option should be set to ''Very Low'', ''Low'', ''Medium'', ''High'', or ''Very High''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Rolling_Start,'On') == 1
elseif strcmpi(Options.Rolling_Start,'Off') == 1
else
    disp('Rolling_Start option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Rolling_Start,'On') == 1
elseif strcmpi(Options.Rolling_Start,'Off') == 1
else
    disp('Rolling_Start option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Reverse_Direction,'On') == 1
elseif strcmpi(Options.Reverse_Direction,'Off') == 1
else
    disp('Reverse_Direction option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Show_Progress,'On') == 1
elseif strcmpi(Options.Show_Progress,'Off') == 1
else
    disp('Show_Progress option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Save_to_File,'On') == 1
elseif strcmpi(Options.Save_to_File,'Off') == 1
else
    disp('Save_to_File option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Options.Debug_Mode,'On') == 1
elseif strcmpi(Options.Debug_Mode,'Off') == 1
else
    disp('Debug_Mode option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

%% User Plot Options
% Check plot options.

if strcmpi(Plots.Optimisation_Progress,'On') == 1
elseif strcmpi(Plots.Optimisation_Progress,'Off') == 1
else
    disp('Optimisation_Progress plot option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Plots.Path_Velocity,'On') == 1
elseif strcmpi(Plots.Path_Velocity,'Off') == 1
else
    disp('Path_Velocity plot option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Plots.Velocity,'On') == 1
elseif strcmpi(Plots.Velocity,'Off') == 1
else
    disp('Velocity plot option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Plots.Pedal_Position,'On') == 1
elseif strcmpi(Plots.Pedal_Position,'Off') == 1
else
    disp('Pedal_Position plot option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

if strcmpi(Plots.Steering_Angle,'On') == 1
elseif strcmpi(Plots.Steering_Angle,'Off') == 1
else
    disp('Steering_Angle plot option invalid...')
    disp('Option should be set to ''On'' or ''Off''.')
    disp(' ')
    Run = 0;
end

%% Message if simulation is to be stopped
if Run == 0
    disp('Simulation stopped.')
    disp(' ')
end