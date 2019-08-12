function Distance = Track_Dist(x,y)

Spacing = ((diff(x)).^2 + (diff(y)).^2).^0.5;    	%Magnitude distance between successive coordinates
Distance = cumsum(Spacing);            %Cumulative segment/path length

Distance = Interpolate(length(Distance),length(Distance)+1,Distance,'spline')';

end