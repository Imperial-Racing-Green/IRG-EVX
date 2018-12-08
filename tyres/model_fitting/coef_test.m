close all

SAplot = S_binfzia{i,n,m};
FYplot = F_binfzia{i,n,m};

figure(1);
scatter(-SAplot,FYplot)
hold on

coef = fit_pacejka(-SAplot,FYplot);
% coef = [6.9,3.1,700,1.5,-0.5,0.002];
% FYtest = Pacejka4_Model(coef,model_input);
% scatter(SAplot,FYtest)
for idx = 1:length(SAplot)
    fy(idx) = pacejka4(coef,SAplot(idx));
end
scatter(SAplot,fy)