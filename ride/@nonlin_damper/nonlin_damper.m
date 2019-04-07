classdef nonlin_damper
    %NONLIN_DAMPER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        damper_spec
        valve_settings_compression
        valve_settings_rebound
        adjuster_settings_high
        adjuster_settings_low
    end
    
    methods
        function obj = nonlin_damper(spec,settings_compression,...
                settings_rebound,LS_adjust,HS_adjust)
            %NONLIN_DAMPER Construct an instance of this class
            %   Detailed explanation goes here
            obj.damper_spec = spec;
            obj.valve_settings_compression = settings_compression;
            obj.valve_settings_rebound = settings_rebound;
            obj.adjuster_settings_low = LS_adjust;
            obj.adjuster_settings_high = HS_adjust;
            
            for i = 1:length(settings_compression)
                for j = 1:length(settings_rebound)
                    for k = 1:length(LS_adjust)
                        
                    end
                end
            end
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        obj = fit_setting(obj,setting_high, setting_low, setting_high, setting_low)
    end
end

