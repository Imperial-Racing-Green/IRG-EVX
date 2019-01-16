classdef pacejka4_model
    %PACEJKA4_MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        B_fit_lat
        C_fit_lat
        D_fit_lat
        E_fit_lat
        Sv_fit_lat
        Sh_fit_lat
        B_fit_long
        C_fit_long
        D_fit_long
        E_fit_long
        Sv_fit_long
        Sh_fit_long
        pressures
        forces
        IAs
    end
    
    methods
        function obj = pacejka4_model(B,C,D,E,Sv,Sh,P,F,IA)
            %PACEJKA4_MODEL Construct an instance of this class
            %   Detailed explanation goes here
            obj.B_fit_lat = B;
            obj.C_fit_lat = C;
            obj.D_fit_lat = D;
            obj.E_fit_lat = E;
            obj.Sv_fit_lat = Sv;
            obj.Sh_fit_lat = Sh;
            obj.pressures = P;
            obj.forces = F;
            obj.IAs = IA;
            
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

