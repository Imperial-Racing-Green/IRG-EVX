function [x,y] = Path_Optim(x,y,z,w,t,lb,ub,x_left,y_left,x_right,y_right,Options)

init = [x,y];
% if abs(sum(Curvature(initial))) > 0
if PathFun(init,z,w,t,init,x_left,y_left,x_right,y_right) > 0
%     fun = @(v) sum((abs(Curvature(v)./min(Curvature(init)))).^2);
    fun = @(v) PathFun(v,z,w,t,init,x_left,y_left,x_right,y_right);   
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    nonlcon = @(v) PathCon(v,x_left,y_left,x_right,y_right,Options);
    
    if strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Very High') == 1
        Parallel = true;
    elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'High') == 1
        Parallel = true;
    elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Medium') == 1
        Parallel = true;
    else
        Parallel = true;
    end
    
    if strcmpi(Options.Debug_Mode,'On') == 1
        Display = 'iter';
    else
        Display = 'none';
    end
    
    opts = optimset('Display',Display,'Algorithm','interior-point', 'MaxIter', Inf, 'MaxFunEvals', Inf...
        ,'TolCon',1e-10,'TolX',1e-10,'TolFun',1e-10,'UseParallel',Parallel);
    
    new = fmincon(fun,init,A,b,Aeq,beq,lb,ub,nonlcon,opts);
    
    x = new(:,1);
    y = new(:,2);
else
    disp('Curvature is already 0 and cannot be minimised, optimisation was not run.')
end

