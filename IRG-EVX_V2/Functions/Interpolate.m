function [newy] = Interpolate(oldn,newn,oldy,method)
newy = interp1(linspace(1,oldn,oldn),oldy,linspace(1,oldn,newn),method);
end