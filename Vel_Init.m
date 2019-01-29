function velocity = Vel_Init(Dist,v_max);

velocity = zeros(length(Dist),1);

for i = 1:length(Dist)
    velocity(i) = min(Dist(i)/2,v_max);
end

velocity(velocity < 0.5) = 0.5;