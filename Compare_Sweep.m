% Plot ouptuts of a sweep
close all
clear
clc

FolderName = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP\Test1_CoG';
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

sim_number = [];
laptime = [];
if steady_state
    for i = 1:length(filenames)
        sim_number(i) = i;
        laptime(i) = Results.(['Sim' num2str(i)]).tLap(end);
    end
else
    for i = 1:length(filenames)
        sim_number(i) = i;
        laptime(i) = max(Results.(['Sim' num2str(i)]).dist_log.Time);
    end
end
figure('Name','Laptime sensitivity','NumberTitle','off');
plot(sim_number,laptime,'b-o','LineWidth',2)
xlabel('Sim number')
ylabel('Laptime (s)')
grid minor



