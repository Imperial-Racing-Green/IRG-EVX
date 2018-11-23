sze = size(quaternion_out.Data);
camber = zeros(sze(1),1);
toe = zeros(sze(1),1);
rot = zeros(sze(1),1);

for i = 1:sze(1)
    [camber(i), toe(i), rot(i)] = quat2angle(quaternion_out.Data(i,:),'XZY');
end
camber = camber.*57.2958;
toe = toe.*57.2958;
rot = rot.*57.2958;
plot(quaternion_out.Time,camber)
hold on
plot(quaternion_out.Time,toe)
plot(quaternion_out.Time,rot)
hold off
legend('camber','toe','rotation','location','northwest')