function car = car_parameters
% the function car_parameters is used to define all of the necessary
% parameters of the vehicle that are required in the car simulation. All
% variables are created and defined in the function so 
% car_parameters therefore requires no external inputs. The output is
% structure 'car' that contains all of the defined parameters.

%% User inputs

% wheelbase (m)
l = 1.525; 
% CoM distance from front axle (m)
CoM.lf = 0.7;
% CoM height above ground (m)
CoM.z = 0.245;
% mass (kg)
m = 346.5;
% transmission ratio
transmission_ratio = 4;
% brake balance, above 0.5 is forward bias
bb = 0.7;
% rolling friction coefficient
mu_r = 0.018;
% drag coefficient 
SCD = 1.358;
% lift coefficient (+ve for lift, -ve for downforce)
SCL = -3.524;
% distance from front axle to CoP (m)
CoP.lf = 0.8;
% max power (W)
Pmax = 80e3;
% max torque (Nm)
Tmax = 2000000;
% grip scaler
mu_scaling = 0.55;

% type of tyre (must coincide with tyre data function of same name)
tyre_type = 'Hoosier_43129';
% tyre_type = 'Avon_FITO9241';

% brake system used (must coincide with brake data function of same name)
brake_type = 'brake_2016_spec';

% motor used (must coincide with motor data function of same name)
motor_type = 'Emrax_228';
% select motor power mode: either 'continuous' or 'maximum'
motor_mode = 'maximum';

%% calculated inputs
% inputs derived from user inputs

% distance from rear axle to CoM (m)
CoM.lr = l-CoM.lf;
% distance from rear axle to CoP (m)
CoP.lr = l-CoP.lf;

%% generate car structure
% automatically generate car structure, do not manually change this section

% define path that tyre files are held in
addpath([pwd,'/tyredata/']);
% run function containing tyre parameters to load them to structure
tyre_type = str2func(tyre_type);
pacejka_coefs = tyre_type();

% define path that brake files are held in
addpath([pwd,'/brakedata/']);
% run function containing brake parameters to load them to structure
brake_type = str2func(brake_type);
brake_params = brake_type();

% define path that motor files are held in
addpath([pwd,'/motordata/']);
% run function to load motor curve coefficients, will depend on selected
% motor mode
motor_type = str2func(motor_type);
motor_coefs = motor_type(motor_mode);

%% export variables
% generate list of variables
varList = who;
% initialiste ouput structure
car = struct;

% add all existing variables to struture
for index = 1:numel(varList)
    car.(varList{index}) = eval(varList{index});
end