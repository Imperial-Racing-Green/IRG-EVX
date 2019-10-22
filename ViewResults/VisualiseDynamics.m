% Plot dynamics of a single sim
close all
clear
clc

SimPath = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\Final Sims\Test2\Sim1.mat';

Results = load(SimPath);

% Get corner positions
xFL = 0.5*Results.Car.Dimension.lWheelbase;
xFR = 0.5*Results.Car.Dimension.lWheelbase;
xRL = -0.5*Results.Car.Dimension.lWheelbase;
xRR = -0.5*Results.Car.Dimension.lWheelbase;
yFL = -0.5*Results.Car.Dimension.Front_track;
yFR = 0.5*Results.Car.Dimension.Front_track;
yRL = -0.5*Results.Car.Dimension.Rear_track;
yRR = 0.5*Results.Car.Dimension.Rear_track;

% Get corner dynamics
zFL = Results.Car.AeroPerformance.hRideF + (0.5*Results.Car.Dimension.Front_track*tand(Results.aRollF)) + (0.5*Results.Car.Dimension.lWheelbase*tand(Results.aPitch));
zFR = Results.Car.AeroPerformance.hRideF - (0.5*Results.Car.Dimension.Front_track*tand(Results.aRollF)) + (0.5*Results.Car.Dimension.lWheelbase*tand(Results.aPitch));
zRL = Results.Car.AeroPerformance.hRideR + (0.5*Results.Car.Dimension.Rear_track*tand(Results.aRollR)) - (0.5*Results.Car.Dimension.lWheelbase*tand(Results.aPitch));
zRR = Results.Car.AeroPerformance.hRideR - (0.5*Results.Car.Dimension.Rear_track*tand(Results.aRollR)) - (0.5*Results.Car.Dimension.lWheelbase*tand(Results.aPitch));

figure();
subplot(2,1,1)
l = plot(Results.tLap(1),Results.vCar(1),'b');
xlim([0, Results.tLap(end)])
ylim([0, max(Results.vCar) + 5])
xlabel('tLap (s)')
ylabel('vCar (m/s)')
subplot(2,1,2)
view(3)
xlim([-Results.Car.Dimension.lWheelbase, Results.Car.Dimension.lWheelbase])
ylim([-Results.Car.Dimension.Rear_track, Results.Car.Dimension.Rear_track])
zlim([0, 0.1])
ground =patch([-Results.Car.Dimension.lWheelbase, Results.Car.Dimension.lWheelbase, Results.Car.Dimension.lWheelbase, -Results.Car.Dimension.lWheelbase],...
              [Results.Car.Dimension.Rear_track, Results.Car.Dimension.Rear_track, -Results.Car.Dimension.Rear_track, -Results.Car.Dimension.Rear_track],...
              [0, 0, 0, 0],'FaceColor',[0.7 0.7 0.7]);
p = patch([xFL,xRL,xRR,xFR],[yFL,yRL,yRR,yFR],[zFL(1),zRL(1),zRR(1),zFR(1)],'b');
hold on
s = scatter3([xFL,xRL,xRR,xFR],[yFL,yRL,yRR,yFR],[zFL(1),zRL(1),zRR(1),zFR(1)],500,'k','filled');
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
pause(Results.tLap(2)-Results.tLap(1))
for i = 2:length(zFL)-1
    l.XData = Results.tLap(1:i);
    l.YData = Results.vCar(1:i);
    p.ZData = [zFL(i),zRL(i),zRR(i),zFR(i)];
    s.ZData = [zFL(i),zRL(i),zRR(i),zFR(i)];
    pause(Results.tLap(i+1)-Results.tLap(i))
end
    