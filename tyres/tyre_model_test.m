close all
load("Z:\Formula Student Team 2017-18\FS Previous Vehicles\Tyre Test Consortium Data\Round 6\RunData_13inch_Cornering_Matlab_SI\B1654run2.mat")

idx6 = FZ>-750 & FZ < -500;

SAplot = SA(idx6);
FYplot = FY(idx6);

figure(1);
scatter(-SAplot,FYplot)
hold on

coef = [2 1 12.5 1.55];
model_input = [0.0174533*SAplot, -650*ones(length(SAplot),1)];
% FYtest = Pacejka4_Model(coef,model_input);
% scatter(SAplot,FYtest)
for i = 1:length(SAplot)
    fy(i) = fx_model(0.0174533*SAplot(i),650);
end
scatter(SAplot,fy)



