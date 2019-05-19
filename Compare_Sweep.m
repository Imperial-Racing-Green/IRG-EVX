% Plot ouptuts of a sweep
close all
clear
clc

FolderName = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\Mass_Sweep';

%%%%%%%%%%%%%%%%%%%% END OF INPUTS %%%%%%%%%%%%%%%%%%%%

listing = dir(FolderName);
listing = struct2table(listing);
listing(listing.isdir == 1,:) = [];


filenames = {};
for i = 1:height(listing)
    filenames{i} = [listing.folder{i} '\' listing.name{i}];
    Results.(['Sim' num2str(i)]) = load(filenames{i});
end

SimViewer = figure('Name','Sim Viewer','NumberTitle','off');
tabgp = uitabgroup(SimViewer,'Position',[0 0 1 1]);
% Laptime sensitivity
t = uitab(tabgp,'Title','Laptime sensitivity');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    sims(i) = i;
    laptimes(i) = Results.(['Sim' num2str(i)]).Laptime;
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
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).vCar,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('vCar (m/s)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
ylim([0 45])
% tDiff
t = uitab(tabgp,'Title','tDiff');
ax = axes(t,'Position',[0.1 0.12 0.8 0.85]);
fastest_sim = find(laptimes == min(laptimes));
fastest_sim = fastest_sim(1);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).vCar,'LineWidth',1)
    hold on
    tDiff(i,:) = Results.(['Sim' num2str(i)]).tLap - Results.(['Sim' num2str(fastest_sim)]).tLap;
    temp = gca;
    col(i,:) = temp.Children(1).Color;
end
legend(listing.name,'AutoUpdate','off')
xlabel('sLap (m)')
ylabel('vCar (m/s)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
ylim([0 45])
yyaxis right
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,tDiff(i,:),'LineWidth',1,'Color',col(i,:),'LineStyle','--','Marker','none')
    hold on
end
ylabel('tDiff')
% rThrottle
t = uitab(tabgp,'Title','rThrottle');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).rThrottle*100,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('rThrottle (%)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
ylim([-5 105])
% rBrake
t = uitab(tabgp,'Title','rBrake');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).rBrake*100,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('rBrake (%)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
ylim([-5 105])
% gLat
t = uitab(tabgp,'Title','gLat');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).gLat,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('gLat (g)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
ylim([-4.5 4.5])
% gLong
t = uitab(tabgp,'Title','gLong');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).gLong,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('gLong (g)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
ylim([-21 2])
% Drag
t = uitab(tabgp,'Title','Drag');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Aero.Drag,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('Drag (N)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
% Downforce
t = uitab(tabgp,'Title','Downforce');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Aero.Downforce,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('Downforce (N)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
% Engine Thrust
t = uitab(tabgp,'Title','Engine Thrust');
ax = axes(t,'Position',[0.1 0.12 0.85 0.85]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Engine.Thrust.Total,'LineWidth',1)
    hold on
end 
legend(listing.name)
xlabel('sLap (m)')
ylabel('Total Thrust (N)')
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
% Tyre Fx
t = uitab(tabgp,'Title','Tyre Fx');
ax1 = axes(t,'Position',[0.1 0.55 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fx.FL,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('FL')
ylabel('Force (N)')
ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fx.FR,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('FR')
ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fx.RL,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('RL')
ylabel('Force (N)')
xlabel('sLap (m)')
ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fx.RR,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
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
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fy.FL,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('FL')
ylabel('Force (N)')
ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fy.FR,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('FR')
ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fy.RL,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('RL')
ylabel('Force (N)')
xlabel('sLap (m)')
ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fy.RR,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
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
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fz.FL,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('FL')
ylabel('Force (N)')
ax2 = axes(t,'Position',[0.55 0.55 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fz.FR,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('FR')
ax3 = axes(t,'Position',[0.1 0.08 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fz.RL,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('RL')
ylabel('Force (N)')
xlabel('sLap (m)')
ax4 = axes(t,'Position',[0.55 0.08 0.4 0.4]);
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Wheel.Fz.RR,'LineWidth',1)
    hold on
end
grid minor
xlim([0 Results.(['Sim' num2str(i)]).sLap(end)])
title('RR')
xlabel('sLap (m)')
yl1 = ax1.YLim;    yl2 = ax2.YLim;    yl3 = ax4.YLim;    yl4 = ax4.YLim;
ymin = min([yl1(1) yl2(1) yl3(1) yl4(1)]);
ymax = max([yl1(2) yl2(2) yl3(2) yl4(2)]);
ax1.YLim = [ymin ymax];    ax2.YLim = [ymin ymax];    ax3.YLim = [ymin ymax];    ax4.YLim = [ymin ymax];






