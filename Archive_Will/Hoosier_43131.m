function [Fzo,Ro,q_Bz1,q_Bz2,q_Bz3,q_Bz4,q_Bz5,q_Bz9,q_Bz10,q_Cz1,q_Dz1,...
    q_Dz2,q_Dz3,q_Dz4,q_Dz6,q_Dz7,q_Dz8,q_Dz9,q_Ez1,q_Ez2,q_Ez3,q_Ez4,q_Ez5,...
    q_Hz1,q_Hz2,q_Hz3,q_Hz4,p_Cy1,p_Dy1,p_Dy2,p_Dy3,p_Ey1,p_Ey2,p_Ey3,...
    p_Ey4,p_Ky1,p_Ky2,p_Ky3,p_Hy1,p_Hy2,p_Hy3,p_Vy1,p_Vy2,p_Vy3,p_Vy4,...
    p_Cx1,p_Dx1,p_Dx2,p_Ex1,p_Ex2,p_Ex3,p_Ex4,p_Kx1,p_Kx2,p_Kx3,p_Hx1,...
    p_Hx2,p_Vx1,p_Vx2] = Hoosier_43131
% pacejka model coefficients provided by Stackpole Engineering Services
% for Hoosier tyre model 43131
% as found in the document 'SES_FSAE_Tiredata_Rev1'
% Specs:
% Size	20.0x6.0-13
% Pressure 12 psi


Fzo = 1114.01; % N
Ro = 0.25400; % m

% [ALIGNING COEFFICIENTS]
q_Bz1 =	7.31661;
q_Bz2 =	-1.88850;
q_Bz3 =	-1.22507;
q_Bz4 =	-8.00843;
q_Bz5 =	8.07362;
q_Bz9 =	0;
q_Bz10 = 0;
q_Cz1 =	1.24284;
q_Dz1 =	0.14936;
q_Dz2 =	-0.03781;
q_Dz3 =	0.64550;
q_Dz4 =	0.05268;
q_Dz6 =	-0.02434;
q_Dz7 =	0.01708;
q_Dz8 =	-1.08356;
q_Dz9 =	-0.40710;
q_Ez1 =	-3.38121;
q_Ez2 =	0.10261;
q_Ez3 =	-0.94450;
q_Ez4 =	0.36774;
q_Ez5 =	3.30689;
q_Hz1 =	-0.00061;
q_Hz2 =	-0.00550;
q_Hz3 =	0.38752;
q_Hz4 =	0.43969;

%  [LATERAL COEFFICIENTS]
p_Cy1 =	1.80000;
p_Dy1 =	2.45700;
p_Dy2 =	-0.59060;
p_Dy3 =	11.58940;
p_Ey1 =	0.97472;
p_Ey2 =	0.04076;
p_Ey3 =	0.11095;
p_Ey4 =	-1.20038;
p_Ky1 =	-37.72991;
p_Ky2 =	-1.22482;
p_Ky3 =	1.90662;
p_Hy1 =	0.00081;
p_Hy2 =	-0.00938;
p_Hy3 =	-0.12520;
p_Vy1 =	-0.01307;
p_Vy2 =	0.00121;
p_Vy3 =	-0.21872;
p_Vy4 =	1.77405;

% [LONGITUDINAL COEFFICIENTS]
p_Cx1 =  1.50000;
p_Dx1 =	2.22960;
p_Dx2 =	-0.26506;
p_Ex1 =	0.34731;
p_Ex2 =	-0.36673;
p_Ex3 =	-0.28130;
p_Ex4 =	-0.05543;
p_Kx1 =	46.06520;
p_Kx2 =	-29.43060;
p_Kx3 =	-0.45644;
p_Hx1 =	-0.00087;
p_Hx2 =	-0.00179;
p_Vx1 =	0.00295;
p_Vx2 =	-0.04174;


% export coefficients in structure for ease of passing between functions
% varList = who;
% initialiste oup_ut structure
% pacejka_coefs = struct;

% add all existing variables to struture
% for index = 1:numel(varList)
%     pacejka_coefs.(varList{index}) = eval(varList{index});
% end