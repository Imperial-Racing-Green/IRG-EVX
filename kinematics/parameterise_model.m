function params = parameterise_model(hardpoints)

%Upper wishbone
params.susp_geometry.uwb_inner_x = 0.5.*(hardpoints.uwb.front+hardpoints.uwb.rear);
axis1 = hardpoints.uwb.front-hardpoints.uwb.rear;

theta1_z = atand(axis1(2)/axis1(1));
theta1_y = atand(axis1(3)/axis1(1));
theta1_x = 0; %No rotation in third axis needed because this
%will be axis of rotation for revolute joint

params.susp_geometry.uwb_inner_axis = [theta1_z,theta1_y,theta1_x];

params.susp_geometry.uwb_length = norm(hardpoints.uwb.outer - ...
    params.susp_geometry.uwb_inner_x);

params.susp_geometry.uwb_initial_angle = 0;

%Lower wishbone
params.susp_geometry.lwb_inner_x = 0.5.*(hardpoints.lwb.front+hardpoints.lwb.rear);
axis2 = hardpoints.lwb.front-hardpoints.lwb.rear;

theta2_z = atand(axis2(2)/axis2(1));
theta2_y = atand(axis2(3)/axis2(1));
theta2_x = 0; %No rotation in third axis needed

params.susp_geometry.lwb_inner_axis = [theta2_z,theta2_y,theta2_x];

params.susp_geometry.lwb_length = norm(hardpoints.lwb.outer - ...
    params.susp_geometry.lwb_inner_x);

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
params.susp_geometry.pr_length = norm(hardpoints.pr.outer - ...
    hardpoints.pr.inner); %This should be a setup parameter as well
params.susp_geometry.pr_inner_x = hardpoints.pr.inner;
params.susp_geometry.pr_outer_offset = norm(hardpoints.lwb.outer - ...
    hardpoints.pr.outer);

%Inboard
params.susp_geometry.rocker_pivot = hardpoints.inboard.rocker_pivot;
%TODO: add in support for rocker not alligned parallel to XY plane
%TODO: add in ARB model
pr_offset_x = -(hardpoints.pr.inner(2) - hardpoints.inboard.rocker_pivot(2));
pr_offset_y = -(hardpoints.pr.inner(3) - hardpoints.inboard.rocker_pivot(3));
params.susp_geometry.rocker_pr_offset = [pr_offset_x, pr_offset_y, 0];
damper_offset_x = hardpoints.inboard.rocker_to_damper(2) - ...
    hardpoints.inboard.rocker_pivot(2);
damper_offset_y = hardpoints.inboard.rocker_to_damper(3) - ...
    hardpoints.inboard.rocker_pivot(3);
params.susp_geometry.rocker_damper_offset =...
    [damper_offset_x, damper_offset_y, 0];
params.susp_geometry.damper_to_chassis = hardpoints.inboard.damper_to_chassis;

%Tyre
params.wheel_geometry.tyre_diameter = 464.82;
params.wheel_geometry.tyre_width = 190.5;

%Chassis
params.chassis_geometry.size = [1000, 500, 750];