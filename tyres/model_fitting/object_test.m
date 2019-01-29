
tyre_model = EVX_tyre(lateral_data, longitudinal_data);
tyre_model.fit_model();

SA = linspace(-10, 10, 200);
SR = linspace(-1,1,200);
FZ = 750*ones(200,1);
IA = 2*ones(200,1);
P = 90;

tyre_model.mu_scaling_x = 0.67;
tyre_model.mu_scaling_y = 0.67;
tyre_model.mu_scaling_z = 0.67;

[fx,fy,mz] = tyre_model.get_forces(SA,SR,FZ,IA,P);