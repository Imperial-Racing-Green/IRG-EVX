function [F,Lookup_points] = DamperCurve(params,v,calc_lookup)
%DAMPERCURVE Function for a generic bi-linear damper curve, with different
%characteristics for compression and rebound. Designed for use with
%lsqcurvefit() to fit measured data to a simple model
v_crossover_comp = params(1);
slope_comp_ls = params(2);
slope_comp_hs = params(3);
v_crossover_reb = params(4);
slope_reb_ls = params(5);
slope_reb_hs = params(6);

for i = 1:length(v)
    if v(i) >= 0
        if v(i) > v_crossover_comp
            F(i) = (slope_comp_ls * v_crossover_comp) + (slope_comp_hs * (v(i) - v_crossover_comp));
        else
            F(i) = slope_comp_ls * v(i);
        end
    else
        if abs(v(i)) > abs(v_crossover_reb)
            F(i) = (slope_reb_ls * v_crossover_reb) + (slope_reb_hs * (v(i) - v_crossover_reb));
        else
            F(i) = slope_reb_ls * v(i);
        end
    end
end

if calc_lookup
Lookup_points = [v_crossover_reb - 10, v_crossover_reb, 0, v_crossover_comp, v_crossover_comp + 10;
    DamperCurve(params,v_crossover_reb - 10,0), DamperCurve(params,v_crossover_reb,0), 0,...
    DamperCurve(params,v_crossover_comp,0), DamperCurve(params,v_crossover_comp + 10,0)];
end