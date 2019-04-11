function [c,ceq] = Lap_Con(z,x,y)

load('temp.mat')

for i = 1:length(x_log)
    dist = ((x-x_log(i)).^2+(y-y_log(i)).^2).^0.5;
    [~,pos] = min(dist);
    dev(i) = ((x(pos)-x_log(i))^2+(y(pos)-y_log(i))^2)^0.5;
end
Track_Width = 5;

limits = dev-Track_Width/2;
limits(limits<0)=0;

c=[];
ceq=[sum(limits)];