% Runs a big batch of sims for getitng out sensitivities for the report
clear
close all

model_name = 'Kinematics_Sim';
HPsF = load([pwd char("/kinematics/geometries/EV3 Front Hardpoints 13.01.19.mat")]);
HPsR = load([pwd char("/kinematics/geometries/Final Rear Outboard 01.02.19.mat")]);

simmode = 1;
if simmode == 1
    hardpoints_front = HPsF.hardpoints_front;
else
    hardpoints_front = HPsR.hardpoints_front;
end

% poolobj = gcp('nocreate');
% if isempty(poolobj)
%     parpool(3)
% end

tic
idx = 2;
% sims = struct();
sims(1) = run_kine_sim(model_name,hardpoints_front); %base sim
sims(1).sim_desc = 'Base';
sims(1).metrics = comparison_metrics(sims(1));
flds = fields(hardpoints_front);
for i = 1:length(flds) %iterate through top struct level
    fld = fields(hardpoints_front.(flds{i}));
    for j = 1:length(fld) %iterate through second level (individual points)
        for k = 1:length(hardpoints_front.(flds{i}).(fld{j})) %Three directions
            hardpoints_sim = hardpoints_front; %copy hardpoints
            %run a sim with each hardpoint moved 1mm in one cartesian
            %direction
            hardpoints_sim.(flds{i}).(fld{j})(k) = hardpoints_sim.(flds{i}).(fld{j})(k) + 1;
            sim = run_kine_sim(model_name,hardpoints_sim);
            sim.sim_desc = [flds{i} ' - ' fld{j} ' - ' num2str(k)];
            sim.metrics = comparison_metrics(sim);
            sims(idx) = sim;
            disp(sims(idx).sim_desc)
            idx = idx + 1;
        end
        
    end
end
toc
save([pwd '\kinematics\sims\Comparison Sims ' num2str(simmode) '.mat'],'sims')

