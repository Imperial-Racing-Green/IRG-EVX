
geometry_name = 'Rear Opt2 14.01.19';

hardpoints_front.lwb.front = [-1300, 356, 135];
hardpoints_front.lwb.rear = [-1691.94, 207.26, 126.53];
hardpoints_front.lwb.outer = [-1525, 558, 125];

hardpoints_front.uwb.front = [-1300, 356, 250.48];
hardpoints_front.uwb.rear = [-1750.17, 263.14, 244.28];
hardpoints_front.uwb.outer = [-1525, 558, 295.15];

hardpoints_front.tr.inner = [-1614.9, 230, 201];
hardpoints_front.tr.outer = [-1614.9, 558, 175];

hardpoints_front.pr.inner = [-1500, 216.7, 498.3];
hardpoints_front.pr.outer = [-1500, 510.49, 138.41];

hardpoints_front.inboard.rocker_pivot = [-1500, 158.4, 459.5];
hardpoints_front.inboard.rocker_to_damper = [-1500, 88.56, 425.87];
hardpoints_front.inboard.roll_damper_left = [-1500, 71.83, 504.31];
hardpoints_front.inboard.damper_to_chassis = [-1500, 185.78, 271.56];

hardpoints_front.wheel.tyre_diameter = 464.82;
hardpoints_front.wheel.centre = [-1550 600 hardpoints_front.wheel.tyre_diameter/2];

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