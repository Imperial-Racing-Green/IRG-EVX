function [Fxo,Fyo,Mzo] = Pacejka_Tyre_Model(Fz,kappa,alpha,gam,car,track_conditions)
% Pacejka '96 tyre model
%
% Inputs:
% Fz:       normal force (N)
% kappa:    slip ratio (% between -1 and 1) +ve is driving, -ve is braking
% alpha:    slip angle (rad) +ve alpha generates +ve Fyo
% gam:      inclanation angle./camber (rad) +ve indicates top of tyre tipped
%           right
% Outputs:
% Fxo:      Longitudinal force (N)
% Fyo:      Lateral force (N)
% Mzo:      Aligning moment (Nm)


%% tyre coefficients
% each different type of tyre holds different scaling coefficients, load 
% these here. Also loaded are unloaded tyre radius and nominal wheel load

% unpack the structure holding the coefficients
% Get the field names of the structure.
fields = fieldnames(car.Coefficients.Pacejka, '-full');

for ii = 1:length(fields)
    thisField = fields{ii};
    create_variable = sprintf('%s = car.Coefficients.Pacejka.%s;', thisField, thisField);
    eval(create_variable);
end
clear('ii', 'thisField');
clear('fields', 'create_variable');

%% register track conditions
% scaling factors affected by wet/dry conditions
if strcmp(track_conditions,'dry')
    lambda_mux = 1; % peak friction coefficient
    lambda_muy = 1; % peak friction coefficient
elseif strcmp(track_conditions,'wet')
    lambda_mux = 0.5; % peak friction coefficient
    lambda_muy = 0.5; % peak friction coefficient
else
    fprintf('Track conditions incorrectly specified: dry condtitions used \n');
    lambda_mux = 1; % peak friction coefficient
    lambda_muy = 1; % peak friction coefficient
end

% modify with user scaling factor
lambda_mux = lambda_mux*car.GripScale;
lambda_muy = lambda_muy*car.GripScale;

%% scaling factors
% default values for these values is 1 (except lambda_muV=0)
lambda_Fzo = 1; % nominal rated load
lambda_muV = 0; % with slip speed Vx decaying friction
lambda_Kx = 1; % brake slip stiffness
lambda_Ky = 1; % cornering stiffness
lambda_Cx = 1; % shape factor
lambda_Cy = 1; % shape factor
lambda_Ex = 1; % curvature factor
lambda_Ey = 1; % curvature factor
lambda_Hx = 1; % horizontal shift
lambda_Hy = 1; % horizontal shift
lambda_Vx = 1; % vertical shift
lambda_Vy = 1; % vertical shift
lambda_Kygam = 1; % camber force stiffness
lambda_Kzgam = 1; % camber torque stiffness
lambda_t = 1; % pneumatic trail
lambda_Mr = 1; % residual torque
lambda_ygam = 1;

% if ~isrow(kappa) || ~isrow(alpha) || ~isrow(gam)
%     kappa = transpose(kappa);
%     alpha = transpose(alpha);
%     gam = transpose(gam);
% end

%% derived inputs
dfz = (Fz-Fzo)./Fzo; % normalised change in vertical load

%% longitudinal force (pure longitudinal slip)
S_Vx = Fz.*(p_Vx1+p_Vx2.*dfz).*lambda_Vx.*lambda_mux;
S_Hx = (p_Hx1+p_Hx2.*dfz).*lambda_Hx;
kappa_x = kappa + S_Hx;
K_xk = Fz.*(p_Kx1+p_Kx2.*dfz).*exp(-p_Kx3.*dfz).*lambda_Kx;
E_x = (p_Ex1+p_Ex2.*dfz+p_Ex3.*dfz.^2).*(1-p_Ex4.*sign(kappa_x)).*lambda_Ex;
mu_x = (p_Dx1+p_Dx2.*dfz).*lambda_mux;
D_x = mu_x.*Fz;
C_x = p_Cx1.*lambda_Cx;
B_x = K_xk./(C_x.*D_x);
Fxo = D_x.*sin(C_x.*atan(B_x.*kappa_x - E_x.*(B_x.*kappa_x-atan(B_x.*kappa_x)))) + S_Vx;

%% lateral force (pure lateral slip)
gam_y = gam.*lambda_ygam;
C_y = p_Cy1.*lambda_Cy;
mu_y = (p_Dy1+p_Dy2.*dfz).*(1-p_Dy3.*gam.^2).*lambda_muy;
D_y = mu_y.*Fz;
S_Hy = (p_Hy1+p_Hy2.*dfz+p_Hy3.*gam).*lambda_Hy;
alpha_y = alpha + S_Hy;
E_y = (p_Ey1+p_Ey2.*dfz).*(1-(p_Ey3+p_Ey4.*gam_y).*sign(alpha_y)).*lambda_Ey;
K_ya = p_Ky1.*Fzo.*sin(2.*atan(Fz./(p_Ky2.*Fzo.*lambda_Fzo))).*(1-p_Ky3.*abs(gam)).*lambda_Fzo.*lambda_Ky;
B_y = K_ya./(C_y.*D_y);
S_Vy = Fz.*((p_Vy1+p_Vy2.*dfz)+(p_Vy3+p_Vy4.*dfz).*gam.*lambda_Vy.*lambda_Kygam);
Fyo = D_y.*sin(C_y.*atan(B_y.*alpha_y - E_y.*(B_y.*alpha_y-atan(B_y.*alpha_y)))) + S_Vy;

%% aligning torque (pure side slip)
B_t = (q_Bz1+q_Bz2.*dfz+q_Bz3.*dfz.^2).*(1+q_Bz4.*gam.*q_Bz5.*abs(gam)).*lambda_Ky./lambda_muy;
C_t = q_Cz1;
D_t = (q_Dz1+q_Dz2.*dfz).*(1+q_Dz3.*gam+q_Dz4.*gam.^2).*Ro.*lambda_t./Fzo;
S_Ht = q_Hz1+q_Hz2.*dfz+(q_Hz3+q_Hz4.*dfz).*gam;
alpha_t = alpha + S_Ht;
E_t = (q_Ez1+q_Ez2.*dfz+q_Ez3.*dfz.^2).*(1+(q_Ez4+q_Ez5.*gam).*atan(B_t.*C_t.*alpha_t));
B_r = (q_Bz9.*lambda_Ky./lambda_muy+q_Bz10.*B_y.*C_y);
D_r = Fz.*((q_Dz6+q_Dz7.*dfz)+(q_Dz8+q_Dz9.*dfz).*gam).*Ro.*lambda_muy.*lambda_Mr;
S_Hf = S_Hy + S_Vy./K_ya;
alpha_r = alpha + S_Hf;
Mzr = D_r.*cos(atan(B_r.*alpha_r)).*cos(alpha);
t = D_t.*cos(C_t.*atan(B_t.*alpha_t-E_t.*(B_t.*alpha_t-atan(B_t.*alpha_t)))).*cos(alpha);
Mzo = -t.*Fyo + Mzr;

% %% Combined forces
% Fx0_abs = abs(Fxo);
% Fy0_abs = abs(Fyo);
% Fy = Fyo.*sqrt(1-((Fxo/max(Fx0_abs(:)))^2));
% Fx = Fxo.*sqrt(1-((Fyo/max(Fy0_abs(:)))^2));
% Fyo = Fy;
% Fxo = Fx;
    
end