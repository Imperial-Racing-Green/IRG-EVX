clear
close all
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
disp("Simulation complete")

%% Tidy up simulation output variables
disp("Post-processing sim result...")
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
channels.l_damper = get(simOut.SimulationOutput.logsout,'l_damper');
channels.y_trackrod = get(simOut.SimulationOutput.logsout,'y_tr');

flds = fields(channels);
for i = 1:length(flds)
    try %The time field won't work and it's not a massive issue if the data isn't converted
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

n_data = length(simOut.channels.time);
dl = diff(channels.l_damper);
steer_test_end = find(dl~=0,1);
vert_test_start = find(round(dl,2)~=round(dl(end),2),1,'last');

%% Calculate Dynamic Instant Centre Position
disp("Calculating additional data channels...")
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
FVIC = zeros(size(lwb_out));
SVIC = zeros(size(lwb_out));
RCH_heave = zeros(1,n_data);
for i = 1:n_data
    %Calculate normals
    uwb_n(i,:) = cross(uwb_out(i,:) - uwb_front(i,:), uwb_out(i,:) - uwb_rear(i,:));
    lwb_n(i,:) = cross(lwb_out(i,:) - lwb_front(i,:), lwb_out(i,:) - lwb_rear(i,:));
    
    %Construct instant axis from UWB and LWB planes
    [IA_P(i,:),IA_N(i,:)] = plane_intersect(uwb_n(i,:),uwb_out(i,:),lwb_n(i,:),lwb_out(i,:));
    
    %Projecting IA onto front and right planes gives front and view instant
    %centres
    FVIC(i,:) = plane_line_intersect([1 0 0],[0 0 0],IA_P(i,:),IA_P(i,:)+IA_N(i,:));
    SVIC(i,:) = plane_line_intersect([0 1 0],[0 simOut.channels.y_contact_patch(i) 0],IA_P(i,:),IA_P(i,:)+IA_N(i,:));
    
    %Work out heave RCH
    dydx = (FVIC(i,3)-simOut.channels.z_contact_patch(i))./(FVIC(i,2)-simOut.channels.y_contact_patch(i));
    RCH_heave(i) = FVIC(i,3) - dydx*FVIC(i,2); %RCH is just the y-intercept of the line between contact patch and IC
end

simOut.channels.FVIC = FVIC;
simOut.channels.SVIC = SVIC;
simOut.channels.l_RCH_heave = RCH_heave;

%% Metrics
% Calculates several useful parameters for at-a-glance sim result analysis
disp("Calculating simulation metrics...")
metrics = struct();

% metrics.CamberGain_heave_coef
% metrics.CamberGain_roll_coef
% metrics.CamberGain_steer_coef
% metrics.BumpSteer_coef
% metrics.Ackermann_coef
% metrics.MotionRatio_coef
metrics.BumpTravel = max(channels.z_contact_patch);
metrics.DroopTravel = abs(min(channels.z_contact_patch));
% metrics.RCH_static
% metrics.RCH_heave_coef
% metrics.RCH_roll_vert_coef
% metrics.RCH_roll_lat_coef
% metrics.AntiDive_static
% metrics.AntiDive_coef
% metrics.SteerJacking
% metrics.KPI_static
% metrics.Caster_static
% metrics.ScrubRadius_static
% metrics.MechanicalTrail_static
% metrics.MaxSteer_inside
% metrics.MaxSteer_outside


simOut.metrics = metrics;

disp("Done!")