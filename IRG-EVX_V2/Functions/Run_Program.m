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
if strcmp(Options.Quasi_Static_Simulation,'On') == 1
    
end

%% Dynamic Simulation

if strcmp(Options.Dynamic_Simulation,'On') == 1
    Track = 1;
    Environment = 2;
    
    % SimOutputs = Run_Dynamic_Sim(Simulation,Car,Track,Environment,Options)
    SimOutputs = Run_Dynamic_Sim('Dynamic_Simulation',Car,Track,Environment,Options);
    
    Results = 1;
end

end

