% This script carries out validation of the lapsim for many different
% carfiles of other teams with varying configurations (e.g
% aeropackages/powertrain assemblies)
close all
clear
clc

%% Save Results
SaveLocation = 'C:\Users\gregj\OneDrive\Documents\GitHub\GDP_2017_Lapsim';
FolderName = 'Validation';

%% Simulate each carfile and compare its simulated points to its total points
% carfiles = {'cata.mat', 'aachen.mat','West_Bohemia_16.mat','Paderborn_16.mat','Bath_16.mat',...
%     'Delft_15.mat','Stuttgart_16.mat','Bath_15.mat','CTU_Prague_16.mat','Karlsruhe_16.mat','Wroclaw_16.mat'};
% teams = {'Catalunya_16', 'Aachen_15','West_Bohemia_16','Paderborn_16','Bath_16','Delft_15',...
%     'Stuttgart_16','Bath_15','CTU_Prague_16','Karlsruhe_16','Wroclaw_16'};
carfiles = {'Bath_16.mat'};
teams = {'Bath_16'};
events = {'Acceleration', 'SkidPad', 'Autocross', 'Endurance', 'FuelEfficiency'};

Sweep.Choose_Carfile = 1;
Sweep.Carfile = carfiles;
Sweep.Choose_Param = 0;                                % Choose whether to sweep anything or not
Sweep.Param = {'Car.AeroPerformance.C_L'};             % Variable within car structure to be swept
Sweep.Values = [3 3.5];
Sweep.Choose_Weatherfile = 0;
Sweep.Weatherfile = {'C:\Users\gregj\OneDrive\Documents\GitHub\IRG-EVX\Baseline_Weatherfile.mat'};

for iCar = 1:length(carfiles)
    % Steady state solve for full FS weekend
    SaveResults = 0;
    Validation = 1;
    % Acceleration test
    disp('Simulating sweep of Acceleration Test...')
    trackmap = 'Acceleration_Track.mat';
    FolderSection = [FolderName '\Acceleration_Test'];
    SimName = {'Acceleration_Test'};
    BoundaryConditions.vCar_start = 0;
    BoundaryConditions.vCar_end = [];
    Laptime.Acceleration = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
    % Skid-pad test
    disp('Simulating sweep of Skid-Pad Test...')
    trackmap = 'SkidPad_Track.mat';
    FolderSection = [FolderName '\SkidPad_Test'];
    SimName = {'SkidPad_Test'};
    BoundaryConditions.vCar_start = 12.8;
    BoundaryConditions.vCar_end = [];
    Laptime.SkidPad = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation) / 2;
    % Full lap (stationary start)
    disp('Simulating first lap of Endurance Test...')
    trackmap = 'Trackmap_ClosedLoop.mat';
    FolderSection = [FolderName '\Endurance_Test\First_Lap'];
    SimName = {'Endurance_Test_First_Lap'};
    BoundaryConditions.vCar_start = 0;
    BoundaryConditions.vCar_end = [];
    Laptime.Autocross = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation);
    % Full lap (steady state)
    disp('Simulating steady state lap of Endurance Test...')
    trackmap = 'Trackmap_ClosedLoop.mat';
    FolderSection = [FolderName '\Endurance_Test\Steady_State'];
    SimName = {'Endurance_Test_Steady_State'};
    BoundaryConditions.vCar_start = 33;
    BoundaryConditions.vCar_end = 33;
    Laptime.FullLap = Steady_State_Sim(SaveLocation,FolderSection,SimName,trackmap,BoundaryConditions,Sweep,SaveResults,Validation); 
    Laptime.Endurance = Laptime.Autocross + (21*Laptime.FullLap)  + 180;   
%         PointsCalculator();
    for iEvent = 1:length(events)
        % Discard sim results in tests the car didn't run
        if car.points.(events{iEvent}) == 0
            Score.Sims.(teams{iCar}).(events{iEvent}) = 0;
        else
            Score.Sims.(teams{iCar}).(events{iEvent}) = Points.(events{iEvent});
        end
        Score.Real.(teams{iCar}).(events{iEvent}) = car.points.(events{iEvent});
    end
    Score.Sims.(teams{iCar}).Total = Score.Sims.(teams{iCar}).Acceleration + Score.Sims.(teams{iCar}).SkidPad +...
        Score.Sims.(teams{iCar}).Autocross + Score.Sims.(teams{iCar}).Endurance + Score.Sims.(teams{iCar}).FuelEfficiency;
    Score.Real.(teams{iCar}).Total = car.points.Total;
end
% Output points for each event
%% Acceleration
figure('Name','Acceleration points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Score.Sims.(teams{iTeam}).Acceleration,Score.Real.(teams{iTeam}).Acceleration,60,'filled')
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
    scatter(Score.Sims.(teams{iTeam}).SkidPad,Score.Real.(teams{iTeam}).SkidPad,60,'filled')
    hold on
end
plot([0 50],[0 50],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 50])
ylim([0 50])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% Autocross
figure('Name','Autocross points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Score.Sims.(teams{iTeam}).Autocross,Score.Real.(teams{iTeam}).Autocross,60,'filled')
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
    scatter(Score.Sims.(teams{iTeam}).Endurance,Score.Real.(teams{iTeam}).Endurance,60,'filled')
    hold on
end
plot([0 300],[0 300],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 300])
ylim([0 300])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')
%% FuelEfficiency
figure('Name','Fuel Efficiency points','numbertitle','off');
for iTeam = 1:length(teams)
    scatter(Score.Sims.(teams{iTeam}).FuelEfficiency,Score.Real.(teams{iTeam}).FuelEfficiency,60,'filled')
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
    scatter(Score.Sims.(teams{iTeam}).Total,Score.Real.(teams{iTeam}).Total,60,'filled')
    hold on
end
plot([0 675],[0 675],'k--','LineWidth',1.2)
legend([teams 'Trendline'],'interpreter','none','location','northwest')
xlim([0 675])
ylim([0 675])
grid on 
xlabel('Lapsim points predicted')
ylabel('Real points attained')