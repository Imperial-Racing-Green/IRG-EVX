clear
close all

tic

phi_0 = 1e-6;
speed_kph = 30;
speed = 0.277778 * speed_kph; %m/s

m_chassis = 300;
I_chassis = 100;
m_unsprung_f = 2*12;
m_unsprung_r = 2*12;

wheelbase = 1.550;
percent_front = 0.5;
a = wheelbase*percent_front;
b = wheelbase*(1-percent_front);

t_delay = wheelbase/speed;

k_front = 2*61294;
f_preload_f = 2*100;

k_rear = 2*61294;
f_preload_r = 2*100;

k_tyre_f = 2*80000;
k_tyre_r = 2*80000;
c_tyre_f = 2*51.4;
c_tyre_r = 2*51.4;

MR_f = 1.28;
MR_r = 1.35;

DamperFit;
object_test;

[z_r, t] = generate_road_profile(phi_0,speed,1,5000,1,0.01,100);
z_r = z_r - z_r(1);
plot(t,z_r)
xlabel('Time [s]')
ylabel('z_R [m]')

z_r = 1000*z_r; %Convert to mm
z_0 = z_r(1);
% z_r = [z_r zeros(1,200)];
% t = linspace(1,t(end),length(t)+200);
road_profile = timeseries(z_r,t);

figure
x = z_r;
Fs = mean(diff(t));
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = ((Fs*N)/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;

loglog((freq),(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

sim_options = struct();
sim_options.SaveState = 'off';
sim_options.StateSaveName = 'xout';
sim_options.SaveOutput = 'off';
sim_options.OutputSaveName = 'yout';
sim_options.SaveFormat = 'Dataset';
sim_options.CaptureErrors = 'on';
sim_options.SrcWorkspace = 'current';

P = 84;
IA = 2;
for i = 1:length(fits)
    for j = 1:length(fits)
        v_damper_f = fits(i).Lookup_Values(1,:);
        f_damper_f = 2*fits(i).Lookup_Values(2,:); %Double force because 2 dampers
        
        v_damper_r = 2*fits(j).Lookup_Values(1,:);
        f_damper_r = 2*fits(j).Lookup_Values(2,:);
        sim_result = sim('ride_model.slx',sim_options);
        sim_result.SimulationMetadata.UserString = [fits(i).name ' - ' fits(j).name];
        
        
        F_tyre_f_mean = mean(sim_result.F_tyre_f.Data)/2;
        [~, F_lat_ideal_f(i,j)] = tyre_mu_lat(tyre_model,P,IA,abs(F_tyre_f_mean));
        [~, F_long_ideal_f(i,j)] = tyre_mu_long(tyre_model,P,IA,abs(F_tyre_f_mean));
        for idx = 1:length(sim_result.tout)
            [~,F_lat_f(i,j,idx)] = tyre_mu_lat(tyre_model,P,IA,abs(sim_result.F_tyre_f.Data(idx)/2));
            [~,F_long_f(i,j,idx)] = tyre_mu_long(tyre_model,P,IA,abs(sim_result.F_tyre_f.Data(idx)/2));
        end
        
        F_tyre_r_mean = mean(sim_result.F_tyre_r.Data)/2;
        [~, F_lat_ideal_r(i,j)] = tyre_mu_lat(tyre_model,P,IA,abs(F_tyre_r_mean));
        [~, F_long_ideal_r(i,j)] = tyre_mu_long(tyre_model,P,IA,abs(F_tyre_r_mean));
        for idx = 1:length(sim_result.tout)
            [~,F_lat_r(i,j,idx)] = tyre_mu_lat(tyre_model,P,IA,abs(sim_result.F_tyre_r.Data(idx)/2));
            [~,F_long_r(i,j,idx)] = tyre_mu_long(tyre_model,P,IA,abs(sim_result.F_tyre_r.Data(idx)/2));
        end
        
        tyre_forces(i,j).F_tyre_f_mean = F_tyre_f_mean;
        tyre_forces(i,j).F_lat_ideal_f = F_lat_ideal_f;
        tyre_forces(i,j).F_long_ideal_f = F_long_ideal_f;
        tyre_forces(i,j).F_lat_f = F_lat_f;
        tyre_forces(i,j).F_long_f = F_long_f;
        
        tyre_forces(i,j).F_tyre_r_mean = F_tyre_r_mean;
        tyre_forces(i,j).F_lat_ideal_r = F_lat_ideal_r;
        tyre_forces(i,j).F_long_ideal_r = F_long_ideal_r;
        tyre_forces(i,j).F_lat_r = F_lat_r;
        tyre_forces(i,j).F_long_r = F_long_r;
        tyre_forces(i,j).name = [fits(i).name ' - ' fits(j).name];
        
%         sim_result.SimulationMetadata = tyre_forces;
        
        save(['C:\Users\Owen Heaney\Documents\FYP\Ride Sims\03.06.19\A-Grade\' sim_result.SimulationMetadata.UserString '.mat'],'sim_result')
    end
end

for i = 1:length(fits)
    for j = 1:length(fits)
        tyre_forces(i,j).F_lat_mean_f = mean(squeeze(F_lat_f(i,j,:)));
        tyre_forces(i,j).F_long_mean_f = mean(squeeze(F_long_f(i,j,:)));
        
        tyre_forces(i,j).F_lat_mean_r = mean(squeeze(F_lat_r(i,j,:)));
        tyre_forces(i,j).F_long_mean_r = mean(squeeze(F_long_r(i,j,:)));
    end
end
toc

save('C:\Users\Owen Heaney\Documents\FYP\Ride Sims\03.06.19\tyre_forces (A-Grade).mat','tyre_forces')
% for i = 1:length(fits)
%     for j = 1:length(fits)
%         sim.SimulationMetadata.UserString = [fits(i).name ' - ' fits(j).name];
%     end
% end