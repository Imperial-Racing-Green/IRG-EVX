function [metrics] = comparison_metrics(sim_result)
%COMPARISON_METRICS Summary of this function goes here
%   Detailed explanation goes here
static_idx = sim_result.metrics.static_idx;
CG = sim_result.metrics.CamberGain_heave_coef(end-1);
BS = sim_result.metrics.BumpSteer_coef(end-1);
Castor = sim_result.metrics.Caster_static;
KPI = sim_result.metrics.KPI_static;
MR = -1/sim_result.metrics.MotionRatio_coef(end-1);
AD = sim_result.channels.r_antiDive(static_idx);
RCH = sim_result.metrics.RCH_static;
RCH_Mvt = -1 + sim_result.metrics.RCH_heave_coef(end-1);
Steer_Camber = sim_result.metrics.CamberGain_steer_coef(end-1);
Steering_Ratio = sim_result.metrics.steer_ratio_coef(end-1);

metrics = [CG BS Castor KPI MR AD RCH RCH_Mvt Steer_Camber Steering_Ratio];
end

