clear
close all

load([pwd char("/kinematics/geometries/Rocker Rot Test 24.01.19.mat")])

point1 = [-1378.57, 421.95, 279.98];
point2 = [-1594.8, 258.11, 366.33];

rocker_axis = point1-point22;
axis_normalised = rocker_axis./norm(rocker_axis);

hardpoints_front.inboard.rocker_axis = axis_normalised;

n_points = 10;
x = linspace(point1(1),point2(1),n_points);
y = linspace(point1(2),point2(2),n_points);
z = linspace(point1(3),point2(3),n_points);

hardpoint_list = cell(n_points,1);
for i = 1:n_points
    
end