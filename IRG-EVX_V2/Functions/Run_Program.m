function Results = Run_Program(Files,Options,Plots,Run)
% Runs simulation using selected files and options.
% William Foster - wjfoster@hotmail.co.uk - 2019

%% Folder Set-Up
% Add folders for Windows PC systems
if ispc == 1
    addpath([pwd '\Car Files'])
    addpath([pwd '\Environment Files'])
    addpath([pwd '\Track Files'])
    addpath([pwd '\Functions'])
end

% Add folders for MacOS systems
if ismac == 1
    addpath([pwd '/Car Files'])
    addpath([pwd '/Environment Files'])
    addpath([pwd '/Track Files'])
    addpath([pwd '/Functions'])
end

%% Check if okay to Run
if Run == 0
    Results = [];
    return
end

%% Load Files
Car = feval(Files.Car_File);
Environment = feval(Files.Environment_File);
Track = Track_Gen(Files.Track_File,Car,Options);

figure
hold on
axis equal
plot(Track.x_right,Track.y_right,'k-')
plot(Track.x_left,Track.y_left,'k-')
plot(Track.Path.x_right,Track.Path.y_right,'b--')
plot(Track.Path.x_left,Track.Path.y_left,'b--')
plot(Track.Path.x,Track.Path.y,'b-')
plot(Track.Path.x,Track.Path.y,'r-')

%% Quasi-static Simulation
if strcmpi(Options.Quasi_Static_Simulation,'On') == 1
    Results.Quasi = Run_Quasi_Sim(Car,Environment,Track,Options);
end

%% Dynamic Simulation

if strcmpi(Options.Dynamic_Simulation,'On') == 1
    Environment.g = -9.81;
    
    % SimOutputs = Run_Dynamic_Sim(Simulation,Car,Track,Environment,Options)
    SimSettings = Dynamic_Sim_Settings(Options);
    Results.Dynamic = Run_Dynamic_Sim('Dynamic_Simulation',Car,Track,Environment,Options,SimSettings);

    Results = 1;
end

end

