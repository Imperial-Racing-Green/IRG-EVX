classdef EVX_tyre
    %PACEJKA4_MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lateral_data
        longitudinal_data
        coef_lat
        coef_long
        coef_long_pure
        coef_combined
        testcases_lat
        testcases_long
        testcase_cell_lat
        testcase_cell_long
        verbosity
        lateral_model
        longitudinal_model
    end
    
    methods
        function obj = EVX_tyre(varargin)
            %PACEJKA4_MODEL Construct an instance of this class
            %   Detailed explanation goes here
            
            if length(varargin) == 2
                obj.lateral_data = varargin{1};
                obj.longitudinal_data = varargin{2};
                obj.verbosity = 0;
            elseif length(varargin) == 9
                
            end
            
        end
        
        function obj = make_full_model(obj)
            if isempty(obj.coef_lat)
                disp('No lateral coefficients found - finding these now')
                obj = obj.fit_coef_lat();
            end
            
            [X1, X2, X3] = ndgrid(unique(obj.testcases_lat(:,1)),...
                unique(obj.testcases_lat(:,3)), unique(obj.testcases_lat(:,2)));
            obj.lateral_model = cell(length(obj.coef_lat{1}),1);
            for i = 1:length(obj.coef_lat{1,1,1})
                obj.lateral_model{i} = griddedInterpolant(X1,X2,X3,...
                    cellfun(@(v)v(i),obj.coef_lat),'spline','none');
            end
            
            if obj.verbosity
                close
            end
            
            if isempty(obj.coef_long)
                disp('No longitudinal coefficients found - finding these now')
                obj = obj.fit_coef_long();
            end
            
            [X1, X2, X3] = ndgrid(unique(obj.testcases_long(:,1)),...
                unique(obj.testcases_long(:,3)), unique(obj.testcases_long(:,2)));
            obj.longitudinal_model = cell(length(obj.coef_long{1}),1);
            for i = 1:length(obj.coef_long{1,1,1})
                obj.longitudinal_model{i} = griddedInterpolant(X1,X2,X3,...
                    cellfun(@(v)v(i),obj.coef_long_pure),'spline','none');
            end
            
             if obj.verbosity
                close
             end
            
             disp("Longitudinal and lateral coefficients available - proceding with model fitting")
             disp("(though not actually because I haven't written the code yet lol)")
             %TODO: Write the code
        end
        
        function obj = fit_coef_lat(obj)
            [obj.coef_lat, obj.testcases_lat, obj.testcase_cell_lat] = obj.fit_coefficients(obj.lateral_data);
        end
        
        function obj = fit_coef_long(obj)
            [obj.coef_long, obj.testcases_long, obj.testcase_cell_long] = obj.fit_coefficients(obj.longitudinal_data);
            obj.coef_long_pure = obj.coef_long(:,:,:,end);
%             obj.coef_long_pure = 
        end
        
        [coef,testcases,coef_lat] = fit_coefficients(obj,filename)
    end
    
    methods (Static)
        
        [force] = pacejka4(coef, slip)
        
    end
end

