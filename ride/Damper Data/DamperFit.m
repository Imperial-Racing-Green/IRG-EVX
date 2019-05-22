clear
close all

target_folder = [pwd '/ride/Damper Data/Ohlins TTX25 Mk2/R11 C11'];

listing = dir([target_folder '/*.csv']);

fits = struct();

for i = 1:length(listing)-1
    fits(i).name = listing(i).name;
    fits(i).data = readmatrix([listing(i).folder '/' listing(i).name]); 
    fits(i).data(fits(i).data(:,1)<0,2) = -fits(i).data(fits(i).data(:,1)<0,2);
    opts = optimset('MaxFunEvals',10000,'MaxIter',2000,'TolX',0.000001,'TolFun',1e-8,'UseParallel',false,'Display','off');
    fits(i).coef = lsqcurvefit(@(coef,v)DamperCurve(coef, v, 0),[100 1 1 -100 1 1],fits(i).data(:,2),...
        fits(i).data(:,1)',[0 0 0 -inf 0 0], [inf inf inf 0 inf inf],opts);
end

v = linspace(-250,250,500);
for i = 1:length(fits)
    [F, fits(i).Loopup_Values] = DamperCurve(fits(i).coef,v,1);
    h = figure;
    hold on
    plot(v,F)
    scatter(fits(i).data(:,2),fits(i).data(:,1))
    hold off
    title(fits(i).name)
    grid on
    fits(i).figure = h;
%     pause(2)
    savefig([target_folder '/Figures/' fits(i).name '.fig'])
end