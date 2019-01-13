clear
addpath([pwd '\kinematics'])
addpath([pwd '\kinematics\functions'])

load([pwd char("/kinematics/SUSF-P-001_V3_Hardpoints.mat")])

params = parameterise_kine_model(hardpoints_front);

simOut = sim('Kinematics_Model','SaveState','on','StateSaveName','xout',...
            'SaveOutput','on','OutputSaveName','yout',...
 'SaveFormat', 'Dataset', 'CaptureErrors', 'on');

%% Calculate Dynamic Instant Centre Position
uwb_out = [position_output.uwb_x.data, position_output.uwb_y.data,...
    position_output.uwb_z.data];
uwb_front = params.hardpoints_front.uwb.front.*ones(size(uwb_out));
uwb_rear = params.hardpoints_front.uwb.rear.*ones(size(uwb_out));


uwb_plane = 