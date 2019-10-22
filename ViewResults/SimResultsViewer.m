% Plot dynamics of a single sim
close all
clear
clc

SimPath = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Year 3\GDP\Final Sims\BrakeBias\Sim1.mat';
Trackmap = 'Autocross_Track.mat';

Results = load(SimPath);
Track = load(Trackmap);

% Get plot variabels
plot_vars= fieldnamesr(Results,'full');
% plot_vars = {};
% Fields = fieldnames(Results);
% for i = 1:numel(Fields)
%     field = Fields{i};
%     if ~isstruct(Results.(field)) && ~isdouble(Results.(field))
%         plot_vars = field;
%     
%     
% end
figure();


figure();
subplot(2,1,1)
plot(Track.x,Track.y,'k','LineWidth',3)
axis equal
x = Track.x;
y = Track.y;
z = zeros(size(x));
c = Results.vCar;
surface([x, x],[y, y],[z, z],[c, c],'FaceColor','no','EdgeColor','interp','LineWidth',2);
colormap Jet
cb = colorbar;
cb.Label.String = 'vCar';
cb.Label.FontSize = 16;
subplot(2,1,2)
x = Results.sLap;
y = Results.vCar;
z = zeros(size(x));
c = Results.vCar;
surface([x, x],[y, y],[z, z],[c, c],'FaceColor','no','EdgeColor','interp','LineWidth',2);
grid on
xlabel('sLap')
ylabel('vCar')