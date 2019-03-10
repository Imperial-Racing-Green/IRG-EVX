clear
close all

% Hoosier 10" Lateral
filename_lat = "C:\Users\Owen Heaney\Documents\FSAE TTC Data\RunData_10inch_Cornering_Matlab_SI\B1654run21.mat";

%Hoosier 10" Longitudinal & Combined
filename_long = "Z:\Tyre Test Consortium Data\Round 6\RunData_10inch_DriveBrake_Matlab_SI\B1654run35.mat";

tyre_model = EVX_tyre(filename_lat, filename_long);

% coef_long = tyre_model.fit_coefficients(filename_long)

tyre_model = tyre_model.make_full_model()