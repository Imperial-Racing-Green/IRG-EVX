function pacejka_coefs = Hoosier_43157
% pacejka model coefficients provided by Stackpole Engineering Services
% for Hoosier tyre model 43157
% as found in the document 'SES_FSAE_Tiredata_Rev1'
% Specs:
% Size	20.0x7.0-13
% Pressure 12 psi


Fzo =	1114.33; % N
Ro = 0.25400; % m

% [ALIGNING COEFFICIENTS]
q_Bz1 =	8.05767;
q_Bz2 =	-0.90260;
q_Bz3 =	-1.27703;
q_Bz4 =	9.46889;
q_Bz5 =	-9.61208;
q_Bz9 =	0;
q_Bz10 = 0;
q_Cz1 =	1.23262;
q_Dz1 =	0.16468;
q_Dz2 =	-0.02112;
q_Dz3 =	-0.22110;
q_Dz4 =	0.01845;
q_Dz6 =	-0.02369;
q_Dz7 =	0.01010;
q_Dz8 =	-1.30124;
q_Dz9 =	-0.46908;
q_Ez1 =	-3.42484;
q_Ez2 =	0.31303;
q_Ez3 =	-0.59871;
q_Ez4 =	0.37532;
q_Ez5 =	2.98462;
q_Hz1 =	0.00049;
q_Hz2 =	-0.00314;
q_Hz3 =	0.34253;
q_Hz4 =	0.33587;

%  [LATERAL COEFFICIENTS]
p_Cy1 =	1.80000;
p_Dy1 =	2.46777;
p_Dy2 =	-0.44804;
p_Dy3 =	7.41283;
p_Ey1 =	0.92778;
p_Ey2 =	0.02066;
p_Ey3 =	0.11837;
p_Ey4 =	-2.23440;
p_Ky1 =	-42.82784;
p_Ky2 =	-1.19632;
p_Ky3 =	2.19058;
p_Hy1 =	0.00030;
p_Hy2 =	-0.01001;
p_Hy3 =	-0.11887;
p_Vy1 =	-0.01529;
p_Vy2 =	0.05579;
p_Vy3 =	-0.21606;
p_Vy4 =	1.77057;

% [LONGITUDINAL COEFFICIENTS]
p_Cx1 = 1.50000;
p_Dx1 =	2.37310;
p_Dx2 =	-0.37921;
p_Ex1 =	0.40823;
p_Ex2 =	-0.06831;
p_Ex3 =	-0.87181;
p_Ex4 =	0.17103;
p_Kx1 =	47.24120;
p_Kx2 =	-14.89490;
p_Kx3 =	-0.13387;
p_Hx1 =	-0.00002;
p_Hx2 =	-0.00082;
p_Vx1 =	-0.02458;
p_Vx2 =	-0.04245;


% export coefficients in structure for ease of passing between functions
varList = who;
% initialiste oup_ut structure
pacejka_coefs = struct;

% add all existing variables to struture
for index = 1:numel(varList)
    pacejka_coefs.(varList{index}) = eval(varList{index});
end