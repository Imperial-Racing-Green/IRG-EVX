clear
clc
% Breakdown of the main ouput params the lapsim
Sim = 'C:\Users\Ila\OneDrive for Business\Year 3\GDP\Test1_CoG';

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
