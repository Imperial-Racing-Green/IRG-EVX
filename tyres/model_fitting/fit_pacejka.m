function [coef] = fit_pacejka(xdata,ydata)
%FIT_PACEJKA Summary of this function goes here
%   Detailed explanation goes here

init_B = 6.9;
init_C = 3.1;
init_D = 700;
init_E = 1.5;
init_Sv = 0;
init_Sh = 0;
init_coef = [init_B, init_C, init_D, init_E, init_Sv, init_Sh];

coef = lsqcurvefit(@pacejka4,init_coef,xdata,ydata);
end

