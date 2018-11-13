function params = parameterise_model(hardpoints)

%Upper wishbone
params.susp_geometry.uwb_inner_x = [1,2,3];
params.susp_geometry.uwb_inner_axis = [1,2,3];

params.susp_geometry.uwb_length = 500;

%Lower wishbone
params.susp_geometry.lwb_inner_x = [250,2,3];
params.susp_geometry.lwb_inner_axis = [1,2,3];

params.susp_geometry.lwb_length = 500;

%Outboard Assembly
params.susp_geometry.outboard_offset_uwb = [1,2,3]; %Relative to wheel centre
params.susp_geometry.outboard_offset_lwb = [1,2,3];
params.susp_geometry.outboard_offset_tr = [1,2,3];

%Track Rod
params.susp_geometry.tr_length = 100;
params.susp_geometry.tr_inboard_x = [1,2,3];

%Pushrod
%TODO: should be able to deal with both push- and pull-rods...
params.susp_geometry.pr_length = 100;
params.susp_geometry.pr_inboard_x = [1,2,3];

%Tyre
params.wheel_geometry.tyre_diameter = 464.82;
params.wheel_geometry.tyre_width = 190.5;

%Chassis
params.chassis_geometry.size = [500, 750, 750];