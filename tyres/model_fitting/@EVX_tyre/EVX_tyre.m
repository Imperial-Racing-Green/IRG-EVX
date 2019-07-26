classdef EVX_tyre
    %EVX_TYRE Object containing code for tyre modelling and evaluation
    % in EVX lap simulations. Contains code for fitting models from 
    % raw data and evaluating fitted models
    
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
        vertical_stiffness
        static_radius
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
            
             disp("Longitudinal and lateral coefficients available - model complete")
             
             disp("Fitting vertical stiffness")
             
             obj = obj.fit_stiffness;
             
             disp("Done")
             
        end
        
        function obj = fit_coef_lat(obj)
            [obj.coef_lat, obj.testcases_lat, obj.testcase_cell_lat] = obj.fit_coefficients(obj.lateral_data);
        end
        
        function obj = fit_coef_long(obj)
            [obj.coef_long, obj.testcases_long, obj.testcase_cell_long] = obj.fit_coefficients(obj.longitudinal_data);
            obj.coef_long_pure = obj.coef_long(:,:,:,end);
        end
        
        function coef = get_coefficients_long(obj,P,IA,FZ)
            coef = zeros(length(FZ),length(obj.longitudinal_model));
            for j = 1:length(FZ)
                for i = 1:length(obj.longitudinal_model)
                    %abs(IA) so effect of camber is symmetrical
                    coef(j,i) = obj.longitudinal_model{i}(P(j),abs(IA(j)),FZ(j));
                end
            end
        end
        
        function coef = get_coefficients_lat(obj,P,IA,FZ)
            coef = zeros(length(FZ),length(obj.lateral_model));
            for j = 1:length(FZ)
                for i = 1:length(obj.lateral_model)
                    if IA(j) >= 0 %Need to treat Negative camber differently
                        %I'm assuming that the effect of positive camber
                        %Is the same as negative, but acting in the
                        %opposite direction, so swap SA and F axes to put
                        %what was the +ve SA characteristic on the -ve side
                        %and vice versa
                        coef(j,i) = obj.lateral_model{i}(P(j),IA(j),FZ(j));
                    else
                        coef(j,i) = obj.lateral_model{i}(P(j),-IA(j),FZ(j));
                        if i == 3 %Invert the D coefficient for negative IA
                            %This only works if the SA is also inverted
                            coef(j,3) = -coef(j,3);
                        end
                    end
                end
            end
        end
        
        function [FX, FY, MZ] = get_forces(obj,SR,SA,P,IA,FZ)
            SA = 0.0174533*SA;
            
            %non-dimensionalise according to Pacejka pg 101
            SA_nd = tan(SA)/(1+SR);
            SR_nd = SR/(1+SR);
            FZ = -FZ;
            
            if SR==0 && SA==0
                G_x = 1;
                G_y = 1;
            else
                slip_direction = atan(abs(SR_nd)./abs(SA_nd));
                G_x = sin(slip_direction);
                G_y = cos(slip_direction);
            end
            
            coef_x = obj.get_coefficients_long(P,IA,FZ);
            coef_y = obj.get_coefficients_lat(P,IA,FZ);
            
            for i = 1:size(coef_x,1)
                %Try adding the rolling resistancec(Sv) on afterwards
                FX = G_x*(obj.pacejka4(coef_x(i,:),SR)-obj.pacejka4(coef_x(i,:),0)) + obj.pacejka4(coef_x(i,:),0);
                if coef_y(i,3) < 0 %Negative D coef if IA > 0; need to invert SA
                    FY = G_y*(obj.pacejka4(coef_y(i,:),-SA) - obj.pacejka4(coef_y(i,:),0)) + obj.pacejka4(coef_y(i,:),0);
                else
                    FY = G_y*(obj.pacejka4(coef_y(i,:),SA) - obj.pacejka4(coef_y(i,:),0)) + obj.pacejka4(coef_y(i,:),0);
                end
            end
            MZ = zeros(length(SR),1);
        end
        
        function obj = fit_stiffness(obj)
            data = load(obj.lateral_data);
            coef = polyfit(data.FZ,10*data.RL,2);
            obj.vertical_stiffness = 1000/coef(2); %k in N/m
            obj.static_radius = coef(3);
            %This is a very very basic model - simply plotting the data
            %makes it clear that the loaded radius is a function of much
            %more than just the vertical load, but this will work as a
            %first stab at it - I imagine that it shouldn't be too
            %difficult to fit some sort of multi-dimensional surface from
            %the data but that's for a later day
            %In particular the inflation pressure will have a big impact
        end
        
        [coef,testcases,coef_lat] = fit_coefficients(obj,filename)
    end
    
    methods (Static)
        
        [force] = pacejka4(coef, slip)
        
    end
end

