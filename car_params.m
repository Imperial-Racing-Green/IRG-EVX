
%Upper wishbone
susp_geometry.uwb_inner_x = [1,2,3];
susp_geometry.uwb_inner_axis = [1,2,3];

susp_geometry.uwb_length = 100;

%Lower wishbone
susp_geometry.lwb_inner_x = [1,2,3];
susp_geometry.lwb_inner_axis = [1,2,3];

susp_geometry.lwb_length = 100;

%Outboard Assembly
susp_geometry.outboard_offset_uwb = [1,2,3]; %Relative to wheel centre
susp_geometry.outboard_offset_lwb = [1,2,3];
susp_geometry.outboard_offset_tr = [1,2,3];

%Track Rod
susp_geometry.tr_length = 100;
susp_geometry.tr_inboard_x = [1,2,3];

%Pushrod
%TODO: should be able to deal with both push- and pull-rods...
susp_geometry.pr_length = 100;
susp_geometry.pr_inboard_x = [1,2,3];
