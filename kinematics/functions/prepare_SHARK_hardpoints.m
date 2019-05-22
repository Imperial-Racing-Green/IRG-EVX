load([pwd char("/kinematics/geometries/EV3 Front Hardpoints 13.01.19.mat")])
% load([pwd char("/kinematics/geometries/Final Rear Outboard 01.02.19.mat")])
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

try
    rocker_point_2 = hardpoints_front.inboard.rocker_pivot + hardpoints_front.inboard.rocker_axis/norm(hardpoints_front.inboard.rocker_axis);
catch
    hardpoints_front.inboard.rocker_axis = [1 0 0];
    rocker_point_2 = hardpoints_front.inboard.rocker_pivot + hardpoints_front.inboard.rocker_axis/norm(hardpoints_front.inboard.rocker_axis);
end

fld = fields(hardpoints_front);

for i = 1:length(fld)
    flds = fields(hardpoints_front.(fld{i}));
    for j = 1:length(flds)
        hardpoints_front.(fld{i}).(flds{j})(1) = -hardpoints_front.(fld{i}).(flds{j})(1) + 200;
    end
end