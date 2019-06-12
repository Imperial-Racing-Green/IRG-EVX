% Plot ouptuts of a sweep
close all
clear

FolderName = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP\Power_Vs_Mass_250';
full_weekend = 1;  % If selected point to folder of encolsing all weekend results

%%%%%%%%%%%%%%%%%%%% END OF INPUTS %%%%%%%%%%%%%%%%%%%%

if full_weekend == 1
    FolderName = {[FolderName '\Acceleration_Test'], [FolderName '\SkidPad_Test'],...
        [FolderName '\Autocross_Test'], [FolderName '\Endurance_Test']};
    Name = {'Sim Viewer: Acceleration Test', 'Sim Viewer: Skid-Pad Test',...
        'Sim Viewer: Autocross Test', 'Sim Viewer: Endurance Test'};
    Test = {'Acceleration_Test', 'SkidPad_Test', 'Autocross_Test', 'Endurance_Test'};
else
    FolderName = {FolderName};
    Name = {'Sim Viewer'};
    Test = {'Test'};
end

for iTest = 1:length(FolderName)
    
    listing = dir(FolderName{iTest});
    listing = struct2table(listing);
    listing = sortrows(listing,'date');
    listing(listing.isdir == 1,:) = [];

    filenames = {};
    for i = 1:height(listing)
        filenames{i} = [listing.folder{i} '\' listing.name{i}];
        Results.(Test{iTest}).(['Sim' num2str(i)]) = load(filenames{i});
    end

    SimViewer = figure('Name',Name{iTest},'NumberTitle','off');
    tabgp = uitabgroup(SimViewer,'Position',[0 0 1 1]);
    % Laptime sensitivity
    t = uitab(tabgp,'Title','Laptime sensitivity');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        sims(i) = i;
        laptimes(i) = Results.(Test{iTest}).(['Sim' num2str(i)]).Laptime;
    end
    plot(ax,sims,laptimes,'b-o','LineWidth',1.2)
    hold on
    xlabel('Sim number')
    ylabel('Laptime (s)')
    grid minor
    % vCar
    t = uitab(tabgp,'Title','vCar');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).vCar,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('vCar (m/s)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([0 45])
    % tDiff
    t = uitab(tabgp,'Title','tDiff');
    ax = axes(t,'Position',[0.1 0.12 0.8 0.85]);
    fastest_sim = find(laptimes == min(laptimes));
    fastest_sim = fastest_sim(1);
    tDiff = [];
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).vCar,'LineWidth',1)
        hold on
        tDiff(i,:) = Results.(Test{iTest}).(['Sim' num2str(i)]).tLap - Results.(Test{iTest}).(['Sim' num2str(fastest_sim)]).tLap;
        temp = gca;
        col(i,:) = temp.Children(1).Color;
    end
    legend(listing.name,'AutoUpdate','off')
    xlabel('sLap (m)')
    ylabel('vCar (m/s)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([0 45])
    yyaxis right
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,tDiff(i,:),'LineWidth',1,'Color',col(i,:),'LineStyle','--','Marker','none')
        hold on
    end
    ylabel('tDiff')
    % rThrottle
    t = uitab(tabgp,'Title','rThrottle');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).rThrottle*100,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('rThrottle (%)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-5 105])
    % rBrake
    t = uitab(tabgp,'Title','rBrake');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).rBrake*100,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('rBrake (%)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-5 105])
    % gLat
    t = uitab(tabgp,'Title','gLat');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).gLat,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('gLat (g)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-4.5 4.5])
    % gLong
    t = uitab(tabgp,'Title','gLong');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).gLong,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('gLong (g)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-2.5 2])
    % Drag
    t = uitab(tabgp,'Title','Drag');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Aero.Drag,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('Drag (N)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Downforce
    t = uitab(tabgp,'Title','Downforce');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Aero.Downforce,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('Downforce (N)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Powertrain Thrust
    t = uitab(tabgp,'Title','Engine Thrust');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Powertrain.Thrust.Total,'LineWidth',1)
        hold on
    end 
    legend(listing.name)
    xlabel('sLap (m)')
    ylabel('Total Thrust (N)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Tyre Fx
    t = uitab(tabgp,'Title','Tyre Fx');
    ax1 = axes(t,'Position',[0.1 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fx.FL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FL')
    ylabel('Force (N)')
    ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fx.FR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FR')
    ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fx.RL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RL')
    ylabel('Force (N)')
    xlabel('sLap (m)')
    ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fx.RR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RR')
    xlabel('sLap (m)')
    yl1 = ax1.YLim;    yl2 = ax2.YLim;    yl3 = ax4.YLim;    yl4 = ax4.YLim;
    ymin = min([yl1(1) yl2(1) yl3(1) yl4(1)]);
    ymax = max([yl1(2) yl2(2) yl3(2) yl4(2)]);
    ax1.YLim = [ymin ymax];    ax2.YLim = [ymin ymax];    ax3.YLim = [ymin ymax];    ax4.YLim = [ymin ymax];
    % Tyre Fy
    t = uitab(tabgp,'Title','Tyre Fy');
    ax1 = axes(t,'Position',[0.1 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fy.FL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FL')
    ylabel('Force (N)')
    ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fy.FR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FR')
    ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fy.RL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RL')
    ylabel('Force (N)')
    xlabel('sLap (m)')
    ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fy.RR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RR')
    xlabel('sLap (m)')
    yl1 = ax1.YLim;    yl2 = ax2.YLim;    yl3 = ax4.YLim;    yl4 = ax4.YLim;
    ymin = min([yl1(1) yl2(1) yl3(1) yl4(1)]);
    ymax = max([yl1(2) yl2(2) yl3(2) yl4(2)]);
    ax1.YLim = [ymin ymax];    ax2.YLim = [ymin ymax];    ax3.YLim = [ymin ymax];    ax4.YLim = [ymin ymax];
    % Tyre Fz
    t = uitab(tabgp,'Title','Tyre Fz');
    ax1 = axes(t,'Position',[0.1 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fz.FL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FL')
    ylabel('Force (N)')
    ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fz.FR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FR')
    ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fz.RL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RL')
    ylabel('Force (N)')
    xlabel('sLap (m)')
    ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Wheel.Fz.RR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RR')
    xlabel('sLap (m)')
    yl1 = ax1.YLim;    yl2 = ax2.YLim;    yl3 = ax4.YLim;    yl4 = ax4.YLim;
    ymin = min([yl1(1) yl2(1) yl3(1) yl4(1)]);
    ymax = max([yl1(2) yl2(2) yl3(2) yl4(2)]);
    ax1.YLim = [ymin ymax];    ax2.YLim = [ymin ymax];    ax3.YLim = [ymin ymax];    ax4.YLim = [ymin ymax];

end

% Calculate scores
if full_weekend == 1
    for iTest = 1:length(FolderName)
        Sims = fieldnames(Results.(Test{iTest}));
        t = [];
        Co2 = [];
        for iSim = 1:length(sims)
            t(iSim) = Results.(Test{iTest}).(Sims{iSim}).Laptime;
            Co2(iSim) = sum(Results.(Test{iTest}).(Sims{iSim}).CO2_Usage)/length(Results.(Test{iTest}).(Sims{iSim}).CO2_Usage);
        end
        Times.(Test{iTest}).Sims = t;
        CO2_Usage.(Test{iTest}).Sims = Co2;
    end
    % Get best and worst results of 2016 (not 2018)
    % Acceleration test
    Times.Acceleration_Test.Best = 3.881; % 3.780; 3.881;
    % Skid-Pad test
    Times.SkidPad_Test.Best = 4.729; % 4.735;  4.729; 
    % Endurance test
    Times.Endurance_Test.Best = 1427.580; % 1271.04; 1427.580; 
    % Autocross test
    Times.Autocross_Test.Best = 52.161; % 47.148; 52.161;
    % Fuel Efficiency test
%     FuelEfficiency_Test.Best = 0.806;
%     FuelEfficiency_Test.Worst =  0.095;
    FuelEfficiency_Test.Worst = 0.139;
    FuelEfficiency_Test.Best = 0.791;
    lap_min = 57.775;
    CO2_min = 0.1169*22;
    % Calculate sim times for specific tests
    Times.SkidPad_Test.Sims = Times.SkidPad_Test.Sims; 
    Times.Endurance_Test.Sims = (22*(Times.Endurance_Test.Sims)) + 180 + 1.5;
    Times.Autocross_Test.Sims = Times.Autocross_Test.Sims;
    % Calculate fuel efficiency    
    mFuelPitstop = 180*5.2842e-5;
    vFuelPitstop = (mFuelPitstop/719.7) * 1000; % (litres)
    CO2_pitstop = 2.31*vFuelPitstop;
    CO2_Usage_Total = (22*CO2_Usage.(Test{iTest}).Sims) + CO2_pitstop;
    FuelEfficiencyFactors = (lap_min./( Times.Endurance_Test.Sims/22)).*(CO2_min./CO2_Usage_Total);
    
    % Calculate other points
    Points.Sim = [1:length(FuelEfficiencyFactors)]';
    Points.Acceleration_2018 = (71.5 * ((((Times.Acceleration_Test.Best*1.5)./Times.Acceleration_Test.Sims)-1)/0.5))' + 3.5;
    Points.Acceleration_2018(Points.Acceleration_2018 > 75) = 75;
    Points.Acceleration_2019 = (71.5 * ((((Times.Acceleration_Test.Best*1.5)./Times.Acceleration_Test.Sims)-1)/0.5))' + 3.5;
    Points.Acceleration_2019(Points.Acceleration_2019 > 75) = 75;
    Points.Skidpad_2018 = (46.5 * (((((Times.SkidPad_Test.Best*1.25)./Times.SkidPad_Test.Sims).^2)-1)/0.5625))' + 3.5;
    Points.Skidpad_2019 = (71.5 * (((((Times.SkidPad_Test.Best*1.25)./Times.SkidPad_Test.Sims).^2)-1)/0.5625))' + 3.5;
    Points.Skidpad_2018(Points.Skidpad_2018 > 50) = 50;
    Points.Skidpad_2019(Points.Skidpad_2019 > 75) = 75;
    Points.Autocross_2018 = (145.5 * ((((Times.Autocross_Test.Best*1.25)./Times.Autocross_Test.Sims)-1)/0.25))' + 4.5;
    Points.Autocross_2019 = (95.5 * ((((Times.Autocross_Test.Best*1.25)./Times.Autocross_Test.Sims)-1)/0.25))' + 4.5;
    Points.Autocross_2018(Points.Autocross_2018 > 150) = 150;
    Points.Autocross_2019(Points.Autocross_2019 > 100) = 100;
    Points.Endurance_2018 = (275 * ((((Times.Endurance_Test.Best*1.333)./Times.Endurance_Test.Sims)-1)/0.333))' + 25;
    Points.Endurance_2019 = (300 * ((((Times.Endurance_Test.Best*1.333)./Times.Endurance_Test.Sims)-1)/0.333))' + 25;
    Points.Endurance_2018(Points.Endurance_2018 > 300) = 300;
    Points.Endurance_2019(Points.Endurance_2019 > 325) = 325;
    Points.Efficiency_2018 = (100 * (((FuelEfficiency_Test.Worst./FuelEfficiencyFactors) - 1) / ((FuelEfficiency_Test.Worst/FuelEfficiency_Test.Best) - 1)))';
    Points.Efficiency_2018(Points.Efficiency_2018 > 100) = 100;
    Points.Efficiency_2019 = (100 * (((FuelEfficiency_Test.Worst./FuelEfficiencyFactors) - 1) / ((FuelEfficiency_Test.Worst/FuelEfficiency_Test.Best) - 1)))';
    Points.Efficiency_2019(Points.Efficiency_2019 > 100) = 100;
    Points.Total_2018 = Points.Acceleration_2018 + Points.Skidpad_2018 + Points.Autocross_2018 + Points.Endurance_2018 + Points.Efficiency_2018;
    Points.Total_2019 = Points.Acceleration_2019 + Points.Skidpad_2019 + Points.Autocross_2019 + Points.Endurance_2019 + Points.Efficiency_2019;
    Points = struct2table(Points);
    figure()
    subplot(2,3,1)
    y = table2array(Points(:,3))';
    plot(y,'b-o','LineWidth',1.2)
    title('Acceleration (75pts)')
    ylabel('Points')
    xlabel('Sim')
    grid on
    subplot(2,3,2)
    y = table2array(Points(:,5))';
    plot(y,'b-o','LineWidth',1.2)
%     title('Skidpad (50pts)')
    title('Skidpad (75pts)')
    ylabel('Points')
    xlabel('Sim')
    grid on
    subplot(2,3,3)
    y = table2array(Points(:,7))';
    plot(y,'b-o','LineWidth',1.2)
%     title('Autocross (150pts)')
    title('Autocross (100pts)')
    ylabel('Points')
    xlabel('Sim')
    grid on
    subplot(2,3,4)
    y = table2array(Points(:,9))';
    plot(y,'b-o','LineWidth',1.2)
%     title('Endurance (300pts)')
    title('Endurance (325pts)')
    ylabel('Points')
    xlabel('Sim')
    grid on
    subplot(2,3,5)
    y = table2array(Points(:,11))';
    plot(y,'b-o','LineWidth',1.2)
    title('Efficiency (100 pts)')
    ylabel('Points')
    xlabel('Sim')
    grid on
    subplot(2,3,6)
    y = table2array(Points(:,13))';
    plot(y,'b-o','LineWidth',1.2)
    title('Total (675pts)')
    ylabel('Points')
    xlabel('Sim')
    grid on

end








