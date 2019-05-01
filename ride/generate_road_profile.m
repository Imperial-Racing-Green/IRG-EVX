function [z_r, t] = generate_road_profile(phi_0,V,n,omega_0,omega_1,omega_n)
%GENERATE_ROAD_PROFILE Summary of this function goes here
%   Detailed explanation goes here

omega = linspace(omega_1, omega_n, n);
phi = phi_0.*(omega./omega_0).^-2;

base_freq = V*mean(diff(omega));
phase = 2*pi*rand(length(phi),1);

delta_omega = base_freq/V;
for n = 1:length(omega)
    A(n) = sqrt(phi(n).*delta_omega./pi);
end

t = linspace(0,60,1000);
z_r = zeros(1,length(t));
for i = 1:length(t)
    for n = 1:length(omega)
        z_r(i) =  z_r(i) + A(n)*sin(n*base_freq*t(i) - phase(n));
    end
end
% keyboard
coef = polyfit(t,z_r,1);
z_r = z_r - polyval(coef,t);
% z_r = z_r - z_r(1);
plot(t,z_r)
end

