%% Run Sim Here
clear all
close all
clc

%% Save results location
<<<<<<< HEAD

SaveLocation = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP';

FolderName = '2_wheel_4_wheel';
SimName = {'Test'};

%% Trackmap

%trackmap = 'Racing_Line.mat';
%trackmap = 'Racing_Line_ClosedLoop.mat';
%trackmap = 'Racing_Line_ClosedLoop_2.mat';
trackmap = 'Trackmap_ClosedLoop.mat';
%trackmap = 'Acceleration_Track.mat';
%trackmap = 'SkidPad_Track.mat';
%trackmap = 'Full_FS_Weekend';

%% vCar boundary conditions
% Racing_Line_ClosedLoop 
BoundaryConditions.vCar_start = 33;
BoundaryConditions.vCar_end = 33;
% Acceleration_Track 
% BoundaryConditions.vCar_start = 0;
% BoundaryConditions.vCar_end = [];
% SkidPad_Track 
% BoundaryConditions.vCar_start = 12.8;
% BoundaryConditions.vCar_end = 12.8;


%% Sweep inputs (can only sweep car params OR car files OR weatherfile)
Sweep.Choose_Param = 1;                                % Choose whether to sweep anything or not
Sweep.Param = {'Car.Balance.xCoG'};             % Variable within car structure to be swept
Sweep.Values = 0.4:0.05:0.65;
Sweep.Choose_Carfile = 1;
Sweep.Carfile = {'C:\Users\Ila\Documents\GDP\IRG-EVX\Baseline_Carfile_Master','C:\Users\Ila\Documents\GDP\IRG-EVX\Baseline_Carfile_rwd'};
Sweep.Choose_Weatherfile = 0;
Sweep.Weatherfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Weatherfile.mat'};


%% Solver
% Choose one or the other!
Solver.Steady_state = 1;    % (Pre-sim only)
Solver.Dynamic_state = 0;   % (Includes steady state-solver in pre-sim)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Run sims
if strcmp(trackmap,'Full_FS_Weekend') == 1
    if Solver.Steady_state == 1
    	% Steady state solve for full FS weekend
        % Acceleration test
        disp('Simulating sweep of Acceleration Test...')
        trackmap = 'Acceleration_Track.mat';
        FolderSection = [FolderName '\Acceleration_Test'];
        SimName = {'Acceleration_Test'};
        BoundaryConditions.vCar_start = 0;
        BoundaryConditions.vCar_end = [];
        Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep)
        % Skid-pad test
        disp('Simulating sweep of Skid-Pad Test...')
        trackmap = 'SkidPad_Track.mat';
        FolderSection = [FolderName '\SkidPad_Test'];
        SimName = {'SkidPad_Test'};
        BoundaryConditions.vCar_start = 12.8;
        BoundaryConditions.vCar_end = 12.8;
        Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep)
        % Full lap (stationary start)
        disp('Simulating first lap of Endurance Test...')
        trackmap = 'Racing_Line_ClosedLoop.mat';
        FolderSection = [FolderName '\Endurance_Test\First_Lap'];
        SimName = {'Endurance_Test_First_Lap'};
        BoundaryConditions.vCar_start = 0;
        BoundaryConditions.vCar_end = [];
        Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep)
        % Full lap (steady state)
        disp('Simulating steady state lap of Endurance Test...')
        trackmap = 'Racing_Line_ClosedLoop.mat';
        FolderSection = [FolderName '\Endurance_Test\Steady_State'];
        SimName = {'Endurance_Test_Steady_State'};
        BoundaryConditions.vCar_start = 33;
        BoundaryConditions.vCar_end = 33;
        Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep)        
    else
        % Dynamic solve for full FS weekend
        
    end
else
    if Solver.Steady_state == 1
    	% Steady state solve for single track
        Steady_State_Sim(SaveLocation,FolderName,SimName,trackmap,BoundaryConditions,Sweep)
    else
        % Dynamic solve for single track
        
    end
end

