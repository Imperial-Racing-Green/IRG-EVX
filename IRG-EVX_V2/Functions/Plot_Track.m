function [] = Plot_Track(x,y,z,w,t)

Length = max(Track_Dist(x,y));

[x1,y1,x4,y4,~,~] = Track_Boundary(x,y,w);

x1 = Interpolate(length(x1),Length,x1,'spline')';
y1 = Interpolate(length(y1),Length,y1,'spline')';
x4 = Interpolate(length(x4),Length,x4,'spline')';
y4 = Interpolate(length(y4),Length,y4,'spline')';

z1 = zeros(length(x1),1);
z4 = zeros(length(x4),1);
x2 = x1;
y2 = y1;
x3 = x4;
y3 = y4;

z2 = Interpolate(length(z),Length,z,'spline')' + (Interpolate(length(w),Length,w,'spline')'./2).*sind(Interpolate(length(t),Length,t,'spline')');
z3 = Interpolate(length(z),Length,z,'spline')' - (Interpolate(length(w),Length,w,'spline')'./2).*sind(Interpolate(length(t),Length,t,'spline')');
figure
hold on
for i = 1:length(x1)-1
    fill3([x1(i:i+1);flip(x2(i:i+1))],[y1(i:i+1);flip(y2(i:i+1))],[z1(i:i+1);flip(z2(i:i+1))],'k',...
        [x2(i:i+1);flip(x3(i:i+1))],[y2(i:i+1);flip(y3(i:i+1))],[z2(i:i+1);flip(z3(i:i+1))],[z2(i:i+1);flip(z3(i:i+1))],...
        [x3(i:i+1);flip(x4(i:i+1))],[y3(i:i+1);flip(y4(i:i+1))],[z3(i:i+1);flip(z4(i:i+1))],'k','EdgeColor','none');
end
set(gca,'XColor', 'none','YColor','none','ZColor','none')
daspect([1 1 (max(z)*10)/max(x)])
% title('Press "Enter" to close the figure.')
c = colorbar;
c.Label.String = 'z height (m)';
% ax = gca;
% fig = ancestor(ax, 'figure');
% set(fig,'WindowState','maximized');
view(0,45)