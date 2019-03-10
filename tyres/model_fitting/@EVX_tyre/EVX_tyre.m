classdef EVX_tyre
    %PACEJKA4_MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lateral_data
        longitudinal_data
        coef_lat
        coef_long
        coef_combined
        testcases_lat
        testcases_long
    end
    
    methods
        function obj = EVX_tyre(varargin)
            %PACEJKA4_MODEL Construct an instance of this class
            %   Detailed explanation goes here
            
            if length(varargin) == 2
                obj.lateral_data = varargin{1};
                obj.longitudinal_data = varargin{2};
            elseif length(varargin) == 9
                
            end
            
        end
        
        function obj = make_full_model(obj)
            if isempty(obj.coef_lat)
                disp('No lateral coefficients found - finding these now')
                obj = obj.fit_coef_lat();
            end
            
            if isempty(obj.coef_long)
                disp('No longitudinal coefficients found - finding these now')
                obj = obj.fit_coef_long();
            end
        end
        
        function obj = fit_coef_lat(obj)
            [obj.coef_lat, obj.testcases_lat] = obj.fit_coefficients(obj.lateral_data);
        end
        
        function obj = fit_coef_long(obj)
            [obj.coef_long, obj.testcases_long] = obj.fit_coefficients(obj.longitudinal_data);
        end
        
    end
    
    methods (Static)
        
        [coef,testcases,coef_lat] = fit_coefficients(filename)
        
        [force] = pacejka4(coef, slip)
    end
end

