%Script to get plots for Big Nik

points=30;

% Slip ratio
SL2 = linspace(-1,1,points);

% Slip angle
SA2 = linspace(-30,30,points);

camber=0;

Fz=999.6; 

for i=1:length(camber)
[FY_new(:,i),FX_new(:,i)]=PacejkaTest2(SA2,SL2,Fz,camber(i));
end 

[SA,SL] = meshgrid(SA2,SL2);
[F_x,F_y,~] = PacejkaTest(SA,SL,Fz);