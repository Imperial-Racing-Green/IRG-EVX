%% Run Lap Simulation
% Script to set-up and run the IRG lap simulation.
% William Foster - wjfoster@hotmail.co.uk - 2019

%% Initialisation
clear all
close all
clc

%% User File Set-up
% Choose car, track and environment files for the simulation.
Files.Car_File = 'EV3_FSUK2019';
Files.Environment_File = 'Silverstone_Dry';
Files.Track_File = 'FSUK_Endurance_Test.csv'; %XXX.csv

%% User Simulation Options
% Set simulation options.
Options.Quasi_Static_Simulation = 'On'; %'On','Off'
Options.Dynamic_Simulation = 'On'; %'On','Off'
Options.Driving_Line_Optimisation = 'On'; %'On','Off'
Options.Driving_Line_Optimisation_Accuracy = 'Low'; %'Very High','High','Medium','Low','Very Low'
Options.Rolling_Start = 'Off'; %'On','Off'
Options.Reverse_Direction = 'Off'; %'On','Off'
Options.Show_Progress = 'On'; %'On','Off'
Options.Save_to_File = 'On'; %'On','Off'
Options.Debug_Mode = 'On'; %'On','Off'

%% User Plot Options
% Set which results to plot.
Plots.Optimisation_Progress = 'On'; %'On','Off'
Plots.Path_Velocity = 'On'; %'On','Off'
Plots.Velocity = 'On'; %'On','Off'
Plots.Pedal_Position = 'On'; %'On','Off'
Plots.Steering_Angle = 'On'; %'On','Off'

%% Run Simulation
Run = Option_Checks(Options,Plots);
Results = Run_Program(Files,Options,Plots,Run);

