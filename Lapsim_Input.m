%% Run Sim Here
clear all
close all
clc

%% Save results location


SaveLocation = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP';
FolderName = 'Carfiles_for_Jen';
SimName = {'Test'};

%% Trackmap

%trackmap = 'Endurance_Track.mat.mat';
%trackmap = 'Autocross_Track_2018.mat';
%trackmap = 'Acceleration_Track.mat';
%trackmap = 'SkidPad_Track_new.mat';
trackmap = 'Full_FS_Weekend';

%% vCar boundary conditions
% Racing_Line_ClosedLoop 
% BoundaryConditions.vCar_start = 26;
% BoundaryConditions.vCar_end = 26;
% Acceleration_Track 
%BoundaryConditions.vCar_start = 0;
%BoundaryConditions.vCar_end = [];
% SkidPad_Track 
  BoundaryConditions.vCar_start = 12.8;
  BoundaryConditions.vCar_end = [];


%% Sweep inputs (can only sweep car params OR car files OR weatherfile)
Sweep.Choose_Param = 0;                                % Choose whether to sweep anything or not
Sweep.Param = {'Car.Mass.Total'};             % Variable within car structure to be swept
Sweep.Values = 238:5:258;
Sweep.Choose_Carfile = 1;
Sweep.Carfile = {''};
Sweep.Choose_Weatherfile = 0;
Sweep.Weatherfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Weatherfile.mat'};


%% Solver
% Choose one or the other!
Solver.Steady_state = 1;    % (Pre-sim only)
Solver.Dynamic_state = 0;   % (Includes steady state-solver in pre-sim)
Validation = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Run sims
if strcmp(trackmap,'Full_FS_Weekend') == 1
    if Solver.Steady_state == 1

    	% Steady state solve for full FS weekend
        SaveResults = 1;

        % Acceleration test
        disp('Simulating sweep of Acceleration Test...')
        trackmap = 'Acceleration_Track.mat';
        FolderSection = [FolderName '\Acceleration_Test'];
        SimName = {'Acceleration_Test'};
        BoundaryConditions.vCar_start = 0;
        BoundaryConditions.vCar_end = [];
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults);
        % Skid-pad test
        disp('Simulating sweep of Skid-Pad Test...')
        trackmap = 'SkidPad_Track_new.mat';
        FolderSection = [FolderName '\SkidPad_Test'];
        SimName = {'SkidPad_Test'};
        BoundaryConditions.vCar_start = 13.6;
        BoundaryConditions.vCar_end = [];
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
        % Full lap (stationary start)
        disp('Simulating sweep of Autocross Test...')
        trackmap = 'Autocross_Track_2018.mat';
        FolderSection = [FolderName '\Autocross_Test'];
        SimName = {'Autocross_Test'};
        BoundaryConditions.vCar_start = 0;
        BoundaryConditions.vCar_end = [];
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
        % Full lap (steady state)
        disp('Simulating steady state lap of Endurance Test...')
        trackmap = 'Endurance_Track.mat';
        FolderSection = [FolderName '\Endurance_Test'];
        SimName = {'Endurance_Test'};
        BoundaryConditions.vCar_start = 26;
        BoundaryConditions.vCar_end = 26;
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);        
    else
        % Dynamic solve for full FS weekend
        
    end
else
    if Solver.Steady_state == 1
        SaveResults = 1;
    	% Steady state solve for single track
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,BoundaryConditions,Sweep,SaveResults);
    else
        % Dynamic solve for single track
        
    end
end

