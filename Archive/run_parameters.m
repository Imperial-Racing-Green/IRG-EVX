function run_info = run_parameters
% the function run_parameters is used to define all of the necessary
% parameters of the track that are required in the laptime simulation. All
% variables are created and defined in the function so 
% run_parameters therefore requires no external inputs. The output is
% structure 'run_info' that contains all of the defined parameters.

%% user inputs
% define track
% type, length(m), turn in radius(m), angle to apex(deg),apex radius(m),
% angle to turn out point (deg), turnout radius (m)

track = {

% 75m acceleration
%'Straight',75,NaN,NaN,NaN,NaN,NaN};

% skid pad
% 'Corner',NaN,8.55,90,8.55,90,8.55;
% 'Corner',NaN,8.55,90,8.55,90,8.55};

% frazer-nash inner loop
'Straight'	17.90930148	NaN         NaN     NaN         NaN     NaN;	
'Corner'	NaN         30.61806656	-39.22	31.48726076	-50.69	28.93708128	;
'Corner'	NaN         55.4887422	3.96	55.43636291	8.29	55.66466396	;
'Corner'	NaN         8.127567296	-27.07	9.268560283	0       9.268560283	;
'Corner'	NaN         13.4548336	-90     8.968669999	-44.43  10.51322687	;
'Corner'	NaN         13.4584908	45.57	11.92612459	0       11.92612459	;
'Corner'	NaN         10.74794958	0.84	10.7476103	90      12.81116665	;
'Corner'	NaN         12.81116665	90      11.36169694 38.47   11.86273315	;
'Corner'	NaN         6.4659271	-55.6	5.035962453	0       5.035962453	;
'Corner'	NaN         4.511763989	-80.1	4.904303304	-13.83	4.877483847	;
'Straight'	15.84176521 NaN         NaN     NaN         NaN     NaN	;
'Corner'	NaN         20.83871754	-13.73	22.81360478	-45.82	18.11532366	;
'Straight'	26.87553334	NaN         NaN     NaN         NaN     NaN	;
'Corner'	NaN         21.38729733	-72.4	23.24759234	-26.3	23.23418262};


% number of laps
no_laps = 1;
% distance step
dx = 0.1;
% angle step (through turns)
dtheta = 0.5;
% track conditions: 'wet' or 'dry'
track_conditions = 'dry';
% air density (kg/m^3)
rho = 1.225;
% gravitational acceleration
g = 9.81;


%% generate run structure
% automatically generate run info structure, do not manually change this section
varList = who;
% initialiste ouput structure
run_info = struct;

% add all existing variables to struture
for index = 1:numel(varList)
    run_info.(varList{index}) = eval(varList{index});
end