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
Files.Track_File = 'FSUK_Sprint';
Files.Environment_File = 'Silverstone_Dry';

%% User Simulation Options
% Set simulation options to 'On' or 'Off'.
Options.Quasi_Static_Simulation = 'On';
Options.Dynamic_Simulation = 'On';
Options.Driving_Line_Optimisation = 'On';
Options.Rolling_Start = 'On';
Options.Show_Progress = 'On';
Options.Save_to_File = 'On';
Options.Debug_Mode = 'On';

%% User Plot Options
% Set which results to plot using 'On' or 'Off'.
Plots.Optimisation_Progress = 'On';
Plots.Path_Velocity = 'On';
Plots.Velocity = 'On';
Plots.Pedal_Position = 'On';
Plots.Steering_Angle = 'On';

%% Run Simulation
Results = Run_Program(Files,Options,Plots);