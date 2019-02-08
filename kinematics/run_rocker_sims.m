clear
close all

load([pwd char("/kinematics/geometries/Final Rear Outboard 01.02.19.mat")])

hardpoints_front.tr.inner = [-1700.535, 259.37, 240.492];
hardpoints_front.tr.outer = [-1616.96, 555.288, 242.011];

hardpoints_front.pr.inner = [-1450.02019254, 332.79367658, 409.22359437];
hardpoints_front.pr.outer = [-1500, 508.9995, 179];

hardpoints_front.inboard.rocker_pivot = [-1430.2792, 280.80474504, 393.425];
% hardpoints_front.inboard.rocker_axis = [-1420.8986663+1430.27925115,...
%     284.24708875-280.80474504,...
%     393.81871066-393.42514026];
hardpoints_front.inboard.rocker_axis = [-1420.88075954, 284.0440638, 394.50919258] -...
    hardpoints_front.inboard.rocker_pivot;
% hardpoints_front.inboard.rocker_to_damper = [-1416.658, 265.09, 470.67];
hardpoints_front.inboard.rocker_to_damper = [-1430.99641115, 257.29627671, 469.88975691];
hardpoints_front.inboard.roll_damper_left = [-1500, 71.83, 504.31];
hardpoints_front.inboard.damper_to_chassis = [-1369.5314339, 95.42463989, 420.7000246];

% hardpoints_front.tr.inner = [-1700.535, 259.37, 240.492];
% hardpoints_front.tr.outer = [-1616.96, 555.288, 242.011];
% 
% hardpoints_front.pr.inner = [-1427.5505, 359.247, 408.900];
% hardpoints_front.pr.outer = [-1500, 508.9995, 135];
% 
% hardpoints_front.inboard.rocker_pivot = [-1430.2792, 265.09, 393.425];
% hardpoints_front.inboard.rocker_axis = [-1417.47675036--1443.08175194,...
%     280.80474504-280.80474504,...
%     391.16771395-395.68256657];
% % hardpoints_front.inboard.rocker_to_damper = [-1416.658, 265.09, 470.67];
% hardpoints_front.inboard.rocker_to_damper = [-1416.658, 265.09, 480.67];
% hardpoints_front.inboard.roll_damper_left = [-1500, 71.83, 504.31];
% hardpoints_front.inboard.damper_to_chassis = [-1410.715, 89.0068, 433.808];

sim = run_kine_sim('Kinematics_Model',hardpoints_front);

disp(['Option ' num2str(i)])
    disp(['    Bump Travel: ' num2str(sim.metrics.BumpTravel)])
    disp(['    Droop Travel: ' num2str(sim.metrics.DroopTravel)])
    disp(['    Camber Gain: ' num2str(sim.metrics.CamberGain_heave_coef(2))])
    disp(['    Static RCH: ' num2str(sim.metrics.RCH_static)])
    disp(['    Static UWBO: ' num2str(sim.position_output.uwb_z.data(sim.metrics.static_idx))])
    disp(['    Static PRO_x: ' num2str(sim.position_output.pr_x.data(sim.metrics.static_idx))])
    disp(['    Static PRO_y: ' num2str(sim.position_output.pr_y.data(sim.metrics.static_idx))])
    disp(['    Static PRO_z: ' num2str(sim.position_output.pr_z.data(sim.metrics.static_idx))])
    disp(['    Static Anti-Squat: ' num2str(sim.metrics.AntiSquat_static)])
    disp(['    Static SVIC (X,Y,Z): ' num2str(sim.channels.SVIC(sim.metrics.static_idx,:))])
% point1 = [-1378.57, 421.95, 279.98];
% point2 = [-1594.8, 258.11, 366.33];
% 
% rocker_axis = point1-point22;
% axis_normalised = rocker_axis./norm(rocker_axis);
% 
% hardpoints_front.inboard.rocker_axis = axis_normalised;
% 
% n_points = 10;
% x = linspace(point1(1),point2(1),n_points);
% y = linspace(point1(2),point2(2),n_points);
% z = linspace(point1(3),point2(3),n_points);
% 
% hardpoint_list = cell(n_points,1);
% for i = 1:n_points
%     
% end