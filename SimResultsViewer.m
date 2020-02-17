% Plot dynamics of a single sim
close all
clear
clc

SimPath = 'C:\Users\gregj\OneDrive\Documents\Documents\Imperial\Fomula Student\EV1 Sims\Test\Sim1.mat';
Trackmap = 'Endurance_Track_1000_new.mat';

Results = load(SimPath);
Track = load(Trackmap);

% Get plot variabels
plot_vars= fieldnamesr(Results,'full');

iDel = [];
for i = 1:length(plot_vars)
    str = plot_vars{i};
    fields = split(str,'.');
    S = Results;
    for ii = 1:(numel(fields)-1)
        S = S.(fields{ii});
    end
    Val = S.(fields{end});
    if isstruct(Val) || isstring(Val) || ischar(Val) || ~all(size(Val) == size(Results.sLap))
        iDel = [iDel, i];
    end
end
plot_vars(iDel) = [];
plot_vars = ['Not selected'; plot_vars];

fig = figure();
UI.Text.PlotVar = uicontrol('Style','text','HorizontalAlignment','left','String','Plot variables:','Units','Normalized','Position',[0.1 0.69 0.15 0.1]);
UI.Dropdown.PlotVar = uicontrol(fig,'Units','Normalized','Position',[0.25 0.5 0.3 0.3],'Style','popupmenu','String',plot_vars,'Value',1);
UI.Button.PlotVar = uicontrol(fig,'Units','Normalized','Position',[0.6 0.75 0.2 0.05],'Style','pushbutton','String','View on trackmap','Callback',{@fnPlotVariable,UI,Track,Results});
UI.Text.PlotX = uicontrol('Style','text','HorizontalAlignment','left','String','X variable:','Units','Normalized','Position',[0.1 0.44 0.15 0.1]);
UI.Dropdown.PlotX = uicontrol(fig,'Units','Normalized','Position',[0.25 0.25 0.3 0.3],'Style','popupmenu','String',plot_vars,'Value',1);
UI.Text.PlotY = uicontrol('Style','text','HorizontalAlignment','left','String','Y variable:','Units','Normalized','Position',[0.1 0.36 0.15 0.1]);
UI.Dropdown.PlotY = uicontrol(fig,'Units','Normalized','Position',[0.25 0.17 0.3 0.3],'Style','popupmenu','String',plot_vars,'Value',1);
UI.Text.PlotC = uicontrol('Style','text','HorizontalAlignment','left','String',{'Colour by:';'(Optional)'},'Units','Normalized','Position',[0.1 0.29 0.15 0.1]);
UI.Dropdown.PlotC = uicontrol(fig,'Units','Normalized','Position',[0.25 0.08 0.3 0.3],'Style','popupmenu','String',plot_vars,'Value',1);
UI.Button.CustomPlot = uicontrol(fig,'Units','Normalized','Position',[0.6 0.34 0.2 0.2],'Style','pushbutton','String','Custom Plot','Callback',{@fnCustomPlot,UI,Results});


function fnPlotVariable(src,event,UI,Track,Results)

if ~strcmp(UI.Dropdown.PlotVar.String{UI.Dropdown.PlotVar.Value},'Not selected')
    figure();
    subplot(2,1,1)
    plot(Track.x,Track.y,'k','LineWidth',3)
    axis equal
    x = Track.x;
    y = Track.y;
    z = zeros(size(x));
    str = UI.Dropdown.PlotVar.String{UI.Dropdown.PlotVar.Value};
    fields = split(str,'.');
    S = Results;
    for i = 1:(numel(fields)-1)
        S = S.(fields{i});
    end
    c = S.(fields{end});
    if islogical(c)
        c = double(c);
    end
    surface([x, x],[y, y],[z, z],[c, c],'FaceColor','no','EdgeColor','interp','LineWidth',2);
    colormap Jet
    cb = colorbar;
    cb.Label.String = str;
    cb.Label.FontSize = 16;
    subplot(2,1,2)
    x = Results.sLap;
    y = c;
    z = zeros(size(x));
    c = c;
    surface([x, x],[y, y],[z, z],[c, c],'FaceColor','no','EdgeColor','interp','LineWidth',2);
    grid on
    xlabel('sLap')
    ylabel(str)
else
    warning('Select a variable to plot!')
end

end


function fnCustomPlot(src,event,UI,Results)

if ~strcmp(UI.Dropdown.PlotX.String{UI.Dropdown.PlotX.Value},'Not selected') && ~strcmp(UI.Dropdown.PlotY.String{UI.Dropdown.PlotY.Value},'Not selected')
    strX = UI.Dropdown.PlotX.String{UI.Dropdown.PlotX.Value};
    strY = UI.Dropdown.PlotY.String{UI.Dropdown.PlotY.Value};
    if ~strcmp(UI.Dropdown.PlotC.String{UI.Dropdown.PlotC.Value},'Not selected')
        strC = UI.Dropdown.PlotC.String{UI.Dropdown.PlotC.Value};
    else
        strC = [];
    end
    % Get x data
    fields = split(strX,'.');
    S = Results;
    for i = 1:(numel(fields)-1)
        S = S.(fields{i});
    end
    x = S.(fields{end});
    if islogical(x)
        x = double(x);
    end
    % Get y data
    fields = split(strY,'.');
    S = Results;
    for i = 1:(numel(fields)-1)
        S = S.(fields{i});
    end
    y = S.(fields{end});
    if islogical(y)
        y = double(y);
    end
    % Get c data
    if ~isempty(strC)
        fields = split(strC,'.');
        S = Results;
        for i = 1:(numel(fields)-1)
            S = S.(fields{i});
        end
        c = S.(fields{end});
        if islogical(c)
            c = double(c);
        end
    end
    figure();
    if isempty(strC)
        scatter(x,y,20,'b','filled')
    else
        scatter(x,y,20,c,'filled')
        colormap Jet
        cb = colorbar;
        cb.Label.String = strC;
        cb.Label.FontSize = 16;
    end
    grid on
    xlabel(strX)
    ylabel(strY)
else
    warning('Select a variable to plot!')
end

end

% plot_vars = {};
% Fields = fieldnames(Results);
% for i = 1:numel(Fields)
%     field = Fields{i};
%     if ~isstruct(Results.(field)) && ~isdouble(Results.(field))
%         plot_vars = field;
%     
%     
% end


% figure();
% subplot(2,1,1)
% plot(Track.x,Track.y,'k','LineWidth',3)
% axis equal
% x = Track.x;
% y = Track.y;
% z = zeros(size(x));
% c = Results.vCar;
% surface([x, x],[y, y],[z, z],[c, c],'FaceColor','no','EdgeColor','interp','LineWidth',2);
% colormap Jet
% cb = colorbar;
% cb.Label.String = 'vCar';
% cb.Label.FontSize = 16;
% subplot(2,1,2)
% x = Results.sLap;
% y = Results.vCar;
% z = zeros(size(x));
% c = Results.vCar;
% surface([x, x],[y, y],[z, z],[c, c],'FaceColor','no','EdgeColor','interp','LineWidth',2);
% grid on
% xlabel('sLap')
% ylabel('vCar')