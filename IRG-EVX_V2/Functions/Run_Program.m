function Results = Run_Program(Files,Options,Plots)
% Runs simulation using selected files and options.
% William Foster - wjfoster@hotmail.co.uk - 2019

%% Folder Set-Up
% Add folders for Windows PC systems
if ispc == 1
    addpath([pwd '\Car Files'])
    addpath([pwd '\Environment Files'])
    addpath([pwd '\Track Files'])
    addpath([pwd '\Functions'])
    addpath([pwd '\Settings Files'])
end

% Add folders for MacOS systems
if ismac == 1
    addpath([pwd '/Car Files'])
    addpath([pwd '/Environment Files'])
    addpath([pwd '/Track Files'])
    addpath([pwd '/Functions'])
    addpath([pwd '/Settings Files'])
end

%% Load Files
Car = feval(Files.Car_File);

%% Quasi-static Simulation


%% Dynamic Simulation
Settings = Dynamic_Settings(Options);

simOut = sim('Dynamic_Simulation');

Results = 1;
end

