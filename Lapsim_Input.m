%% Run Sim Here
clear all
close all
clc

%% Save results location
SaveLocation = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Fomula Student\EV1 Sims';
FolderName = 'Test';
SimName = {'Test'};

%% Trackmap
% trackmap = 'Acceleration_Track.mat';
% trackmap = 'SkidPad_Track.mat';
% trackmap = 'Autocross_Track.mat';
trackmap = 'Endurance_Track_1000_new';
% trackmap = 'Full_FS_Weekend';

%% Sweep inputs (can only sweep car params OR car files OR weatherfile)
Sweep.Choose_Param = 0;                                % Choose whether to sweep anything or not
Sweep.Param = {'Car.Brakes.BrakeBias'};             % Variable within car structure to be swept
Sweep.Values = 0.5:0.05:0.7;
Sweep.Choose_Carfile = 0;
Sweep.Carfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\HEV1.mat',...
    'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Carfile'};
Sweep.Choose_Weatherfile = 0;
Sweep.Weatherfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Weatherfile.mat'};


bUseAeromap = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Run sims
if strcmp(trackmap,'Full_FS_Weekend') == 1
    SaveResults = 1;
    % Acceleration test (stationary start)
    disp('Simulating sweep of Acceleration Test...')
    trackmap = 'Acceleration_Track.mat';
    FolderSection = [FolderName '\Acceleration_Test'];
    SimName = {'Acceleration_Test'};
    BoundaryConditions.vCar_start = 0;
    BoundaryConditions.vCar_end = [];
    [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,Sweep,SaveResults,bUseAeromap);
    % Skid-pad test
    disp('Simulating sweep of Skid-Pad Test...')
    trackmap = 'SkidPad_Track.mat';
    FolderSection = [FolderName '\SkidPad_Test'];
    SimName = {'SkidPad_Test'};
    BoundaryConditions.vCar_start = [];
    BoundaryConditions.vCar_end = [];
    [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,Sweep,SaveResults,bUseAeromap);
    % Autocross lap (stationary start)
    disp('Simulating sweep of Autocross Test...')
    trackmap = 'Autocross_Track.mat';
    FolderSection = [FolderName '\Autocross_Test'];
    SimName = {'Autocross_Test'};
    BoundaryConditions.vCar_start = 0;
    BoundaryConditions.vCar_end = [];
    [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,Sweep,SaveResults,bUseAeromap);
    % Endurance lap
    disp('Simulating steady state lap of Endurance Test...')
    trackmap = 'Endurance_Track_1000.mat';
    FolderSection = [FolderName '\Endurance_Test'];
    SimName = {'Endurance_Test'};
    BoundaryConditions.vCar_start = [];
    BoundaryConditions.vCar_end = [];
    [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,Sweep,SaveResults,bUseAeromap);      
else
    SaveResults = 1;
    % Steady state solve for single track
    [Laptime, ~] = Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,Sweep,SaveResults,bUseAeromap);
end

