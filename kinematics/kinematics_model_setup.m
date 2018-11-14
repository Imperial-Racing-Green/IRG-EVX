hardpoints_front.lwb.front = [176.98, 252.3, 124.89];
hardpoints_front.lwb.rear = [-175.12, 281.87, 126.41];
hardpoints_front.lwb.outer = [8.93, 561.42, 140.75];

hardpoints_front.uwb.front = [178.51, 250.87, 281.96];
hardpoints_front.uwb.rear = [-177.74, 281.38, 264.58];
hardpoints_front.uwb.outer = [-15.65, 545.1, 323.75];

hardpoints_front.tr.inner = [75.89, 230, 201];
hardpoints_front.tr.outer = [75.89, 552.49, 240.94];

hardpoints_front.pr.inner = [30, 195.29, 525.12];
hardpoints_front.pr.outer = [15, 510.49, 138.41];

hardpoints_front.wheel.tyre_diameter = 464.82;
hardpoints_front.wheel.centre = [0 600 hardpoints_front.wheel.tyre_diameter/2];

params = parameterise_model(hardpoints_front);