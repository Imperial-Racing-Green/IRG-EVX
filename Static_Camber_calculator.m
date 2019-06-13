%Script for Big Nik to work out static Camber 

load('C:\Users\Ila\OneDrive for Business\Year 3\GDP\Pres_week_5\Sim1.mat');
%% FRONT
peaks_FL=findpeaks(Camber.FL);

j=0;

for i=1:length(peaks_FL)
    if peaks_FL(i)>0.35
        j=j+1;
        actual_peaks_FL(j)=peaks_FL(i);
    end     
end 

Static_camber_FL=mean(actual_peaks_FL);


%% REAR 
peaks_RL=findpeaks(Camber.RL);

j=0;

for i=1:length(peaks_RL)
    if peaks_RL(i)>0.75
        j=j+1;
        actual_peaks_RL(j)=peaks_RL(i);
    end     
end 

Static_camber_RL=mean(actual_peaks_RL);


