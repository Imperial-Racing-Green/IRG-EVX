clear
addpath([pwd '\kinematics'])
addpath([pwd '\kinematics\functions'])

disp("Loading car data...")
load([pwd char("/kinematics/SUSF-P-001_V3_Hardpoints.mat")])

disp("Parameterising model...")
params = parameterise_kine_model(hardpoints_front);

disp("Running simulation...")
simOut = struct();
simOut.SimulationOutput = sim('Kinematics_Model','SaveState','on','StateSaveName','xout',...
            'SaveOutput','on','OutputSaveName','yout',...
 'SaveFormat', 'Dataset', 'CaptureErrors', 'on');
disp("Simulation complete!")

%% Tidy up simulation output variables
disp("Post-processing sim result")
%Data Channels into channels struct
channels = struct();

channels.time = simOut.SimulationOutput.tout;
channels.x_contact_patch = get(simOut.SimulationOutput.logsout,'contact_patch_x');
channels.y_contact_patch = get(simOut.SimulationOutput.logsout,'contact_patch_y');
channels.z_contact_patch = get(simOut.SimulationOutput.logsout,'contact_patch_z');
channels.a_camber = get(simOut.SimulationOutput.logsout,'Camber');
channels.a_toe = get(simOut.SimulationOutput.logsout,'Toe');
channels.a_caster = get(simOut.SimulationOutput.logsout,'Caster');
channels.a_KPI = get(simOut.SimulationOutput.logsout,'Kingpin Inclination');
channels.l_mechTrail = get(simOut.SimulationOutput.logsout,'Mechanical Trail');
channels.l_scrubRad = get(simOut.SimulationOutput.logsout,'Scrub Radius');
channels.r_antiDive = 0;
channels.l_RCH = 0;
channels.l_damper = get(simOut.SimulationOutput.logsout,'l_damper');
channels.y_trackrod = get(simOut.SimulationOutput.logsout,'y_tr');

flds = fields(channels);
for i = 1:length(flds)
    try
        channels.(flds{i}) = squeeze(channels.(flds{i}).Values.data);
    catch
    end
end
simOut.channels = channels;

if any(structfun(@isempty, channels))
    warning("One or more data channels is empty - there may be issues with logging")
end

%% Split steering and Vertical Test Data
%Sim runs two tests - helpful to take them separately

dl = diff(channels.l_damper);
steer_test_end = find(dl~=0,1);
vert_test_start = find(round(dl,2)~=round(dl(end),2),1,'last');

%% Calculate Dynamic Instant Centre Position

%First get the relevant data out
uwb_out = [position_output.uwb_x.data, position_output.uwb_y.data,...
    position_output.uwb_z.data];
uwb_front = params.hardpoints_front.uwb.front.*ones(size(uwb_out));
uwb_rear = params.hardpoints_front.uwb.rear.*ones(size(uwb_out));

lwb_out = [position_output.lwb_x.data, position_output.lwb_y.data,...
    position_output.lwb_z.data];
lwb_front = params.hardpoints_front.lwb.front.*ones(size(lwb_out));
lwb_rear = params.hardpoints_front.lwb.rear.*ones(size(lwb_out));

% calculate UWB and LWB plane normals
uwb_n = zeros(size(uwb_out));
lwb_n = zeros(size(lwb_out));
IA_P = zeros(size(lwb_out));
IA_N = zeros(size(lwb_out));
for i = 1:length(position_output.uwb_x.data)
    uwb_n(i,:) = cross(uwb_out(i,:) - uwb_front(i,:), uwb_out(i,:) - uwb_rear(i,:));
    lwb_n(i,:) = cross(lwb_out(i,:) - lwb_front(i,:), lwb_out(i,:) - lwb_rear(i,:));
    
    [IA_P(i,:),IA_N(i,:)] = plane_intersect(uwb_n(i,:),uwb_out(i,:),lwb_n(i,:),lwb_out(i,:));
    FVIC(i,:) = plane_line_intersect([1 0 0],[0 0 0],IA_P(i,:),IA_P(i,:)+IA_N(i,:));
    SVIC(i,:) = plane_line_intersect([0 1 0],[0 0 0],IA_P(i,:),IA_P(i,:)+IA_N(i,:));
end

