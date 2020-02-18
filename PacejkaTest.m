function [Fx,Fy,Mz] = PacejkaTest(Tyre,SA,SL,Fz,IA)
%% Pacejka '96 model using dynamic lookup coefficients obtained in Owen Heaney's FYP

S_x = SL./(1+SL);
S_y = tand(SA)./(1+SL); % Alpha should be equal to alpha + Sh_y
S = sqrt((S_x.^2) + (S_y.^2));

% Interpolate the dynamic longitudinal/later pacejka coefficients:
% B - Stiffness factor
% C - Shape factor
% D - Peak value
% E - Curvature factor
% Sv - Vertical shift
% Sh - Horizontal shift

InterpMethod = 'spline';
MethodFlag = 1;

%% Longitudinal force
B_x = interp2(Tyre.Coefficients.Pacejka.Longitudinal.B.Fz,Tyre.Coefficients.Pacejka.Longitudinal.B.IA,Tyre.Coefficients.Pacejka.Longitudinal.B.B,Fz,-IA,InterpMethod);
C_x = interp2(Tyre.Coefficients.Pacejka.Longitudinal.C.Fz,Tyre.Coefficients.Pacejka.Longitudinal.C.IA,Tyre.Coefficients.Pacejka.Longitudinal.C.C,Fz,-IA,InterpMethod);
D_x = interp2(Tyre.Coefficients.Pacejka.Longitudinal.D.Fz,Tyre.Coefficients.Pacejka.Longitudinal.D.IA,Tyre.Coefficients.Pacejka.Longitudinal.D.D,Fz,-IA,InterpMethod);
E_x = interp2(Tyre.Coefficients.Pacejka.Longitudinal.E.Fz,Tyre.Coefficients.Pacejka.Longitudinal.E.IA,Tyre.Coefficients.Pacejka.Longitudinal.E.E,Fz,-IA,InterpMethod);
Sv_x = interp2(Tyre.Coefficients.Pacejka.Longitudinal.Sv.Fz,Tyre.Coefficients.Pacejka.Longitudinal.Sv.IA,Tyre.Coefficients.Pacejka.Longitudinal.Sv.Sv,Fz,-IA,InterpMethod);
Sh_x = interp2(Tyre.Coefficients.Pacejka.Longitudinal.Sh.Fz,Tyre.Coefficients.Pacejka.Longitudinal.Sh.IA,Tyre.Coefficients.Pacejka.Longitudinal.Sh.Sh,Fz,-IA,InterpMethod);
% B_x = qinterp2(Tyre.Coefficients.Pacejka.Longitudinal.B.Fz,Tyre.Coefficients.Pacejka.Longitudinal.B.IA,Tyre.Coefficients.Pacejka.Longitudinal.B.B,Fz,-IA,MethodFlag);
% C_x = qinterp2(Tyre.Coefficients.Pacejka.Longitudinal.C.Fz,Tyre.Coefficients.Pacejka.Longitudinal.C.IA,Tyre.Coefficients.Pacejka.Longitudinal.C.C,Fz,-IA,MethodFlag);
% D_x = qinterp2(Tyre.Coefficients.Pacejka.Longitudinal.D.Fz,Tyre.Coefficients.Pacejka.Longitudinal.D.IA,Tyre.Coefficients.Pacejka.Longitudinal.D.D,Fz,-IA,MethodFlag);
% E_x = qinterp2(Tyre.Coefficients.Pacejka.Longitudinal.E.Fz,Tyre.Coefficients.Pacejka.Longitudinal.E.IA,Tyre.Coefficients.Pacejka.Longitudinal.E.E,Fz,-IA,MethodFlag);
% Sv_x = qinterp2(Tyre.Coefficients.Pacejka.Longitudinal.Sv.Fz,Tyre.Coefficients.Pacejka.Longitudinal.Sv.IA,Tyre.Coefficients.Pacejka.Longitudinal.Sv.Sv,Fz,-IA,MethodFlag);
% Sh_x = qinterp2(Tyre.Coefficients.Pacejka.Longitudinal.Sh.Fz,Tyre.Coefficients.Pacejka.Longitudinal.Sh.IA,Tyre.Coefficients.Pacejka.Longitudinal.Sh.Sh,Fz,-IA,MethodFlag);

% Apply gripscaling
D_x = D_x*Tyre.GripScale;
Sv_x = Sv_x*Tyre.GripScale;

x = SL + Sh_x;
y = D_x*sin( C_x*atan((B_x*x) - (E_x*(B_x*x - atan(B_x*x)))) );
Y = y + Sv_x;
F_x0 = Y;
Fx = F_x0.*(abs(S_x)./S);

%% Lateral force
B_y = interp2(Tyre.Coefficients.Pacejka.Lateral.B.Fz,Tyre.Coefficients.Pacejka.Lateral.B.IA,Tyre.Coefficients.Pacejka.Lateral.B.B,Fz,-IA,InterpMethod);
C_y = interp2(Tyre.Coefficients.Pacejka.Lateral.C.Fz,Tyre.Coefficients.Pacejka.Lateral.C.IA,Tyre.Coefficients.Pacejka.Lateral.C.C,Fz,-IA,InterpMethod);
D_y = interp2(Tyre.Coefficients.Pacejka.Lateral.D.Fz,Tyre.Coefficients.Pacejka.Lateral.D.IA,Tyre.Coefficients.Pacejka.Lateral.D.D,Fz,-IA,InterpMethod);
E_y = interp2(Tyre.Coefficients.Pacejka.Lateral.E.Fz,Tyre.Coefficients.Pacejka.Lateral.E.IA,Tyre.Coefficients.Pacejka.Lateral.E.E,Fz,-IA,InterpMethod);
Sv_y = interp2(Tyre.Coefficients.Pacejka.Lateral.Sv.Fz,Tyre.Coefficients.Pacejka.Lateral.Sv.IA,Tyre.Coefficients.Pacejka.Lateral.Sv.Sv,Fz,-IA,InterpMethod);
Sh_y = interp2(Tyre.Coefficients.Pacejka.Lateral.Sh.Fz,Tyre.Coefficients.Pacejka.Lateral.Sh.IA,Tyre.Coefficients.Pacejka.Lateral.Sh.Sh,Fz,-IA,InterpMethod);
% B_y = qinterp2(Tyre.Coefficients.Pacejka.Lateral.B.Fz,Tyre.Coefficients.Pacejka.Lateral.B.IA,Tyre.Coefficients.Pacejka.Lateral.B.B,Fz,-IA,MethodFlag);
% C_y = qinterp2(Tyre.Coefficients.Pacejka.Lateral.C.Fz,Tyre.Coefficients.Pacejka.Lateral.C.IA,Tyre.Coefficients.Pacejka.Lateral.C.C,Fz,-IA,MethodFlag);
% D_y = qinterp2(Tyre.Coefficients.Pacejka.Lateral.D.Fz,Tyre.Coefficients.Pacejka.Lateral.D.IA,Tyre.Coefficients.Pacejka.Lateral.D.D,Fz,-IA,MethodFlag);
% E_y = qinterp2(Tyre.Coefficients.Pacejka.Lateral.E.Fz,Tyre.Coefficients.Pacejka.Lateral.E.IA,Tyre.Coefficients.Pacejka.Lateral.E.E,Fz,-IA,MethodFlag);
% Sv_y = qinterp2(Tyre.Coefficients.Pacejka.Lateral.Sv.Fz,Tyre.Coefficients.Pacejka.Lateral.Sv.IA,Tyre.Coefficients.Pacejka.Lateral.Sv.Sv,Fz,-IA,MethodFlag);
% Sh_y = qinterp2(Tyre.Coefficients.Pacejka.Lateral.Sh.Fz,Tyre.Coefficients.Pacejka.Lateral.Sh.IA,Tyre.Coefficients.Pacejka.Lateral.Sh.Sh,Fz,-IA,MethodFlag);

% Apply gripscaling
D_y = D_y*Tyre.GripScale;

x = deg2rad(SA) + Sh_y;
y = D_y*sin( C_y*atan((B_y*x) - (E_y*(B_y*x - atan(B_y*x)))) );
Y = y + Sv_y;
F_y0 = Y;
Fy = F_y0.*(abs(S_y)./S);

%% Self-aligning torque
Mz = zeros(size(Fx)); % Incorrect but Mz is not used in lapsim for now...

end