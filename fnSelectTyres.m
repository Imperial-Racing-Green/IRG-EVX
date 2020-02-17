function Car = fnSelectTyres(Car)

% This script selects relevant tyre characteristics dependant on the chosen
% set of tyres or pressures (e.g rolling resistance, pacejka coefficients
% and required wheel size)

if Car.Tyres.bSameTyreType
    Car.Tyres.Rear.Name = Car.Tyres.Front.Name;
end

%% Fronts
if strcmp(Car.Tyres.Front.Name,'Hoosier_16.0x7.5-10_R25B') && (Car.Tyres.Front.Pressure == 12)
    % These numbers need fixing!
    Car.Tyres.Front.Coefficients.Pacejka = Hoosier_43131;
    Car.Tyres.Front.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelFL.Radius = 0.2032; % Rim radius + tyre thickness
    Car.Dimension.WheelFR.Radius = 0.2032;
elseif strcmp(Car.Tyres.Front.Name,'Hoosier_20.0x6.0-13') && (Car.Tyres.Front.Pressure == 12)
    Car.Tyres.Front.Coefficients.Pacejka = Hoosier_43131;
    Car.Tyres.Front.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelFL.Radius = 0.254; % Rim radius + tyre thickness
    Car.Dimension.WheelFR.Radius = 0.254;
elseif strcmp(Car.Tyres.Front.Name,'Hoosier_20.5x7.0-13') && (Car.Tyres.Front.Pressure == 12)
    Car.Tyres.Front.Coefficients.Pacejka = Hoosier_43129;
    Car.Tyres.Front.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelFL.Radius = 0.26035; % Rim radius + tyre thickness
    Car.Dimension.WheelFR.Radius = 0.26035;
elseif strcmp(Car.Tyres.Front.Name,'Hoosier_20.0x7.0-13') && (Car.Tyres.Front.Pressure == 12)
    Car.Tyres.Front.Coefficients.Pacejka = Hoosier_43157;
    Car.Tyres.Front.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelFL.Radius = 0.254; % Rim radius + tyre thickness
    Car.Dimension.WheelFR.Radius = 0.254;
elseif strcmp(Car.Tyres.Front.Name,'Avon_20.0x6.2-13') && (Car.Tyres.Front.Pressure == 12)
    Car.Tyres.Front.Coefficients.Pacejka = Avon_FITO9241;
    Car.Tyres.Front.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelFL.Radius = 0.254; % Rim radius + tyre thickness
    Car.Dimension.WheelFR.Radius = 0.254;
else
    error('Incorrect tyre choice for front axle or tyre data not available...')
end

%% Rears
if strcmp(Car.Tyres.Rear.Name,'Hoosier_16.0x7.5-10_R25B') && (Car.Tyres.Rear.Pressure == 12)
    % These numbers need fixing!
    Car.Tyres.Rear.Coefficients.Pacejka = Hoosier_43131;
    Car.Tyres.Rear.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelRL.Radius = 0.2032; % Rim radius + tyre thickness
    Car.Dimension.WheelRR.Radius = 0.2032;
elseif strcmp(Car.Tyres.Rear.Name,'Hoosier_20.0x6.0-13') && (Car.Tyres.Rear.Pressure == 12)
    Car.Tyres.Rear.Coefficients.Pacejka = Hoosier_43131;
    Car.Tyres.Rear.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelRL.Radius = 0.254; % Rim radius + tyre thickness
    Car.Dimension.WheelRR.Radius = 0.254;
elseif strcmp(Car.Tyres.Rear.Name,'Hoosier_20.5x7.0-13') && (Car.Tyres.Rear.Pressure == 12)
    Car.Tyres.Rear.Coefficients.Pacejka = Hoosier_43129;
    Car.Tyres.Rear.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelRL.Radius = 0.26035; % Rim radius + tyre thickness
    Car.Dimension.WheelRR.Radius = 0.26035;
elseif strcmp(Car.Tyres.Rear.Name,'Hoosier_20.0x7.0-13') && (Car.Tyres.Rear.Pressure == 12)
    Car.Tyres.Rear.Coefficients.Pacejka = Hoosier_43157;
    Car.Tyres.Rear.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelRL.Radius = 0.254; % Rim radius + tyre thickness
    Car.Dimension.WheelRR.Radius = 0.254;
elseif strcmp(Car.Tyres.Rear.Name,'Avon_20.0x6.2-13') && (Car.Tyres.Rear.Pressure == 12)
    Car.Tyres.Rear.Coefficients.Pacejka = Avon_FITO9241;
    Car.Tyres.Rear.Coefficients.RollingResistance = 0.020;
    Car.Dimension.WheelRL.Radius = 0.254; % Rim radius + tyre thickness
    Car.Dimension.WheelRR.Radius = 0.254;
else
    error('Incorrect tyre choice for rear axle or tyre data not available...')
end

end