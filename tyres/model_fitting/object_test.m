clear
close all

try
    % Hoosier 10" Lateral
    filename_lat = "C:\Users\Owen Heaney\Documents\FSAE TTC Data\RunData_10inch_Cornering_Matlab_SI\B1654run21.mat";
    load(filename_lat)
catch
    warning("Unable to find lateral data file")
    filename_lat = input("Please enter lateral data file path: ",'s');
end

try
    %Hoosier 10" Longitudinal & Combined
    filename_long = "C:\Users\Owen Heaney\Documents\FSAE TTC Data\RunData_10inch_DriveBrake_Matlab_SI\B1654run35.mat";
    load(filename_long)
catch
    warning("Unable to find longitudinal data file")
    filename_long = input("Please enter longitudinal data file path: ",'s');
end
tyre_model = EVX_tyre(filename_lat, filename_long);
tyre_model.verbosity = 0;

tyre_model = tyre_model.make_full_model();

[X1, X2, X3] = ndgrid(unique(tyre_model.testcases_lat(:,1)),...
    unique(tyre_model.testcases_lat(:,3)), unique(tyre_model.testcases_lat(:,2)));

% for i = 1:6
%     coefs_out(i) = tyre_model.lateral_model{i}(84,4,180);
% end

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
    contourf(x_fit,y_fit,coef)
    colorbar;
    title(coefs{i})
    %     scatter3(x_test,y_test,coef_test)
end

figure(2)
for i = 1:length(tyre_model.longitudinal_model)
    for j = 1:length(tyre_model.longitudinal_model{i})
%         figure(j)
        x = linspace(tyre_model.longitudinal_model{i}.GridVectors{3}(1),tyre_model.longitudinal_model{i}.GridVectors{3}(end),100);
        y = linspace(tyre_model.longitudinal_model{i}.GridVectors{2}(1),tyre_model.longitudinal_model{i}.GridVectors{2}(end),100);
        
        [x_fit,y_fit] = meshgrid(x,y);
        coef = tyre_model.longitudinal_model{i}(84*ones(100),y_fit,x_fit);
        
        x_test = tyre_model.longitudinal_model{i}.GridVectors{3};
        y_test = tyre_model.longitudinal_model{i}.GridVectors{2};
        [x_test, y_test] = meshgrid(x_test,y_test);
        coef_test = squeeze(tyre_model.longitudinal_model{i}.Values(2,:,:));
        
        subplot(2,3,i)
        contourf(x_fit,y_fit,coef)
        colorbar;
        title(coefs{i})
        %     scatter3(x_test,y_test,coef_test)
    end
end

% load(fullfile(pwd,'tyres','tyre_profile_lap.mat'))
% 
% figure
% [b,a] = butter(6,0.35);
% 
% fz_FL = filter(b,a,fz_prof.Data(:,1));
% sa_FL = filter(b,a,sa_prof.Data(:,1));
% sr_FL = filter(b,a,sr_prof.Data(:,1));
% subplot(311)
% plot(fz_prof.Time,fz_FL)
% subplot(312)
% plot(sa_prof.Time,sa_FL)
% subplot(313)
% plot(sr_prof.Time,sr_FL)
% 
% 
% P = 84*ones(length(fz_FL),1);
% IA = 2*ones(length(fz_FL),1);
% figure
% [Fx, Fy, Mz] = tyre_model.get_forces(sr_FL,sa_FL,P,IA,fz_FL);
% subplot(211)
% plot(fz_prof.Time,Fx)
% subplot(212)
% plot(fz_prof.Time,Fy)
% 

x = -0.4:0.005:0.4;
y = -0.3:0.005:0.3;
x = x/0.0174533;
[x,y] = meshgrid(x,y);

for i = 1:size(x,1)
    for j = 1:size(x,2)
        [FX_model(i,j),FY_model(i,j),~] = tyre_model.get_forces(y(i,j),x(i,j),84,0,-1080);
    end
end

load(filename_long)
load([pwd '\tyres\model_fitting\models\combined_bins.mat'])

bin = P_bin(:,2) & IA_bin(:,1) & FZ_bin(:,4);% & SA_bin(:,);

figure
subplot(121)
% contourf(x,y,FX_model)
surf(x,y,FX_model,'EdgeColor','none')
% colorbar
hold on
% scatter3(-SA(bin),SR(bin),FX(bin))
xlabel('Slip Angle [deg]')
ylabel('Slip Ratio [-]')
zlabel('Longitudinal Force [N]')
title('Combined Longitudinal Force')
axis vis3d

% figure
subplot(122)
% contourf(x,y,FY)
surf(x,y,FY_model,'EdgeColor','none')
% colorbar
hold on
% scatter3(-SA(bin),SR(bin),FY(bin))
xlabel('Slip Angle [deg]')
ylabel('Slip Ratio [-]')
zlabel('Lateral Force [N]')
title('Combined Lateral Force')
axis vis3d

figure
F_tot = sqrt(FX_model.^2 + FY_model.^2);
surf(x,y,F_tot,'EdgeColor','none')
% contourf(x,y,F_tot,0:100:2500)
colorbar
xlabel('Slip Angle [deg]')
ylabel('Slip Ratio [-]')
zlabel('Combined Force [N]')
title('Combined Force Magnitude')
axis vis3d
% 
% figure
% S = sqrt(y.^2 + (0.0174533*x).^2);
% F_rel = F_tot./S;
% % surf(x,y,F_tot)
% contourf(x,y,F_rel)
% colorbar
% xlabel('Slip Angle [deg]')
% ylabel('Slip Ratio [-]')
% zlabel('Combined Force [N]')
% title('Combined Force Magnitude')
% % axis vis3d

figure
plot(x',FX_model')

figure
for i = 1:length(SA_binvalues)
    
    
end