%% Run Sim Here
clear all
close all
clc

%% Save results location
SaveLocation = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP';
FolderName = 'C_D_Sweep';
SimName = {'Test'};

%% Trackmap
% trackmap = 'Racing_Line.mat';
trackmap = 'Racing_Line_ClosedLoop.mat';
% trackmap = 'Acceleration_Track.mat';
% trackmap = 'SkidPad_Track.mat';
% trackmap = 'Full_FS_Weekend';

%% vCar boundary conditions
% Racing_Line_ClosedLoop 
BoundaryConditions.vCar_start = 28;
BoundaryConditions.vCar_end = 28;
% Acceleration_Track 
% BoundaryConditions.vCar_start = 0;
% BoundaryConditions.vCar_end = [];
% SkidPad_Track 
% BoundaryConditions.vCar_start = 12;
% BoundaryConditions.vCar_end = 12;

%% Sweep inputs
Sweep.Choose = 1;                                      % Choose whether to sweep or not
Sweep.Param = {'Car.AeroPerformance.C_D'};                     % Variable within car structure to be swept
Sweep.Values = 0.2:0.2:2;

%% Solver
% Choose one or the other!
Solver.Steady_state = 1;    % (Pre-sim only)
Solver.Dynamic_state = 0;   % (Includes steady state-solver in pre-sim)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Run sims
if strcmp(trackmap,'Full_FS_Weekend') == 1
    if Solver.Steady_state == 1
    	% Steady state solve for full FS weekend
        
    else
        % Dynamic solve for full FS weekend
        
    end
else
    if Solver.Steady_state == 1
    	% Steady state solve for single track
        Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,BoundaryConditions,Sweep,Solver)
    else
        % Dynamic solve for single track
        
    end
end

