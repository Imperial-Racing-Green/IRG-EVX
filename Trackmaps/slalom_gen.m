function [coords]=slalom_gen(A,cone_dist,cone_number,x1,y1,x,y,dist)

%Function to calculate x and y coordiantes for the slalom
%Inputs - A = How far away from the cones you want to travel. cone_dist =
%distance between the cones.  cone_number = number of cones
%Outputs - x and y coordinates 

%Getting the value of omega from Time period, T 
T = 2*cone_dist; 
omega = (2*pi)/T; 

%Getting array length and actual length of slalom
slalom_length = (cone_number+1)*cone_dist;
k1 = find(abs(x-x1) < 0.01);
init_dist = dist(k1);
final_dist = init_dist + slalom_length;
k2 = find((abs(dist-final_dist))<0.5);

%Final coordinates of slalom
x2=x(k2);
y2=y(k2);

%Assume that it will cover x values 
x_vals = linspace(0,cone_dist*cone_number,(k2-k1))';

y_vals = A*sin(omega*x_vals); 

lx=abs(x2-x1);
ly=abs(y2-y1);

theta_rot= atand(ly/lx);
theta_rot= 180-theta_rot;
%theta_rot = 360-theta_rot; 

R = [cosd(theta_rot) -sind(theta_rot); 
     sind(theta_rot) cosd(theta_rot)];

coords = [x_vals,y_vals];

new_coords = R*[coords(:,1),coords(:,2)]';
new_coords = new_coords';

new_x = new_coords(:,1)+x1;
new_y = new_coords(:,2)+y1;

x(k1:(k2-1)) = new_x;
y(k1:(k2-1)) = new_y;

coords=[x,y];
























