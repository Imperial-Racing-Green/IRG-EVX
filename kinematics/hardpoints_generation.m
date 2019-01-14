
geometry_name = 'Rear Opt1 14.01.19';

hardpoints_front.lwb.front = [176.98, 252.3, 124.89];
hardpoints_front.lwb.rear = [-175.12, 281.87, 126.41];
hardpoints_front.lwb.outer = [8.93, 561.42, 140.75];

hardpoints_front.uwb.front = [178.51, 250.87, 281.96];
hardpoints_front.uwb.rear = [-177.74, 281.38, 264.58];
hardpoints_front.uwb.outer = [-15.65, 545.1, 323.75];

hardpoints_front.tr.inner = [75.89, 230, 201];
hardpoints_front.tr.outer = [75.89, 552.49, 240.94];

hardpoints_front.pr.inner = [30, 216.7, 498.3];
hardpoints_front.pr.outer = [15, 510.49, 138.41];

hardpoints_front.inboard.rocker_pivot = [30, 158.4, 459.5];
hardpoints_front.inboard.rocker_to_damper = [30, 88.56, 425.87];
hardpoints_front.inboard.roll_damper_left = [30, 71.83, 504.31];
hardpoints_front.inboard.damper_to_chassis = [30, 185.78, 271.56];

hardpoints_front.wheel.tyre_diameter = 464.82;
hardpoints_front.wheel.centre = [0 600 hardpoints_front.wheel.tyre_diameter/2];

if isfile([pwd '/kinematics/geometries/' geometry_name '.mat'])
    response = input("File of same name already exists - do you want to overwrite it? (Y/N) ",'s' );
    if strcmp(response,"y") || strcmp(response,"Y")
        save([pwd '/kinematics/geometries/' geometry_name '.mat'],'hardpoints_front')
        disp("Geometry saved successfully")
    else
        disp("File not saved - please select a new destination and try again")
    end
else
    save([pwd '/kinematics/geometries/' geometry_name '.mat'],'hardpoints_front')
    disp("Geometry saved successfully")
end