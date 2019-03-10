function [coef, resnorm, residual] = fit_pacejka(xdata,ydata,datatype)
%FIT_PACEJKA Summary of this function goes here
%   Detailed explanation goes here

if strcmp(datatype, 'lat')
    init_B = 6;
    init_C = 1.4;
    init_D = 0.9*max(ydata);
    init_E = 1.12;
    init_Sv = 0;
    init_Sh = 0;
    init_coef = [init_B, init_C, init_D, init_E, init_Sv, init_Sh];
elseif strcmp(datatype, 'long')
    init_B = 6;
    init_C = 1.4;
    init_D = 0.9*max(ydata);
    init_E = 1.12;
    init_Sv = 0;
    init_Sh = 0;
    init_coef = [init_B, init_C, init_D, init_E, init_Sv, init_Sh];
end



opts = optimset('MaxFunEvals',10000,'MaxIter',2000,'TolX',0.000001,'TolFun',1e-8,'UseParallel',false,'Display','off');
[coef, resnorm, residual] = lsqcurvefit(@pacejka4,init_coef,xdata,ydata,[],[],opts);
end

