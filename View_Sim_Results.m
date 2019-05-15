clear
clc
% Breakdown of the main ouput params the lapsim
Sim = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\CoG_Test\Sim2.mat';

Results = load(Sim);

figure();
subplot(4,1,1)
plot(Results.dist_log.Data,Results.vCar,'b','LineWidth',1.2)
xlim([0 Results.dist_log.Data(end)])
ylabel('vCar')
subplot(4,1,2)
plot(Results.dist_log.Data,Results.Driver_Inputs.rThrottle.Data,'g','LineWidth',1.2)
xlim([0 Results.dist_log.Data(end)])
ylim([-5 105])
ylabel('rThrottle')
subplot(4,1,3)
plot(Results.dist_log.Data,Results.Driver_Inputs.rBrake.Data,'r','LineWidth',1.2)
xlim([0 Results.dist_log.Data(end)])
ylim([-5 105])
ylabel('rBrake')
subplot(4,1,4)
plot(Results.dist_log.Data,Results.Driver_Inputs.Steering_Wheel_Angle.Data,'b','LineWidth',1.2)
xlim([0 Results.dist_log.Data(end)])
ylabel('aSteeringWheel')
xlabel('sLap')
