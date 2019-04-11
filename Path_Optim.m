function [x_new,y_new] = Path_Optim(x,y,x0,y0,theta,track_width,Iterations)

initial = [x,y];
% diff(atan2(diff(y),diff(x)));
fun = @(z) sum((abs(Curvature(z)./min(Curvature(initial)))).^2);
A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = @PathCon;

theta(length(theta)+1) = theta(end);

x_min = zeros(length(x),1);
x_max = zeros(length(x),1);
y_min = zeros(length(x),1);
y_max = zeros(length(x),1);
x_left = zeros(length(x),1);
x_right = zeros(length(x),1);
y_left = zeros(length(x),1);
y_right = zeros(length(x),1);
for i = 1:length(x)
    x_min(i) = min(x0(i) + (track_width/2) * sin(theta(i)),x0(i) - (track_width/2) * sin(theta(i)));
    x_max(i) = max(x0(i) + (track_width/2) * sin(theta(i)),x0(i) - (track_width/2) * sin(theta(i)));
    y_min(i) = min(y0(i) + (track_width/2) * cos(theta(i)),y0(i) - (track_width/2) * cos(theta(i)));
    y_max(i) = max(y0(i) + (track_width/2) * cos(theta(i)),y0(i) - (track_width/2) * cos(theta(i)));
    x_left(i) = x0(i) - (track_width/2) * sin(theta(i));
    y_left(i) = y0(i) + (track_width/2) * cos(theta(i));
    x_right(i) = x0(i) + (track_width/2) * sin(theta(i));
    y_right(i) = y0(i) - (track_width/2) * cos(theta(i));
end

ub = [x_max',y_max'];
lb = [x_min',y_min'];
opts = optimset('Display','iter','Algorithm','interior-point', 'MaxIter', Iterations, 'MaxFunEvals', Inf...
    ,'TolCon',1e-20,'TolX',1e-20);
new = fmincon(fun,initial,A,b,Aeq,beq,lb,ub,nonlcon,opts);
x_new = new(:,1);
y_new = new(:,2);
hold on
plot(x_left-x_new(1),y_left-y_new(1),'k-');
plot(x_right-x_new(1),y_right-y_new(1),'k-');