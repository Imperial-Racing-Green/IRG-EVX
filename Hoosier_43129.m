function pacejka_coefs = Hoosier_43129
% pacejka model coefficients provided by Stackpole Engineering Services
% for Hoosier tyre model 43129
% as found in the document 'SES_FSAE_Tiredata_Rev3'
% Specs:
% Size	20.5x7.0-13
% Pressure 12 psi


Fzo =	1119.86; % N
Ro = 0.26035; % m

% [ALIGNING COEFFICIENTS]
q_Bz1 =	8.20097;
q_Bz2 =	-0.81187;
q_Bz3 =	-1.39160;
q_Bz4 =	-2.03608;
q_Bz5 =	1.76730;
q_Bz9 =	0;
q_Bz10 = 0;
q_Cz1 =	1.21742;
q_Dz1 =	0.12387;
q_Dz2 =	-0.00441;
q_Dz3 =	3.71513;
q_Dz4 =	-0.30389;
q_Dz6 =	-0.02303;
q_Dz7 =	0.01412;
q_Dz8 =	-1.38052;
q_Dz9 =	-0.30632;
q_Ez1 =	-3.42732;
q_Ez2 =	0.32223;
q_Ez3 =	-0.71320;
q_Ez4 =	0.36898;
q_Ez5 =	4.06263;
q_Hz1 =	0.00271;
q_Hz2 =	-0.00433;
q_Hz3 =	0.41543;
q_Hz4 =	0.26212;

%  [LATERAL COEFFICIENTS]
p_Cy1 =	1.46534;
p_Dy1 =	2.39549;
p_Dy2 =	-0.28384;
p_Dy3 =	0.44384;
p_Ey1 =	0.42817;
p_Ey2 =	-0.03266;
p_Ey3 =	0.26610;
p_Ey4 =	0.99147;
p_Ky1 =	-46.36790;
p_Ky2 =	-1.25469;
p_Ky3 =	2.35083;
p_Hy1 =	0.00080;
p_Hy2 =	-0.00590;
p_Hy3 =	-0.08210;
p_Vy1 =	-0.03118;
p_Vy2 =	0.00632;
p_Vy3 =	-1.58583;
p_Vy4 =	3.13134;

% [LONGITUDINAL COEFFICIENTS]
p_Cx1 = 1.48640;
p_Dx1 =	2.46440;
p_Dx2 =	-0.35740;
p_Ex1 =	0.29284;
p_Ex2 =	-1.03280;
p_Ex3 =	0.02377;
p_Ex4 =	0.48820;
p_Kx1 =	60.24040;
p_Kx2 =	0.00004;
p_Kx3 =	0.15421;
p_Hx1 =	-0.00002;
p_Hx2 =	0.00084;
p_Vx1 =	-0.05729;
p_Vx2 =	0.14240;


% export coefficients in structure for ease of passing between functions
varList = who;
% initialiste oup_ut structure
pacejka_coefs = struct;

% add all existing variables to struture
for index = 1:numel(varList)
    pacejka_coefs.(varList{index}) = eval(varList{index});
end