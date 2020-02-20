% Plot ouptuts of a sweep
close all
clear
clc

FolderName = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Fomula Student\EV1 Sims\BrakeBias_Sweep';
full_weekend = 0;  % If selected point to folder of enclosing all weekend results

% Variable to plot on x-axis. Set 'bFindSweptVariable = 1' (optional)
bFindSweptVariable = 1; % Only set to 1 if its a single swept numeric values...
SweptParam = 'Car.Brakes.BrakeBias';
ParamName = 'BrakeBias';


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
        sim = listing.name{i};
        SimNames{i} = sim(1:end-4);
    end
%     if bFindSweptVariable
%         % Find swept paramater
%         id =  regexp(SimNames{1},'\d');
%         Param = SimNames{1};
%         Param = Param(1:id-1);
%     %     Param = regexprep(SimNames{1}, '\d[0-9_]+\d', '');
%         if strcmp(Param(end),'_')
%             Param = Param(1:end-1);
%         end
%         Param = strrep(Param,'_','.');
%         Param = strrep(Param,'SC.L','SC_L');
%         Param = strrep(Param,'SC.D','SC_D');
%         idx = strfind(Param,'.');
%         if ~isempty(idx)
%             SweptParam = Param(idx(end)+1:end);
%             SweptValues = zeros(1,length(SimNames));
%             for i = 1:length(SimNames)
%                 j = strfind(SimNames{i},SweptParam);
%                 sim = SimNames{i};
%                 SimNames{i} = sim(j:end);
%                 if any(strfind(Param,'CoGx')) || any(strfind(Param,'CoPx'))
%                     Param = strrep(Param,'x','(1)');
%                 elseif any(strfind(Param,'CoGy')) || any(strfind(Param,'CoPy'))
%                     Param = strrep(Param,'y','(2)');
%                 elseif any(strfind(Param,'CoGz')) || any(strfind(Param,'CoPz'))
%                     Param = strrep(Param,'z','(3)');
%                 else
%                     % Do nothing
%                 end
%                 SweptValues(i) = eval(['Results.' (Test{iTest}) '.' (['Sim' num2str(i)]) '.' Param]);
%             end
%         else
%             SweptParam = 'Sim';
%             SweptValues = 1:length(SimNames);
%         end
%     else
%         SweptParam = 'Sim';
%         SweptValues = 1:length(SimNames);
%     end    
    
    if bFindSweptVariable
        for i = 1:length(SimNames)
            SweptValues(i) = eval(['Results.' (Test{iTest}) '.' (['Sim' num2str(i)]) '.' SweptParam]);
            SimNames{i} = [ParamName '_' num2str(SweptValues(i))];
        end
    else
        SweptParam = 'Sim';
        SweptValues = 1:length(SimNames);
    end   
    
    SimViewer = figure('Name',Name{iTest},'NumberTitle','off');
    tabgp = uitabgroup(SimViewer,'Position',[0 0 1 1]);
    % Laptime sensitivity
    t = uitab(tabgp,'Title','Laptimes');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        sims(i) = i;
        laptimes(i) = Results.(Test{iTest}).(['Sim' num2str(i)]).Laptime;
    end
    plot(ax,sims,laptimes,'b-o','LineWidth',1.2)
    hold on
    xlabel(SweptParam)
    ylabel('Laptime (s)')
    grid minor
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    % Limits
    t = uitab(tabgp,'Title','Limits');
    for i = 1:length(filenames)
        sims(i) = i;
        pctPowerLimited(i) = (Results.(Test{iTest}).(['Sim' num2str(i)]).NVDACornerState.tState.PowerLimited/Results.(Test{iTest}).(['Sim' num2str(i)]).Laptime)*100;
        pctGripLimitedThrottle(i) = (Results.(Test{iTest}).(['Sim' num2str(i)]).NVDACornerState.tState.GripLimitedThrottle/Results.(Test{iTest}).(['Sim' num2str(i)]).Laptime)*100;
        pctGripLimitedBrake(i) = (Results.(Test{iTest}).(['Sim' num2str(i)]).NVDACornerState.tState.GripLimitedBrake/Results.(Test{iTest}).(['Sim' num2str(i)]).Laptime)*100;
        pctBrakeLimited(i) = (Results.(Test{iTest}).(['Sim' num2str(i)]).NVDACornerState.tState.BrakeLimited/Results.(Test{iTest}).(['Sim' num2str(i)]).Laptime)*100;
    end
    ax1 = axes(t,'Position',[0.11 0.55 0.35 0.35]);
    plot(sims,pctPowerLimited,'b-o','LineWidth',1)
    grid minor
    title('Power Limited')
    ylabel('Time (%)')
    xlabel(SweptParam)
    ax1.XTick = 1:length(filenames);
    ax1.XTickLabel = SweptValues;
    ax2 = axes(t,'Position',[0.55 0.55 0.35 0.35]);
    plot(sims,pctBrakeLimited,'b-o','LineWidth',1)
    grid minor
    title('Brake Limited')
    ylabel('Time (%)')
    xlabel(SweptParam)
    ax2.XTick = 1:length(filenames);
    ax2.XTickLabel = SweptValues;
    ax3 = axes(t,'Position',[0.12 0.08 0.35 0.35]);
    plot(sims,pctGripLimitedThrottle,'b-o','LineWidth',1)
    grid minor
    title('Grip Limited (Throttle)')
    ylabel('Time (%)')
    xlabel(SweptParam)
    ax3.XTick = 1:length(filenames);
    ax3.XTickLabel = SweptValues;
    ax4 = axes(t,'Position',[0.55 0.08 0.35 0.35]);
    plot(sims,pctGripLimitedBrake,'b-o','LineWidth',1)
    grid minor
    title('Grip Limited (Brake)')
    ylabel('Time (%)')
    xlabel(SweptParam)
    ax4.XTick = 1:length(filenames);
    ax4.XTickLabel = SweptValues;
    % vCar
    t = uitab(tabgp,'Title','vCar');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).vCar,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('vCar (m/s)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
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
    legend(SimNames,'Interpreter','none','AutoUpdate','off')
    xlabel('sLap (m)')
    ylabel('vCar (m/s)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    yyaxis right
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,tDiff(i,:),'LineWidth',1,'Color',col(i,:),'LineStyle','--','Marker','none')
        hold on
    end
    ylabel('tDiff')
    % Pedal inputs
    t = uitab(tabgp,'Title','Pedal inputs');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).rThrottle*100,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('rThrottle (%)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-5 105])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).rBrake*100,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('rBrake (%)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-5 105])
    % Steering    
    t = uitab(tabgp,'Title','Steering inputs');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).aSteeringWheel,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('aSteeringWheel (deg)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-180 180])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).aUOSteer,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('aUOSteer (deg)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])    
    % Engine inputs
    t = uitab(tabgp,'Title','Engine inputs');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).NGear,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('NGear')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-0.5 6.5])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).nEngine,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('nEngine (RPM)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Motor inputs
    t = uitab(tabgp,'Title','Motor inputs');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).pMotor/1000,'LineWidth',1)
        hold on
    end 
    plot([0, Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)],[80, 80],'r--','LineWidth',1)
    legend(SimNames,'Interpreter','none')
    ylabel('Power (kW) (per motor)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([0 85])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).nMotor,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('nMotor (RPM) (per motor)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Accelerations
    t = uitab(tabgp,'Title','Accelerations');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).gLat,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('gLat (g)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-3 3])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).gLong,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('gLong (g)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([-2.5 1.5])
    % G-G envelope
    t = uitab(tabgp,'Title','g-g Envelope');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        scatter(Results.(Test{iTest}).(['Sim' num2str(i)]).gLat,Results.(Test{iTest}).(['Sim' num2str(i)]).gLong,'filled')
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('gLat (g)')
    ylabel('gLong (g)')
    grid minor
    xlim([-3.5 3.5])
    ylim([-2.5 2])
    % Aero forces
    t = uitab(tabgp,'Title','Aero');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Aero.Drag,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('Drag (N)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Force.Aero.Downforce,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('Downforce (N)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Ride heights
    t = uitab(tabgp,'Title','Ride heights');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).hRideF*1000,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('hRideF (mm)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).hRideR*1000,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('hRideR (mm)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Tyre cambers
    t = uitab(tabgp,'Title','Camber angles');
    ax1 = axes(t,'Position',[0.1 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Camber.FL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FL')
    ylabel('Camber angle (deg)')
    ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Camber.FR,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('FR')
    ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Camber.RL,'LineWidth',1)
        hold on
    end
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    title('RL')
    ylabel('Camber angle (deg)')
    xlabel('sLap (m)')
    ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).Camber.RR,'LineWidth',1)
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
    % Grip
    t = uitab(tabgp,'Title','Grip');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        scatter([Results.(Test{iTest}).(['Sim' num2str(i)]).gLong;...
            Results.(Test{iTest}).(['Sim' num2str(i)]).gLong;...
            Results.(Test{iTest}).(['Sim' num2str(i)]).gLong;...
            Results.(Test{iTest}).(['Sim' num2str(i)]).gLong],...
            [abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.FL.mu_x);...
            abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.FR.mu_x);...
            abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.RL.mu_x);...
            abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.RR.mu_x)],10,'filled')
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('Grip mu_x')
    xlabel('gLong (g)')
    ylim([0 3])
    grid minor
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        scatter([Results.(Test{iTest}).(['Sim' num2str(i)]).gLat;...
            Results.(Test{iTest}).(['Sim' num2str(i)]).gLat;...
            Results.(Test{iTest}).(['Sim' num2str(i)]).gLat;...
            Results.(Test{iTest}).(['Sim' num2str(i)]).gLat],...
            [abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.FL.mu_y);...
            abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.FR.mu_y);...
            abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.RL.mu_y);...
            abs(Results.(Test{iTest}).(['Sim' num2str(i)]).Grip.RR.mu_y)],10,'filled')
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('Grip mu_y')
    xlabel('gLat (g)')
    grid minor
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
    % Two/Three wheeling
    t = uitab(tabgp,'Title','Two/Three Wheeling');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).vCar,'LineWidth',1)
        hold on
    end 
    ylabel('vCar (m/s)')
    for i = 1:length(filenames)
        yyaxis right
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).bThreeWheeling,'LineWidth',1)
        hold on
    end 
    ylabel('bThreeWheeling')
    ylim([-0.05 1.05]);
    legend(SimNames,'Interpreter','none')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).vCar,'LineWidth',1)
        hold on
    end
    ylabel('vCar (m/s)')
    for i = 1:length(filenames)
        yyaxis right
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).bTwoWheeling,'LineWidth',1)
        hold on
    end 
    ylabel('bTwoWheeling')
    ylim([-0.05 1.05]);
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Rotations
    t = uitab(tabgp,'Title','Rotations');
    ax1 = axes(t,'Position',[0.05 0.68 0.9 0.27]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).aPitch,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('aPitch (deg)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ax2 = axes(t,'Position',[0.05 0.38 0.9 0.27]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).aRollF,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('aRollF (deg)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ax3 = axes(t,'Position',[0.05 0.08 0.9 0.27]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).aRollR,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('aRollR (deg)')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    % Stability
    t = uitab(tabgp,'Title','Stability');
    ax1 = axes(t,'Position',[0.05 0.55 0.9 0.4]);
    for i = 1:length(filenames)
        scatter(1,Results.(Test{iTest}).(['Sim' num2str(i)]).Stability.Static.SM*100,'filled')
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('Static margin (%)')
    grid minor
    ax2 = axes(t,'Position',[0.05 0.08 0.9 0.4]);
    for i = 1:length(filenames)
        scatter(real(Results.(Test{iTest}).(['Sim' num2str(i)]).Stability.Dynamic.E_Values),imag(Results.(Test{iTest}).(['Sim' num2str(i)]).Stability.Dynamic.E_Values),'filled')
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    ylabel('Dynamic eigenvalues')
    grid minor
    % NVDA Corner States
    t = uitab(tabgp,'Title','NVDACornerState');
    ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
    for i = 1:length(filenames)
        plot(Results.(Test{iTest}).(['Sim' num2str(i)]).sLap,Results.(Test{iTest}).(['Sim' num2str(i)]).NVDACornerState.Timeseries,'LineWidth',1)
        hold on
    end 
    legend(SimNames,'Interpreter','none')
    xlabel('sLap (m)')
    ylabel('NVDACornerState')
    title('1 - PowerLimited ; 2 - GripLimitedThrottle ; 3 - GripLimitedBrake ; 4 - BrakeLimited')
    grid minor
    xlim([0 Results.(Test{iTest}).(['Sim' num2str(i)]).sLap(end)])
    ylim([0.5 4.5])
        
end

% Calculate scores
if full_weekend == 1
    for iTest = 1:length(FolderName)
        Sims = fieldnames(Results.(Test{iTest}));
        t = [];
        Co2 = [];
        for iSim = 1:length(sims)
            t(iSim) = Results.(Test{iTest}).(Sims{iSim}).Laptime;
            Co2(iSim) = Results.(Test{iTest}).(Sims{iSim}).CO2_Usage;
        end
        Times.(Test{iTest}).Sims = t;
        CO2_Usage.(Test{iTest}).Sims = Co2;
    end
    % Get best and worst results of 2016 (not 2018)
    % Acceleration test
    Times.Acceleration_Test.Best = 3.881; % 3.780;
    % Skid-Pad test
    Times.SkidPad_Test.Best =  4.729; % 4.735;
    % Endurance test
    Times.Endurance_Test.Best = 1271.04; %1427.580;
    % Autocross test
    Times.Autocross_Test.Best = 47.148; % 52.161;
    % Fuel Efficiency test
%     FuelEfficiency_Test.Best = 0.806;
%     FuelEfficiency_Test.Worst =  0.095;
    FuelEfficiency_Test.Worst = 0.139;
    FuelEfficiency_Test.Best = 0.791;
    lap_min = 57.775;
    CO2_min = 0.1169*22;
    % Calculate sim times for specific tests
    Times.Endurance_Test.Sims = (22*(Times.Endurance_Test.Sims)) + 180 + 1.5;
    % Calculate fuel efficiency  
    for iSim = 1:length(sims)
        if strcmp(Results.Endurance_Test.(Sims{iSim}).Car.Category,'Hybrid') | strcmp(Results.Endurance_Test.(Sims{iSim}).Car.Category,'ICE')
            mFuelPitstop = 180*5.2842e-5;
            vFuelPitstop = (mFuelPitstop/719.7) * 1000; % (litres)
            CO2_pitstop(i) = 2.31*vFuelPitstop;
        else
            CO2_pitstop(i) = 0;
        end
    end
    CO2_Usage_Total = (22*CO2_Usage.(Test{iTest}).Sims) + CO2_pitstop;
    FuelEfficiencyFactors = (lap_min./( (Times.Endurance_Test.Sims-180)/22)).*(CO2_min./CO2_Usage_Total);
    
    % Calculate other points
    Points.Sim = [1:length(FuelEfficiencyFactors)]';
    Points.Acceleration = (71.5 * ((((Times.Acceleration_Test.Best*1.5)./Times.Acceleration_Test.Sims)-1)/0.5))' + 3.5;
    Points.Acceleration(Points.Acceleration > 75) = 75;
%     Points.Skidpad = (46.5 * (((((Times.SkidPad_Test.Best*1.25)./Times.SkidPad_Test.Sims).^2)-1)/0.5625))' + 3.5;
    Points.Skidpad = (71.5 * (((((Times.SkidPad_Test.Best*1.25)./Times.SkidPad_Test.Sims).^2)-1)/0.5625))' + 3.5;
%     Points.Skidpad(Points.Skidpad > 50) = 50;
    Points.Skidpad(Points.Skidpad > 75) = 75;
%     Points.Autocross = (145.5 * ((((Times.Autocross_Test.Best*1.25)./Times.Autocross_Test.Sims)-1)/0.25))' + 4.5;
    Points.Autocross = (95.5 * ((((Times.Autocross_Test.Best*1.25)./Times.Autocross_Test.Sims)-1)/0.25))' + 4.5;
%     Points.Autocross(Points.Autocross > 150) = 150;
    Points.Autocross(Points.Autocross > 100) = 100;
%     Points.Endurance = (275 * ((((Times.Endurance_Test.Best*1.333)./Times.Endurance_Test.Sims)-1)/0.333))' + 25;
    Points.Endurance = (300 * ((((Times.Endurance_Test.Best*1.333)./Times.Endurance_Test.Sims)-1)/0.333))' + 25;
%     Points.Endurance(Points.Endurance > 300) = 300;
    Points.Endurance(Points.Endurance > 325) = 325;
    Points.Efficiency = (100 * (((FuelEfficiency_Test.Worst./FuelEfficiencyFactors) - 1) / ((FuelEfficiency_Test.Worst/FuelEfficiency_Test.Best) - 1)))';
    Points.Efficiency(Points.Efficiency > 100) = 100;
    Points.Total = Points.Acceleration + Points.Skidpad + Points.Autocross + Points.Endurance + Points.Efficiency;
    Points = struct2table(Points);
    
    Summary = figure('Name',' Events Summary','NumberTitle','off');
    tabgp = uitabgroup(Summary,'Position',[0 0 1 1]);
    t = uitab(tabgp,'Title','Times');
    axes('parent',t);
    subplot(2,3,1);
    plot(Times.Acceleration_Test.Sims,'b-o','LineWidth',1.2)
    title('Acceleration')
    ylabel('Time (s)')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,2)
    plot(Times.SkidPad_Test.Sims,'b-o','LineWidth',1.2)
    title('Skidpad')
    ylabel('Time (s)')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,3)
    plot(Times.Autocross_Test.Sims,'b-o','LineWidth',1.2)
    title('Autocross')
    ylabel('Tine (s)')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,4)
    plot(Times.Endurance_Test.Sims,'b-o','LineWidth',1.2)
    title('Endurance')
    ylabel('Time (s)')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,5)
    plot(CO2_Usage_Total,'b-o','LineWidth',1.2)
    title('Efficiency')
    ylabel('CO_{2} produced (kg)')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
        
    t = uitab(tabgp,'Title','Points');
    axes('parent',t);
    subplot(2,3,1)
    y = table2array(Points(:,2))';
    plot(y,'b-o','LineWidth',1.2)
    title('Acceleration (75pts)')
    ylabel('Points')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,2)
    y = table2array(Points(:,3))';
    plot(y,'b-o','LineWidth',1.2)
%     title('Skidpad (50pts)')
    title('Skidpad (75pts)')
    ylabel('Points')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,3)
    y = table2array(Points(:,4))';
    plot(y,'b-o','LineWidth',1.2)
%     title('Autocross (150pts)')
    title('Autocross (100pts)')
    ylabel('Points')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,4)
    y = table2array(Points(:,5))';
    plot(y,'b-o','LineWidth',1.2)
%     title('Endurance (300pts)')
    title('Endurance (325pts)')
    ylabel('Points')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,5)
    y = table2array(Points(:,6))';
    plot(y,'b-o','LineWidth',1.2)
    title('Efficiency (100 pts)')
    ylabel('Points')
    xlabel(SweptParam)
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
    grid on
    subplot(2,3,6)
    y = table2array(Points(:,7))';
    plot(y,'b-o','LineWidth',1.2)
    title('Total (675pts)')
    ylabel('Points')
    xlabel(SweptParam)
    grid on
    ax = gca;
    ax.XTick = 1:length(filenames);
    ax.XTickLabel = SweptValues;
end








