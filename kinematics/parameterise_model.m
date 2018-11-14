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
    hardpoints.pr.inner);
params.susp_geometry.pr_inner_x = hardpoints.pr.inner;

%Tyre
params.wheel_geometry.tyre_diameter = 464.82;
params.wheel_geometry.tyre_width = 190.5;

%Chassis
params.chassis_geometry.size = [500, 750, 750];