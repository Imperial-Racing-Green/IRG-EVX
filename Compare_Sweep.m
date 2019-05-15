% Sc
clear
clc

FolderName = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\CoG_Test';
listing = dir(FolderName);
listing = struct2table(listing);
listing(listing.isdir == 1,:) = [];

filenames = {};
for i = 1:height(listing)
    filenames{i} = [listing.folder{i} '\' listing.name{i}];
    Results.(['Sim' num2str(i)]) = load(filenames{i});
end

figure();
for i = 1:length(filenames)
    plot(Results.(['Sim' num2str(i)]).dist_log.Data,Results.(['Sim' num2str(i)]).vCar)
    hold on
end
legend(listing.name)
xlabel('sLap')
ylabel('vCar')
grid minor

sim_number = [];
laptime = [];
for i = 1:length(filenames)
    sim_number(i) = i;
    laptime(i) = max(Results.(['Sim' num2str(i)]).dist_log.Time);
end
figure();
plot(sim_number,laptime,'b-o','LineWidth',2)
xlabel('Sim')
ylabel('Laptime')
grid minor



