classdef EVX_tyre
    %PACEJKA4_MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fit_params
        pressures
        forces
        IAs
        lateral_data
        longitudinal_data
    end
    
    methods
        function obj = EVX_tyre(varargin)
            %PACEJKA4_MODEL Construct an instance of this class
            %   Detailed explanation goes here
            obj.fit_params = struct();
            if length(varargin) == 2
                obj.lateral_data = varargin{1};
                obj.longitudinal_data = varargin{2};
            elseif length(varargin) == 9
                obj.fit_params.B_fit_lat = B;
                obj.fit_params.C_fit_lat = C;
                obj.fit_params.D_fit_lat = D;
                obj.fit_params.E_fit_lat = E;
                obj.fit_params.Sv_fit_lat = Sv;
                obj.fit_params.Sh_fit_lat = Sh;
                obj.fit_params.pressures = P;
                obj.fit_params.forces = F;
                obj.fit_params.IAs = IA;
            end
            
        end
        
        function [B, C, D, E, Sv, Sh] = get_coefficients_lat(obj,P,IA,FZ)
            if     (P==obj.pressures(1))
                i = 1;
            elseif (P==obj.pressures(2))
                i = 2;
            elseif (P==obj.pressures(3))
                i = 3;
            else
                error("Pressure must match test cases - model cannot interpolate!")
            end
            B = obj.B_fit_lat{i}(IA,FZ);
            C = obj.C_fit_lat{i}(IA,FZ);
            D = obj.D_fit_lat{i}(IA,FZ);
            E = obj.E_fit_lat{i}(IA,FZ);
            Sv = obj.Sv_fit_lat{i}(IA,FZ);
            Sh = obj.Sh_fit_lat{i}(IA,FZ);
        end
        
        function [B, C, D, E, Sv, Sh] = get_coefficients_long(obj,P,IA,FZ)
            if     (P==obj.pressures(1))
                i = 1;
            elseif (P==obj.pressures(2))
                i = 2;
            elseif (P==obj.pressures(3))
                i = 3;
            else
                error("Pressure must match test cases - model cannot interpolate!")
            end
            B = obj.B_fit_long{i}(IA,FZ);
            C = obj.C_fit_long{i}(IA,FZ);
            D = obj.D_fit_long{i}(IA,FZ);
            E = obj.E_fit_long{i}(IA,FZ);
            Sv = obj.Sv_fit_long{i}(IA,FZ);
            Sh = obj.Sh_fit_long{i}(IA,FZ);
        end
        
        function force = get_force_output(obj,P,IA,FZ,slip,type)
            %Evaluate forces at a given operating point
            %   Detailed explanation goes here
            if type == 1
                [B, C, D, E, Sv, Sh] = obj.get_coefficients_lat(P,IA,FZ);
            elseif type == 2
                [B, C, D, E, Sv, Sh] = obj.get_coefficients_long(P,IA,FZ);
            end
            force = obj.MagicFormula(slip,B,C,D,E,Sv,Sh);
        end
    end
    
    methods (Static)
        
        function out = MagicFormula(slip,B,C,D,E,Sv,Sh)
            x = slip + Sh;
            y = D*sin(C*atan(B*x - E*(B*x - atan(B*x))));
            out = y + Sv;
        end
    end
end

