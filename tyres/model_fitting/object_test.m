clear
close all

% Hoosier 10" Lateral
filename_lat = "C:\Users\Owen Heaney\Documents\FSAE TTC Data\RunData_10inch_Cornering_Matlab_SI\B1654run21.mat";

%Hoosier 10" Longitudinal & Combined
filename_long = "Z:\Tyre Test Consortium Data\Round 6\RunData_10inch_DriveBrake_Matlab_SI\B1654run35.mat";

tyre_model = EVX_tyre(filename_lat, filename_long);
tyre_model.verbosity = 0;

% coef_long = tyre_model.fit_coefficients(filename_long)

tyre_model = tyre_model.make_full_model();

[X1, X2, X3] = ndgrid(unique(tyre_model.testcases_lat(:,1)),...
    unique(tyre_model.testcases_lat(:,3)), unique(tyre_model.testcases_lat(:,2)));

for i = 1:6
    coefs_out(i) = tyre_model.lateral_model{i}(84,4,180);
end

figure(1)
coefs = {'B','C','D','E','Sv','Sh'};
for i = 1:length(tyre_model.lateral_model)
    x = linspace(tyre_model.lateral_model{i}.GridVectors{3}(1),tyre_model.lateral_model{i}.GridVectors{3}(end),100);
    y = linspace(tyre_model.lateral_model{i}.GridVectors{2}(1),tyre_model.lateral_model{i}.GridVectors{2}(end),100);
    
    [x_fit,y_fit] = meshgrid(x,y);
    coef = tyre_model.lateral_model{i}(84*ones(100),y_fit,x_fit);
    
    x_test = tyre_model.lateral_model{i}.GridVectors{3};
    y_test = tyre_model.lateral_model{i}.GridVectors{2};
    [x_test, y_test] = meshgrid(x_test,y_test);
    coef_test = squeeze(tyre_model.lateral_model{i}.Values(2,:,:));
    
    subplot(2,3,i)
    hold on
    contourf(x_fit,y_fit,coef)
    colorbar;
    title(coefs{i})
    %     scatter3(x_test,y_test,coef_test)
end

figure(2)
coefs = {'B','C','D','E','Sv','Sh'};
for i = 1:length(tyre_model.longitudinal_model)
    for j = 1:length(tyre_model.longitudinal_model{i})
        figure(j)
        x = linspace(tyre_model.longitudinal_model{i}.GridVectors{3}(1),tyre_model.longitudinal_model{i}.GridVectors{3}(end),100);
        y = linspace(tyre_model.longitudinal_model{i}.GridVectors{2}(1),tyre_model.longitudinal_model{i}.GridVectors{2}(end),100);
        
        [x_fit,y_fit] = meshgrid(x,y);
        coef = tyre_model.longitudinal_model{i}(84*ones(100),y_fit,x_fit);
        
        x_test = tyre_model.longitudinal_model{i}.GridVectors{3};
        y_test = tyre_model.longitudinal_model{i}.GridVectors{2};
        [x_test, y_test] = meshgrid(x_test,y_test);
        coef_test = squeeze(tyre_model.longitudinal_model{i}.Values(2,:,:));
        
        subplot(2,3,i)
        hold on
        contourf(x_fit,y_fit,coef)
        colorbar;
        title(coefs{i})
        %     scatter3(x_test,y_test,coef_test)
    end
end
load(fullfile(pwd,'tyres','tyre_profile_lap.mat'))
close
figure
[b,a] = butter(6,0.35);

fz_FL = filter(b,a,fz_prof.Data(:,1));
sa_FL = filter(b,a,sa_prof.Data(:,1));
sr_FL = filter(b,a,sr_prof.Data(:,1));
subplot(311)
plot(fz_prof.Time,fz_FL)
subplot(312)
plot(sa_prof.Time,sa_FL)
subplot(313)
plot(sr_prof.Time,sr_FL)