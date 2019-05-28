function Points = PointsCalculator(Laptimes,carfile)

load(carfile)

%% Acceleration
if strcmp(Car.Year,'2018') == 1
    T_min_A = 3.881;
elseif strcmp(Car.Year,'2017') == 1
    T_min_A = 4.064;
elseif strcmp(Car.Year,'2016') == 1
    T_min_A = 3.780;
elseif strcmp(Car.Year,'2015') == 1
    T_min_A = 3.724;
else
    error('Need to add best results from the year of this car!')
end
T_max_A = 1.5*T_min_A; %150% as per regulations
T_team = Laptimes.Acceleration;
if T_team > T_max_A
    Accel_score = 3.5;
else
    if strcmp(Car.Year,'2015') == 1 || strcmp(Car.Year,'2016') == 1 || strcmp(Car.Year,'2017') == 1
        Accel_score = (71.5*(((T_max_A/T_team) - 1)/((T_max_A/T_min_A)-1))) + 3.5;
    elseif strcmp(Car.Year,'2018') == 1
        Accel_score = (71.5 * (((T_max_A/T_team)-1)/0.5)) + 3.5;
    else
       error('Need to add best results from the year of this car!')
    end  
    if  Accel_score > 75
        Accel_score = 75;
    end
end
disp(['Acceleration Time: ',num2str(T_team) 's           Score: ',num2str(Accel_score),' /75'])

%% Skid Pad
if strcmp(Car.Year,'2018') == 1
    T_min_s = 4.729;
elseif strcmp(Car.Year,'2017') == 1
    T_min_s = 5.088;
elseif strcmp(Car.Year,'2016') == 1
    T_min_s = 4.735;
elseif strcmp(Car.Year,'2015') == 1
    T_min_s = 4.627;
else
    error('Need to add best results from the year of this car!')
end
T_max_s = 1.25*T_min_s; % 125% as per regulations
T_team = Laptimes.SkidPad;
if T_team > T_max_s
    score_s = 0;
else
    if strcmp(Car.Year,'2015') == 1 || strcmp(Car.Year,'2016') == 1 || strcmp(Car.Year,'2017') == 1
        score_s = (47.5*((((T_max_s/T_team)^2)-1)/(((T_max_s/T_min_s)^2)-1))) + 2.5;
        if score_s > 50
            score_s = 50;
        end
        disp(['Skidpad Time: ',num2str(T_team) 's         Score: ',num2str(score_s),' /50'])
    elseif strcmp(Car.Year,'2018') == 1
        score_s = (71.5 * ((((T_max_s/T_team)^2)-1)/0.5625)) + 3.5;
        if score_s > 75
            score_s = 75;
        end
        disp(['Skidpad Time: ',num2str(T_team) 's         Score: ',num2str(score_s),' /75'])
    else
       error('Need to add best results from the year of this car!')
    end
end

%% Autocross
if strcmp(Car.Year,'2018') == 1
    T_min_auto = 52.161;
elseif strcmp(Car.Year,'2017') == 1
    T_min_auto = 55.852;
elseif strcmp(Car.Year,'2016') == 1
    T_min_auto = 47.148;
elseif strcmp(Car.Year,'2015') == 1
    T_min_auto = 49.045;
else
    error('Need to add best results from the year of this car!')
end
T_max_auto = T_min_auto * 1.45;
T_team = Laptimes.Autocross;
if T_team > T_max_auto
    score_auto = 0;
else
    if strcmp(Car.Year,'2015') == 1 || strcmp(Car.Year,'2016') == 1 || strcmp(Car.Year,'2017') == 1
        score_auto = (142.5*(((T_max_auto/T_team) - 1)/((T_max_auto/T_min_auto)-1))) + 7.5;
        if score_auto > 150
            score_auto = 150;
        end
        disp(['Autocross Time: ',num2str(T_team) 's         Score: ',num2str(score_auto),' /150'])
    elseif strcmp(Car.Year,'2018') == 1
        score_auto = (95.5 * (((T_max_auto/T_team)-1)/0.25)) + 4.5;
        if score_auto > 100
            score_auto = 100;
        end
        disp(['Autocross Time: ',num2str(T_team) 's         Score: ',num2str(score_auto),' /100'])
    else
       error('Need to add best results from the year of this car!')
    end
end

%% Endurance 
if strcmp(Car.Year,'2018') == 1
    T_min_end = 1439.580;
elseif strcmp(Car.Year,'2017') == 1
    T_min_end = 1541.080;
elseif strcmp(Car.Year,'2016') == 1
    T_min_end = 1271.04;
elseif strcmp(Car.Year,'2015') == 1
    T_min_end = 1484.170;
else
    error('Need to add best results from the year of this car!')
end
T_max_end =  T_min_end * 1.45;
time_total = Laptimes.Endurance;
if time_total > T_max_end
    score_end = 0 ;
else
    if strcmp(Car.Year,'2015') == 1 || strcmp(Car.Year,'2016') == 1 || strcmp(Car.Year,'2017') == 1
        score_end = (250*(((T_max_end/time_total)-1)/((T_max_end/T_min_end)-1))) + 50;
        if score_end > 300
            score_end = 300;
        end
        disp(['Endurance Time: ',num2str(time_total) 's         Score: ',num2str(score_end),' /300'])
    elseif strcmp(Car.Year,'2018') == 1
        score_end = (300 * (((T_max_end/time_total)-1)/0.333)) + 25;
        if score_end > 100
            score_end = 100;
        end
        disp(['Endurance Time: ',num2str(time_total) 's         Score: ',num2str(score_end),' /325'])
    else
       error('Need to add best results from the year of this car!')
    end
end

%% Efficiency
if strcmp(Car.Year,'2018') == 1
    eff_factor_min = 0.095;
    eff_factor_max = 0.806;
    lap_min = 65.435;
elseif strcmp(Car.Year,'2017') == 1
    eff_factor_min = 0.122;
    eff_factor_max = 0.842;
    lap_min = 69.272;
elseif strcmp(Car.Year,'2016') == 1
    eff_factor_min = 0.139;
    eff_factor_max = 0.791;
    lap_min = 57.775;
elseif strcmp(Car.Year,'2015') == 1
    eff_factor_min = 0.120;
    eff_factor_max = 0.712;
    lap_min = 67.462;
else
    error('Need to add best results from the year of this car!')
end

% [First_Time_taken,power11,power12,brake1,epower1] = lap_function(car,track);
% [Second_time_taken,power21,power22,brake2,epower2] = second_lap_function(car,track);
% V_Team = ((FuelBurn.Endurance_Test_First_Lap.Sims) + (21*FuelBurn.Endurance_Test_Steady_State.Sims) + 180*(5.2842e-5)) / 0.74;
% T_min = lap_min*22;
% V_min = (0.0792*22) / 0.74;
% FuelEfficiencyFactors = (T_min*V_min)./(T_Team.*V_Team);
%     
% Power = power12*2;
% kWh = Power*(time_total/(3600*1000));
% kWh_brake = brake2*(time_total/(3600*1000));
% %If using ePower, multiply by 2
% 
% %scores,times and merit function from 2015 efficiency results
% eff_factor = (lap_min/(First_Time_taken))*(0.1169/(0.65*kWh/22));
% score_eff = 100*((eff_factor_min/eff_factor)-1)/((eff_factor_min/eff_factor_max)-1);
% 
% if score_eff > 100
%     score_eff = 100;
% end
% disp(['Efficiency Score: ',num2str(score_eff),' /100'])

%% Total Points
% Score_total = Accel_score + score_s + score_auto + score_end + score_eff;
Score_total = Accel_score + score_s + score_auto + score_end;
Points.Acceleration = Accel_score;
Points.SkidPad = score_s;
Points.Autocross = score_auto;
Points.Endurance = score_end;
% Points.FuelEfficiency = score_eff;
Points.FuelEfficiency = 0;
Points.Total = Score_total;
disp(['Total Score: ',num2str(Score_total) ' / 675'])
disp('----------------------------------------------')

end