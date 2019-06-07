% This script carries out validation of the lapsim for many different
% carfiles of other teams with varying configurations (e.g
% aeropackages/powertrain assemblies)
close all
clear
clc

SaveCarfiles();

%% Save Results
SaveLocation = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP';
FolderName = 'Validation';

%% Simulate each carfile and compare its simulated points to its total points
% carfiles = {'cata.mat', 'aachen.mat','West_Bohemia_16.mat','Paderborn_16.mat','Bath_16.mat',...
%     'Delft_15.mat','Stuttgart_16.mat','Bath_15.mat','CTU_Prague_16.mat','Karlsruhe_16.mat','Wroclaw_16.mat'};
% teams = {'Catalunya_16', 'Aachen_15','West_Bohemia_16','Paderborn_16','Bath_16','Delft_15',...
%     'Stuttgart_16','Bath_15','CTU_Prague_16','Karlsruhe_16','Wroclaw_16'};

carfiles = {'Stuttgart_16_V2.mat'};
teams = {'Stuttgart_16'};

% Cars we know work!
% carfiles = {'Delft_15.mat','Bath_15.mat','aachen.mat','Stuttgart_16.mat','cata.mat','Bath_16.mat',...
%             'CTU_Prague_16.mat','Karlsruhe_16.mat','Wroclaw_16.mat','Paderborn_16.mat','Bath_18.mat'};
% teams = {'Delft_15','Bath_15','Aachen_15','Stuttgart_16','Catalunya_16','Bath_16',...
%         'CTU_Prague_16','Karlsruhe_16','Wroclaw_16','Paderborn_16','Bath_18'};


events = {'Acceleration', 'SkidPad', 'Autocross', 'Endurance', 'FuelEfficiency'};

Sweep.Choose_Carfile = 1;
Sweep.Choose_Param = 0;                                % Choose whether to sweep anything or not
Sweep.Param = {'Car.AeroPerformance.C_L'};             % Variable within car structure to be swept
Sweep.Values = [3 3.5];
Sweep.Choose_Weatherfile = 0;
Sweep.Weatherfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Weatherfile.mat'};

for iCar = 1:length(carfiles)
    Sweep.Carfile = carfiles(iCar);
    % Steady state solve for full FS weekend
    SaveResults = 0;
    Validation = 1;
    % Acceleration test
    disp('Simulating Acceleration Test...')
    trackmap = 'Acceleration_Track.mat';
    FolderSection = [FolderName '\Acceleration_Test'];
    SimName = {'Acceleration_Test'};
    BoundaryConditions.vCar_start = 0;
    BoundaryConditions.vCar_end = [];
    [Laptimes.Acceleration, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
    % Skid-pad test
    disp('Simulating Skid-Pad Test...')
    trackmap = 'SkidPad_Track_new.mat';
    FolderSection = [FolderName '\SkidPad_Test'];
    SimName = {'SkidPad_Test'};
    BoundaryConditions.vCar_start = 12.8;
    BoundaryConditions.vCar_end = [];
    [Laptimes.SkidPad, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
    Laptimes.SkidPad = Laptimes.SkidPad;    
    % Full lap (stationary start)

    load(carfiles{iCar});
    disp('Simulating Autocross Test...')
    if strcmp(Car.Year,'2015') == 1 || strcmp(Car.Year,'2016') == 1 || strcmp(Car.Year,'2017') == 1
        trackmap = 'Autocross_Track_2.mat';
    else % 2018
        trackmap = 'Autocross_Track_2018.mat';
    end
    FolderSection = [FolderName '\Autocross_Test'];
    SimName = {'Autocross_Test'};
    BoundaryConditions.vCar_start = 0;
    BoundaryConditions.vCar_end = [];
    [Laptimes.Autocross, ~] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
    % Full lap (steady state)
    disp('Simulating steady state lap of Endurance Test...')
    trackmap = 'Endurance_Track_1400.mat';
    FolderSection = [FolderName '\Endurance_Test\Steady_State'];
    SimName = {'Endurance_Test_Steady_State'};
    BoundaryConditions.vCar_start = 26;
    BoundaryConditions.vCar_end = 26;
    [Laptimes.FullLap, CO2_Usage.FullLap] = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation); 
    Laptimes.Endurance = (22*Laptimes.FullLap) + 180 + 1.5; % Pitstop + stationary start

    Points.Sims.(teams{iCar}) = PointsCalculator(Laptimes,carfiles{iCar},CO2_Usage);
    
    load(carfiles{iCar});
    Points.Real.(teams{iCar}).Acceleration = Car.Points.Acceleration;
    Points.Real.(teams{iCar}).SkidPad = Car.Points.SkidPad;
    Points.Real.(teams{iCar}).Autocross = Car.Points.Autocross;
    Points.Real.(teams{iCar}).Endurance  = Car.Points.Endurance;
    Points.Real.(teams{iCar}).FuelEfficiency = Car.Points.FuelEfficiency;
    Points.Real.(teams{iCar}).Total = Car.Points.Total;
    for iEvent = 1:length(events)
        % Discard sim results in tests the car didn't run
        if Car.Points.(events{iEvent}) == 0
            Points.Sims.(teams{iCar}).(events{iEvent}) = 0;

        end
    end
    Points.Sims.(teams{iCar}).Total = Points.Sims.(teams{iCar}).Acceleration + Points.Sims.(teams{iCar}).SkidPad +...
        Points.Sims.(teams{iCar}).Autocross + Points.Sims.(teams{iCar}).Endurance + Points.Sims.(teams{iCar}).FuelEfficiency;
end
% Output points for each event
%% Acceleration
figure('Name','Acceleration points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Points.Sims.(teams{iTeam}).Acceleration,Points.Real.(teams{iTeam}).Acceleration,60,'filled')
    hold on
end
plot([0 75],[0 75],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 75])
ylim([0 75])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% Skidpad
figure('Name','Skidpad points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Points.Sims.(teams{iTeam}).SkidPad,Points.Real.(teams{iTeam}).SkidPad,60,'filled')
    hold on
end
plot([0 75],[0 75],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 75])
ylim([0 75])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% Autocross
figure('Name','Autocross points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Points.Sims.(teams{iTeam}).Autocross,Points.Real.(teams{iTeam}).Autocross,60,'filled')
    hold on
end
plot([0 150],[0 150],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 150])
ylim([0 150])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% Endurance
figure('Name','Endurance points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Points.Sims.(teams{iTeam}).Endurance,Points.Real.(teams{iTeam}).Endurance,60,'filled')
    hold on
end
plot([0 325],[0 325],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 325])
ylim([0 325])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% FuelEfficiency
figure('Name','Fuel Efficiency points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Points.Sims.(teams{iTeam}).FuelEfficiency,Points.Real.(teams{iTeam}).FuelEfficiency,60,'filled')
    hold on
end
plot([0 100],[0 100],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 100])
ylim([0 100])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% Total
figure('Name','Total points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Points.Sims.(teams{iTeam}).Total,Points.Real.(teams{iTeam}).Total,60,'filled')
    hold on
end
plot([0 675],[0 675],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 675])
ylim([0 675])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')