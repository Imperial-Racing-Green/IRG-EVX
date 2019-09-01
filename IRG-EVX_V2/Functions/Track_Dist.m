function Distance_final = Track_Dist(x,y)

%% Get a distance value for each point
Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
Distance = cumsum(Spacing);            %Cumulative segment/path length

Distance = [0;Distance];


%% Make super high resolution to minimise effect of straigh line assumption
x_new = interp1(Distance,x,interp1(linspace(0,length(Distance),length(Distance)),Distance,linspace(0,length(Distance),length(Distance)*10),'spline'),'makima')';
y_new = interp1(Distance,y,interp1(linspace(0,length(Distance),length(Distance)),Distance,linspace(0,length(Distance),length(Distance)*10),'spline'),'makima')';

Spacing_new = ((diff(x_new)).^2 + (diff(y_new)).^2).^0.5;    	%Magnitude distance between successive coordinates
Distance_new = cumsum(Spacing_new);            %Cumulative segment/path length

Distance_new = [0;Distance_new];

%% Rescale back to old resolution
Distance_final = zeros(length(Distance),1);
for i = 1:length(Distance)
    [~,pos] = min(((x(i)-x_new).^2+(y(i)-y_new).^2).^0.5);
    Distance_final(i) = Distance_new(pos);
end
Distance_final(1) = Distance(1);
Distance_final(end) = Distance_new(end);
