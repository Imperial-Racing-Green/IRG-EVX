function Aeromap = GenerateAeromap()

%% FRH Sensitivity
FRH_Sens = xlsread('Aeromap.xlsx','FRH_Sens');
Aeromap.FRH_Sens = array2table(FRH_Sens);
Aeromap.FRH_Sens.Properties.VariableNames = {'FRH_delta','Aerobalance','SCl','SCd'};

%% RRH Sensitivity
RRH_Sens = xlsread('Aeromap.xlsx','RRH_Sens');
Aeromap.RRH_Sens = array2table(RRH_Sens);
Aeromap.RRH_Sens.Properties.VariableNames = {'RRH_delta','Aerobalance','SCl','SCd'};

%% Roll Sensitivity
Roll_Sens = xlsread('Aeromap.xlsx','Roll_Sens');
Aeromap.Roll_Sens = array2table(Roll_Sens);
Aeromap.Roll_Sens.Properties.VariableNames = {'aRoll','Aerobalance','SCl','SCd'};

%% Yaw Sensitivity
Yaw_Sens = xlsread('Aeromap.xlsx','Yaw_Sens');
Aeromap.Yaw_Sens = array2table(Yaw_Sens);
Aeromap.Yaw_Sens.Properties.VariableNames = {'aYaw','Aerobalance','SCl','SCd'};

end