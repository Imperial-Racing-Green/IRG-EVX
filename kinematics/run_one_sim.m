clear
close all

hardpoint_files = {[pwd char("/kinematics/geometries/EV3 Front Hardpoints 13.01.19.mat")]
    [pwd char("/kinematics/geometries/Final Rear Outboard 01.02.19.mat")]};

% hardpoint_files = {[pwd char("/kinematics/geometries/Final Rear Outboard 01.02.19.mat")]};
%     
% hardpoints_front.tr.inner = [-1700.535, 259.37, 240.492];
% hardpoints_front.tr.outer = [-1616.96, 555.288, 242.011];
%  
% hardpoints_front.pr.inner = [-1450.02019254, 332.79367658, 409.22359437];
% hardpoints_front.pr.outer = [-1500, 508.9995, 129];
%  
% hardpoints_front.inboard.rocker_pivot = [-1430.2792, 280.80474504, 393.425];
% hardpoints_front.inboard.rocker_axis = [-1420.8986663+1430.27925115,...
%     284.24708875-280.80474504,...
%     393.81871066-393.42514026];
% 
% hardpoints_front.inboard.rocker_to_damper = [-1430.99641115, 257.29627671, 469.88975691];
% hardpoints_front.inboard.roll_damper_left = [-1500, 71.83, 504.31];
% hardpoints_front.inboard.damper_to_chassis = [-1387.94427501, 85.49560915, 437.77987995];

model_name = 'Kinematics_Sim';
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

figure
hold on

plot(sims{1}.channels.IC_roll_up(:,1),sims{1}.channels.IC_roll_up(:,2))
plot(sims{1}.channels.IC_roll_down(:,1),sims{1}.channels.IC_roll_down(:,2))
plot(sims{1}.channels.wheel_roll_up(:,1),sims{1}.channels.wheel_roll_up(:,2))
plot(sims{1}.channels.wheel_roll_down(:,1),sims{1}.channels.wheel_roll_down(:,2))
plot(sims{1}.channels.RCH_roll(:,1),sims{1}.channels.RCH_roll(:,2))

legend('IC\_roll\_up','IC\_roll\_down','wheel\_roll\_up','wheel\_roll\_down','RCH\_roll','location','northwest')
xlabel('Y [mm]')
ylabel('Z [mm]')

figure
hold on

plot(sims{2}.channels.IC_roll_up(:,1),sims{2}.channels.IC_roll_up(:,2))
plot(sims{2}.channels.IC_roll_down(:,1),sims{2}.channels.IC_roll_down(:,2))
plot(sims{2}.channels.wheel_roll_up(:,1),sims{2}.channels.wheel_roll_up(:,2))
plot(sims{2}.channels.wheel_roll_down(:,1),sims{2}.channels.wheel_roll_down(:,2))
plot(sims{2}.channels.RCH_roll(:,1),sims{2}.channels.RCH_roll(:,2))

legend('IC\_roll\_up','IC\_roll\_down','wheel\_roll\_up','wheel\_roll\_down','RCH\_roll','location','northwest')
xlabel('Y [mm]')
ylabel('Z [mm]')