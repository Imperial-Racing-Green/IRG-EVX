% Plot ouptuts of a sweep
close all
clear
clc

FolderName = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP\Test';
listing = dir(FolderName);
listing = struct2table(listing);
listing(listing.isdir == 1,:) = [];
steady_state = 1;

filenames = {};
for i = 1:height(listing)
    filenames{i} = [listing.folder{i} '\' listing.name{i}];
    Results.(['Sim' num2str(i)]) = load(filenames{i});
end

figure('Name','vCar','NumberTitle','off');
if steady_state
   for i = 1:length(filenames)
        plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).vCar)
        hold on
    end 
else
    for i = 1:length(filenames)
        plot(Results.(['Sim' num2str(i)]).dist_log.Data,Results.(['Sim' num2str(i)]).vCar)
        hold on
    end
end
legend(listing.name)
xlabel('sLap (m)')
ylabel('vCar (m/s)')
grid minor

figure('Name','Downforce','NumberTitle','off');
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Aero.Downforce)
    hold on
end
legend(listing.name)
xlabel('sLap (m)')
ylabel('Total downforce (N)')
grid minor

figure('Name','Drag','NumberTitle','off');
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).sLap,Results.(['Sim' num2str(i)]).Force.Aero.Drag)
    hold on
end
legend(listing.name)
xlabel('sLap (m)')
ylabel('Total drag (N)')
grid minor

figure('Name','Engine thrust','NumberTitle','off');
for i = 1:length(filenames)
    T = Results.(['Sim' num2str(i)]).Force.Engine.Thrust.FL + ...
        Results.(['Sim' num2str(i)]).Force.Engine.Thrust.FR + ...
        Results.(['Sim' num2str(i)]).Force.Engine.Thrust.RL + ...
        Results.(['Sim' num2str(i)]).Force.Engine.Thrust.RR;
    plot(Results.(['Sim' num2str(i)]).sLap,T)
    hold on
end
legend(listing.name)
xlabel('sLap (m)')
ylabel('Total thrust (N)')
grid minor


figure('Name','Laptime sensitivity','NumberTitle','off');
for i = 1:length(filenames)
    sims(i) = i;
    laptimes(i) = Results.(['Sim' num2str(i)]).Laptime;
end
plot(sims,laptimes,'b-o','LineWidth',1.2)
hold on
xlabel('Sim number')
ylabel('Laptime (s)')
grid minor



