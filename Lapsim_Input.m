%% Run Sim Here
clear all
close all
clc

%% Save results location
SaveLocation = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\Final Sims';
FolderName = 'Test';
SimName = {'Test'};

%% Trackmap
% trackmap = 'Trackmap_ClosedLoop.mat';
% trackmap = 'Racing_Line_ClosedLoop.mat';
% trackmap = 'DragRace_Track.mat';
% trackmap = 'Trackmap_ClosedLoop_with_slalom.mat';

% trackmap = 'Autocross_Track_800.mat';
% trackmap = 'Autocross_Track_2018.mat';
% trackmap = 'Endurance_Track.mat';
trackmap = 'Endurance_Track_1000.mat';
% trackmap = 'Acceleration_Track.mat';
% trackmap = 'SkidPad_Track.mat';
% trackmap = 'Full_FS_Weekend';

%% vCar boundary conditions
% Racing_Line_ClosedLoop 
BoundaryConditions.vCar_start = 26;
BoundaryConditions.vCar_end = 26;
% Acceleration_Track 
% BoundaryConditions.vCar_start = 0;
% BoundaryConditions.vCar_end = [];
% SkidPad_Track 
% BoundaryConditions.vCar_start = 12.5;
% BoundaryConditions.vCar_end = [];

%% Sweep inputs (can only sweep car params OR car files OR weatherfile)
Sweep.Choose_Param = 0;                                % Choose whether to sweep anything or not
Sweep.Param = {'Car.Balance.CoP(1)'};             % Variable within car structure to be swept
Sweep.Values = 0.2:0.1:0.7;
Sweep.Choose_Carfile = 0;
Sweep.Carfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\HEV1.mat',...
    'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Carfile'};
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
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
        % Skid-pad test
        disp('Simulating sweep of Skid-Pad Test...')
        trackmap = 'SkidPad_Track.mat';
        FolderSection = [FolderName '\SkidPad_Test'];
        SimName = {'SkidPad_Test'};
        BoundaryConditions.vCar_start = 12.5;
        BoundaryConditions.vCar_end = [];
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
        % Full lap (stationary start)
        disp('Simulating sweep of Autocross Test...')
%         trackmap = 'Autocross_Track_2018.mat';
        trackmap = 'Autocross_Track_800.mat';
        FolderSection = [FolderName '\Autocross_Test'];
        SimName = {'Autocross_Test'};
        BoundaryConditions.vCar_start = 0;
        BoundaryConditions.vCar_end = [];
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
        % Full lap (steady state)
        disp('Simulating steady state lap of Endurance Test...')
%         trackmap = 'Endurance_Track.mat';
        trackmap = 'Endurance_Track_1000.mat';
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
        [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
    else
        % Dynamic solve for single track
        
    end
end

