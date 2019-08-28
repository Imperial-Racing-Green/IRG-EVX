function [x,y,z,w,t] = Track_Interp(x,y,z,w,t,Points)

npoint_old = linspace(0,1,length(x))';
npoint_new = linspace(0,1,round(Points))';

method = 'spline'; 
x = (interp1( npoint_old, x, npoint_new, method));
y = (interp1( npoint_old, y, npoint_new, method));
z = (interp1( npoint_old, z, npoint_new, method));
w = (interp1( npoint_old, w, npoint_new, method));
t = (interp1( npoint_old, t, npoint_new, method));