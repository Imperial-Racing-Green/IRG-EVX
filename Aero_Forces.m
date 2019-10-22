function [F_L,F_D,Aerobalance] = Aero_Forces(v_x,Environment,Car,bUseAeromap,hRideF,hRideR,aRollF,aRollR,aYaw)

% Use aeromap to lookup SC_L, SC_D and aerobalance position due to changes
% in ride heights, roll and yaw angles
if bUseAeromap
    dhRideF = (hRideF - Car.AeroPerformance.hRideF)*1000;
    dhRideR = (hRideR - Car.AeroPerformance.hRideR)*1000;
    aRoll = abs(0.5*(aRollF + aRollR));
    aYaw = abs(aYaw);
    SC_L = [];
    SC_D = [];
    Aerobalance = [];
    % FRH
    Aerobalance = [Aerobalance; interp1(Car.AeroPerformance.Aeromap.FRH_Sens.FRH_delta,Car.AeroPerformance.Aeromap.FRH_Sens.Aerobalance,dhRideF,'linear','extrap')];
    SC_L = [SC_L; interp1(Car.AeroPerformance.Aeromap.FRH_Sens.FRH_delta,Car.AeroPerformance.Aeromap.FRH_Sens.SCl,dhRideF,'linear','extrap')];
    SC_D = [SC_D; interp1(Car.AeroPerformance.Aeromap.FRH_Sens.FRH_delta,Car.AeroPerformance.Aeromap.FRH_Sens.SCd,dhRideF,'linear','extrap')];
    % RRH
    Aerobalance = [Aerobalance; interp1(Car.AeroPerformance.Aeromap.RRH_Sens.RRH_delta,Car.AeroPerformance.Aeromap.FRH_Sens.Aerobalance,dhRideR,'linear','extrap')];
    SC_L = [SC_L; interp1(Car.AeroPerformance.Aeromap.RRH_Sens.RRH_delta,Car.AeroPerformance.Aeromap.FRH_Sens.SCl,dhRideR,'linear','extrap')];
    SC_D = [SC_D; interp1(Car.AeroPerformance.Aeromap.RRH_Sens.RRH_delta,Car.AeroPerformance.Aeromap.FRH_Sens.SCd,dhRideR,'linear','extrap')];
%     % Roll
%     Aerobalance = [Aerobalance; interp1(Car.AeroPerformance.Aeromap.Roll_Sens.aRoll,Car.AeroPerformance.Aeromap.FRH_Sens.Aerobalance,aRoll,'linear','extrap')];
%     SC_L = [SC_L; interp1(Car.AeroPerformance.Aeromap.Roll_Sens.aRoll,Car.AeroPerformance.Aeromap.FRH_Sens.SCl,aRoll,'linear','extrap')];
%     SC_D = [SC_D; interp1(Car.AeroPerformance.Aeromap.Roll_Sens.aRoll,Car.AeroPerformance.Aeromap.FRH_Sens.SCd,aRoll,'linear','extrap')];
    % Yaw
    Aerobalance = [Aerobalance; interp1(Car.AeroPerformance.Aeromap.Yaw_Sens.aYaw,Car.AeroPerformance.Aeromap.FRH_Sens.Aerobalance,aYaw,'spline','extrap')];
    SC_L = [SC_L; interp1(Car.AeroPerformance.Aeromap.Yaw_Sens.aYaw,Car.AeroPerformance.Aeromap.FRH_Sens.SCl,aYaw,'spline','extrap')];
    SC_D = [SC_D; interp1(Car.AeroPerformance.Aeromap.Yaw_Sens.aYaw,Car.AeroPerformance.Aeromap.FRH_Sens.SCd,aYaw,'spline','extrap')];
    % Use average of lookup values
    F_L = 0.5*Environment.Density*(v_x^2)*mean(SC_L);
    F_D = 0.5*Environment.Density*(v_x^2)*mean(SC_D);
    Aerobalance = mean(Aerobalance);
else
    F_L = 0.5*Environment.Density*(v_x^2)*Car.AeroPerformance.SC_L;
    F_D = 0.5*Environment.Density*(v_x^2)*Car.AeroPerformance.SC_D;
    Aerobalance = 1 - Car.Balance.CoP(1);
end

