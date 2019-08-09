function [x,y] = Path_Optim(x,y,lb,ub,Options)

initial = [x,y];
fun = @(z) sum((abs(Curvature(z)./min(Curvature(initial)))).^2);
A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = @PathCon;

if strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Very High') == 1
    Parallel = true;
elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'High') == 1
    Parallel = true;
elseif strcmpi(Options.Driving_Line_Optimisation_Accuracy,'Medium') == 1
    Parallel = true;
else
    Parallel = false;
end

if strcmpi(Options.Debug_Mode,'On') == 1
    Display = 'iter';
else
    Display = 'none';
end

opts = optimset('Display',Display,'Algorithm','interior-point', 'MaxIter', Inf, 'MaxFunEvals', Inf...
    ,'TolCon',1e-100,'TolX',1e-100,'TolFun',1e-100,'UseParallel',Parallel);

new = fmincon(fun,initial,A,b,Aeq,beq,lb,ub,nonlcon,opts);

x = new(:,1);
y = new(:,2);

end

