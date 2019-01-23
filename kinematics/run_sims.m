clear
close all
tic

model_name = 'Kinematics_Model';

hardpoints_base = load([pwd '/kinematics/geometries/Rear Opt1 14.01.19.mat']);
hardpoint2 = hardpoints_base.hardpoints_front;
hardpoint1 = [pwd '/kinematics/geometries/Rear Opt1 14.01.19.mat'];
% hardpoint2 = [pwd '/kinematics/geometries/Rear Opt2 14.01.19.mat'];
hardpoint3 = [pwd '/kinematics/geometries/Rear Opt3 14.01.19.mat'];

hardpoint2.uwb.front(3) = hardpoint2.uwb.front(3) + 32.23;

hardpoint_files = {hardpoint1,hardpoint2,hardpoint3};

sims = cell(length(hardpoint_files),1);
for i = 1:length(hardpoint_files)
    sims{i} = run_kine_sim(model_name,hardpoint_files{i});
end

for i = 1:length(hardpoint_files)
    disp(['Option ' num2str(i)])
    disp(['    Bump Travel: ' num2str(sims{i}.metrics.BumpTravel)])
    disp(['    Droop Travel: ' num2str(sims{i}.metrics.DroopTravel)])
    disp(['    Camber Gain: ' num2str(sims{i}.metrics.CamberGain_heave_coef(2))])
    disp(['    Static RCH: ' num2str(sims{i}.metrics.RCH_static)])
    disp(['    Static UWBO: ' num2str(sims{i}.position_output.uwb_z.data(sims{i}.metrics.static_idx))])
    disp(['    Static Anti-Squat: ' num2str(sims{i}.metrics.AntiSquat_static)])
    disp(['    Static SVIC (X,Y,Z): ' num2str(sims{i}.channels.SVIC(sims{i}.metrics.static_idx,:))])
end
toc