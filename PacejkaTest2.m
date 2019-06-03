function [Fy,Fx] = PacejkaTest2(SA,SL,Fz,camber)

%Function to work out FY,Fx and Mz for a diven Fz and given slip angles and
%slip ratio

Fz=Fz/1000;

a_Fy=[-22.1 1011 1078 1.82 0.208 0 -0.354 0.707...
    0.028 0 14.8 0.022 0];

a_Fx=[-21.3 1144 49.6 226 0.069 -0.006 0.056 0.486];

a_Mz=[-2.72 -2.28 -1.86 -2.73 0.110 -0.070 0.643 -4.04...
      0.015 -0.066 0.945 0.03 0.07];
  
C_Fy=1.3;
D_Fy=a_Fy(1)*Fz^2+a_Fy(2)*Fz^2;
BCD_Fy=a_Fy(3)*sin(a_Fy(4)*atan(a_Fy(5)*Fz));
B_Fy=BCD_Fy/(C_Fy*D_Fy);
E_Fy=a_Fy(6)*Fz^2+a_Fy(7)*Fz+a_Fy(8);

Sh_Fy=a_Fy(9).*camber;
Sv_Fy=(a_Fy(10)*Fz^2+a_Fy(11)*Fz).*camber;

phi_Fy=(1-E_Fy)*(-SA+Sh_Fy)+(E_Fy/B_Fy)*atan(B_Fy*(-SA+Sh_Fy));
Fy=D_Fy*(C_Fy*atan(B_Fy*phi_Fy));

C_Fx=1.65;
D_Fx=a_Fx(1)*Fz^2+a_Fx(2)*Fz;
BCD_Fx=(a_Fx(3)*Fz^2+a_Fx(4)*Fz)/exp(a_Fx(5)*Fz);
B_Fx=BCD_Fx/(C_Fx*D_Fx);
E_Fx=a_Fx(6)*Fz^2+a_Fx(7)*Fz+a_Fx(8);

phi_Fx=(1-E_Fx)*(SL)+(E_Fx/B_Fx)*atan(B_Fx*SL);
Fx=D_Fx*(C_Fx*atan(B_Fx*phi_Fx));



