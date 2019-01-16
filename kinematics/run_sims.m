clear
close all

model_name = 'Kinematics_Model';

hardpoint1 = [pwd '/kinematics/geometries/Rear Opt1 14.01.19.mat'];
hardpoint2 = [pwd '/kinematics/geometries/Rear Opt2 14.01.19.mat'];
hardpoint3 = [pwd '/kinematics/geometries/Rear Opt3 14.01.19.mat'];

hardpoint_files = {hardpoint1,hardpoint2,hardpoint3};

sims = cell(length(hardpoint_files),1);
for i = 1:length(hardpoint_files)
    sims{i} = run_kine_sim(model_name,hardpoint_files{i});
end

for i = 1:length(hardpoint_files)
    disp(['Option ' num2str(i)])
    disp([char("Bump Travel: ") num2str(sims{i}.metrics.BumpTravel)])
    disp(['Droop Travel: ' num2str(sims{i}.metrics.DroopTravel)])
end