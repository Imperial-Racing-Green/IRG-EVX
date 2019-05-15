clear
clc
% Compare two sims to understand and explain laptime difference
Sim1 = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\CoG_Test\Sim2.mat';
Sim2 = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\CoG_Test\Sim6.mat';

Results1 = load(Sim1);
Results2 = load(Sim2);

% Ensure time is same number of datapoints for both
t1 = Results1.dist_log.Time;
t2 = interp1(Results2.dist_log.Data,Results2.dist_log.Time,Results1.dist_log.Data);
tDiff = t1 - t2;

figure()
plot(Results1.dist_log.Data,Results1.vCar,'r','LineWidth',1.2)
hold on
plot(Results2.dist_log.Data,Results2.vCar,'b','LineWidth',1.2)
yyaxis right
plot(Results1.dist_log.Data,tDiff,'k')
ylabel('tDiff')
xlim([0 Results1.dist_log.Data(end)])
grid on
legend('Sim 1','Sim 2')