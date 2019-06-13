figure
SLAP = [0:1000/699:1000]';
plot(SLAP,Camber.FL,'linewidth',1.3);
xlabel('sLap (m)')
ylabel('Camber angle (deg)')
set(gca,'FontSize',20)
grid on 
box on 


figure
SLAP = [0:1000/699:1000]';
plot(SLAP,Camber.RL,'linewidth',1.3);
xlabel('sLap (m)')
ylabel('Camber angle (deg)')
set(gca,'FontSize',20)
grid on 
box on 

figure
SLAP = [0:1000/699:1000]';
yyaxis left 
plot(SLAP,hRideF,'linewidth',1.2);
xlabel('sLap (m)')
ylabel('Ride Height (m)')
yyaxis right 
plot(SLAP,vCar,'linewidth',1.3);
ylabel('vCar (m/s)')
set(gca,'FontSize',20)
hold on 
grid on 
box on 


figure
SLAP = [0:1000/699:1000]';
yyaxis left 
plot(SLAP,hRideR,'linewidth',1.2);
xlabel('sLap (m)')
ylabel('Ride Height (m)')
yyaxis right 
plot(SLAP,vCar,'linewidth',1.3);
ylabel('vCar (m/s)')
set(gca,'FontSize',20)
hold on 
grid on 
box on 
