function params = parameterise_model(hardpoints)

params.hardpoints_front = hardpoints;
%Upper wishbone
params.susp_geometry.uwb_f = hardpoints.uwb.front;
params.susp_geometry.uwb_f_length = norm(hardpoints.uwb.outer - ...
    hardpoints.uwb.front);

params.susp_geometry.uwb_r = hardpoints.uwb.rear;
params.susp_geometry.uwb_r_length = norm(hardpoints.uwb.outer - ...
    hardpoints.uwb.rear);

params.susp_geometry.uwb_initial_angle = 0;

%Lower wishbone
params.susp_geometry.lwb_f = hardpoints.lwb.front;
params.susp_geometry.lwb_f_length = norm(hardpoints.lwb.outer - ...
    hardpoints.lwb.front);

params.susp_geometry.lwb_r = hardpoints.lwb.rear;
params.susp_geometry.lwb_r_length = norm(hardpoints.lwb.outer - ...
    hardpoints.lwb.rear);

%Outboard Assembly
params.susp_geometry.outboard_offset_uwb = hardpoints.uwb.outer - ...
    hardpoints.wheel.centre;
params.susp_geometry.outboard_offset_lwb = hardpoints.lwb.outer - ...
    hardpoints.wheel.centre;
params.susp_geometry.outboard_offset_tr = hardpoints.tr.outer - ...
    hardpoints.wheel.centre;

%Track Rod
params.susp_geometry.tr_length = norm(hardpoints.tr.outer - ...
    hardpoints.tr.inner);
params.susp_geometry.tr_inner_x = hardpoints.tr.inner;

%Pushrod
%TODO: should be able to deal with both push- and pull-rods...
%But I'll deal with that later - it's not a major change
% params.susp_geometry.pr_length = norm(hardpoints.pr.outer - ...
params.susp_geometry.pr_length = norm(hardpoints.lwb.outer - ...
    hardpoints.pr.inner); %This should be a setup parameter as well
params.susp_geometry.pr_inner_x = hardpoints.pr.inner;
params.susp_geometry.pr_outer_offset = norm(hardpoints.lwb.outer - ...
    hardpoints.pr.outer);

%Inboard
params.susp_geometry.rocker_pivot = hardpoints.inboard.rocker_pivot;
%TODO: add in support for rocker not alligned parallel to XY plane
%TODO: add in ARB model
pr_offset_x = (hardpoints.pr.inner(2) - hardpoints.inboard.rocker_pivot(2));
pr_offset_y = (hardpoints.pr.inner(3) - hardpoints.inboard.rocker_pivot(3));
params.susp_geometry.rocker_pr_offset = [pr_offset_y, pr_offset_x, 0];
damper_offset_x = hardpoints.inboard.rocker_to_damper(2) - ...
    hardpoints.inboard.rocker_pivot(2);
damper_offset_y = hardpoints.inboard.rocker_to_damper(3) - ...
    hardpoints.inboard.rocker_pivot(3);
params.susp_geometry.rocker_damper_offset =...
    [damper_offset_y, damper_offset_x, 0];
params.susp_geometry.damper_to_chassis = hardpoints.inboard.damper_to_chassis;

%Tyre
params.wheel_geometry.tyre_diameter = 464.82;
params.wheel_geometry.tyre_width = 190.5;

%Chassis
params.chassis_geometry.size = [1000, 500, 750];

%Model inputs
params.inputs.wheel_z = timeseries([zeros(1,100) linspace(-50, 50, 100)],linspace(0,2,200));
params.inputs.tr_y = timeseries([linspace(-12.5, 12.5, 100) zeros(1,100)],linspace(0,2,200));