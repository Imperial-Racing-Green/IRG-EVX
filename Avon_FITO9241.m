function pacejka_coefs = Avon_FITO9241
% pacejka model coefficients provided by Stackpole Engineering Services
% for Avon tyre model FITO 9241
% as found in the document 'SES_FSAE_Tiredata_Rev3'
% Specs:
% Size	6.2/20-13
% Pressure 12 psi


Fzo =	1122.74; % N
Ro = 0.25400; % m

% [ALIGNING COEFFICIENTS]
q_Bz1 =	6.11547;
q_Bz2 =	-1.96461;
q_Bz3 =	1.02155;
q_Bz4 =	5.41323;
q_Bz5 =	-7.58049;
q_Bz9 =	0;
q_Bz10 = 0;
q_Cz1 =	1.25000;
q_Dz1 =	0.15275;
q_Dz2 =	-0.00637;
q_Dz3 =	-0.21282;
q_Dz4 =	0.02719;
q_Dz6 =	-0.00145;
q_Dz7 =	0.01039;
q_Dz8 =	-1.03566;
q_Dz9 =	0.24508;
q_Ez1 =	-4.00001;
q_Ez2 =	0;
q_Ez3 =	0.00003;
q_Ez4 =	0.29616;
q_Ez5 =	2.43287;
q_Hz1 =	-0.00124;
q_Hz2 =	-0.00769;
q_Hz3 =	0.49190;
q_Hz4 =	0.13660;

%  [LATERAL COEFFICIENTS]
p_Cy1 =	0.95232;
p_Dy1 =	2.65462;
p_Dy2 =	0.05198;
p_Dy3 =	-13.51679;
p_Ey1 =	0.29170;
p_Ey2 =	0.30617;
p_Ey3 =	-0.53331;
p_Ey4 =	1.52410;
p_Ky1 =	-27.31900;
p_Ky2 =	-1.06469;
p_Ky3 =	2.27460;
p_Hy1 =	0.00227;
p_Hy2 =	-0.00772;
p_Hy3 =	-0.12814;
p_Vy1 =	0.14237;
p_Vy2 =	-0.17287;
p_Vy3 =	-1.49583;
p_Vy4 =	4.55061;

% [LONGITUDINAL COEFFICIENTS]
p_Cx1 = 1.43990;
p_Dx1 =	2.59060;
p_Dx2 =	-0.36627;
p_Ex1 =	-0.24355;
p_Ex2 =	-0.66953;
p_Ex3 =	-3.71110;
p_Ex4 =	0.37836;
p_Kx1 =	36.76960;
p_Kx2 =	-23.37320;
p_Kx3 =	-0.45230;
p_Hx1 =	0.00098;
p_Hx2 =	0.00014;
p_Vx1 =	-0.04913;
p_Vx2 =	0.02482;


% export coefficients in structure for ease of passing between functions
varList = who;
% initialiste oup_ut structure
pacejka_coefs = struct;

% add all existing variables to struture
for index = 1:numel(varList)
    pacejka_coefs.(varList{index}) = eval(varList{index});
end