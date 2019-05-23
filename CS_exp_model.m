function[C] = CS_exp_model(Fz)

A = 1.0e+03 *[0.2109 0.4377 0.6605 1.1026 1.5520]';
B = [213.3300  374.4400  521.0200  757.4100  904.5800]';
f = fit(A,B, 'exp2');
C = f.a*exp(f.b*Fz) + f.c*exp(f.d*Fz);
end 
