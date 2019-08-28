%% Track Processing Tool
% Script to convert x-y track files from WebPlotDigitizer to full x-y-z-w-t track files for the Lap Simulation.
% William Foster - wjfoster@hotmail.co.uk - 2019

%% Initialisation
clc
clear
close all

%% Folder Set-Up
% Add folders for Windows PC systems
if ispc == 1
    addpath([pwd '\Track Files'])
    addpath([pwd '\Functions'])
end

% Add folders for MacOS systems
if ismac == 1
    addpath([pwd '/Track Files'])
    addpath([pwd '/Functions'])
end

%% Display initial instructions
disp('This tool will help process a track from the base .csv format from WebPlotDigitizer to a file set to the correct length, width, and height values...')
disp('Please follow the instructions to complete track processing.')
disp(' ');

%% Get raw .csv file from user
disp('Please locate the .csv file to be processed.');
pause(1)
input('Press "Enter" to continue...');

[file,path] = uigetfile('.csv');

track = csvread(strcat(path,file));
x = track(:,1);
y = track(:,2);
disp(' ')

%% Adjust Start Finish point
disp('The start point must be determined...')
disp('When the track map shows, click the start point.')
disp('Press "+" to zoom in, "-" to zoom out.')
pause(1)
input('Press "Enter" to continue...');
% Plot track
plot(x,y,'r');
title('Click the location of the start point of the track.');
axis equal
ax = gca;
fig = ancestor(ax, 'figure');
set(fig,'WindowState','maximized');
% get user start finish point
s=[];
while isempty(s)
    s = ginput_zoom(1);
end
hold on
scatter(s(1),s(2),'xb')
pause(0.1)
close
% find closest corresponding point on track
dist = ((s(1)-x).^2 + (s(2)-y).^2).^0.5;
[~,start] = min(dist);
% shift points and re-zero on start
x = circshift(x,length(x) - start + 1);
y = circshift(y,length(y) - start + 1);
x = x - x(1);
y = y - y(1);

disp(' ')

%% Enter general track information and modify accordingly
disp('Please enter the folowing basic track information...')
Length = [];
while isempty(Length)
    Length = input('Enter track length (m): ');
end
Width = [];
while isempty(Width)
    Width = input('Enter general track width (m): ');
end

distance = Track_Dist(x,y);
% scale track to new distance
x = (Length/max(distance)) .* x;
y = (Length/max(distance)) .* y;
distance = Track_Dist(x,y);
% create width array
w = Width * ones(length(x),1);
z = zeros(length(x),1);
t = zeros(length(x),1);

disp(' ')

% %% Tuning track width
% disp('You will now tune the track width at each point of the track...')
% disp('Click the start and end points of a section then type the track width for this section in (m)...')
% disp('Press "+" to zoom in, "-" to zoom out and "Enter" when finished.')
% pause(1)
% input('Press "Enter" to start...');
%
% while true
%     q = [];
%     hold off
%     [x_left,y_left,x_right,y_right,~,~] = Track_Boundary(x,y,w);
%
%     plot(x,y,'r');
%     title('Track Map');
%     axis equal
%     ax = gca;
%     fig = ancestor(ax, 'figure');
%     set(fig,'WindowState','maximized');
%     hold on
%     plot(x_left,y_left,'k');
%     plot(x_right,y_right,'k');
%
%     while size(q,1) < 2
%         c = ginput_zoom(1);
%         if isempty(c); close; break; end
%         scatter(c(1),c(2),'xb');
%         q=[q;c];
%     end
%     pause(0.1)
%     close
%     if size(q,1) < 2; break; end
%     new_w = input('Enter width for this section of track (m): ');
%     if isempty(new_w)
%     else
%         [~,start_row] = min(((x-q(1,1)).^2 + (y-q(1,2)).^2).^0.5);
%         [~,end_row] = min(((x-q(2,1)).^2 + (y-q(2,2)).^2).^0.5);
%
%         if end_row < start_row
%             temp = start_row;
%             start_row = end_row;
%             end_row = temp;
%             clear temp
%         end
%
%         w(start_row:end_row) = new_w;
%     end
%     clear q
% end
% disp(' ')
% disp('The width of the track has now been tuned...')
% disp(' ')

%% Tuning track width
disp('You will now tune the track width at each point of the track...')
disp('Click a point on the track then type the track width in (m)...')
disp('Press "+" to zoom in, "-" to zoom out and "Enter" when finished.')
pause(1)
input('Press "Enter" to start...');

w_array = [0,Width;length(x),Width];
while true
    q = [];
    hold off
    [x_left,y_left,x_right,y_right,~,~] = Track_Boundary(x,y,w);
    plot(x,y,'r');
    title({'Click a point on the track to set the track width.'...
        ;'Press "+" to zoom in, "-" to zoom out and "Enter" when finished.'});
    axis equal
    ax = gca;
    fig = ancestor(ax, 'figure');
    set(fig,'WindowState','maximized');
    hold on
    plot(x_left,y_left,'k');
    plot(x_right,y_right,'k');
    scatter(x(1),y(1),'+r','LineWidth',0.5);
    if length(w_array) > 2
        for i = 2:length(w_array)-1
            scatter(x(w_array(i,1)),y(w_array(i,1)),'xb');
            text(x(w_array(i,1)),y(w_array(i,1)),[num2str(w_array(i,2)),'m'],'FontSize',20);
        end
    end
    while size(q,1) < 1
        c = ginput_zoom(1);
        if isempty(c); close; break; end
        scatter(c(1),c(2),'xb');
        q=[q;c];
    end
    pause(0.1)
    close
    if size(q,1) < 1; break; end
    new_w = input('Enter width for this point on the track (m): ');
    if isempty(new_w)
    else
        [~,position] = min(((x-q(1)).^2 + (y-q(2)).^2).^0.5);
        
        if position == length(x)
            w_array(end,2) = new_w;
        elseif position == 1
            w_array(1,2) = new_w;
        else
            w_array = [w_array;position,new_w];
            w_array = sortrows(w_array,1);
        end
    end
    w = interp1(w_array(:,1),w_array(:,2),linspace(1,length(x),length(x)),'linear')';
    clear q
end

disp(' ')
disp('The track width of the track has now been tuned...')
disp(' ')


%% Tuning track height
disp('You will now tune the track height at each point of the track...')
disp('Click a point on the track then type the track height in (m)...')
disp('Press "+" to zoom in, "-" to zoom out and "Enter" when finished.')
pause(1)
input('Press "Enter" to start...');

z_array = [0,0;length(x),0];
while true
    q = [];
    hold off
    [x_left,y_left,x_right,y_right,~,~] = Track_Boundary(x,y,w);
    subplot(2,1,1);
    plot(x,y,'r');
    title({'Click a point on the track to set the track heigth.'...
        ;'Press "+" to zoom in, "-" to zoom out and "Enter" when finished.'});
    axis equal
    ax = gca;
    fig = ancestor(ax, 'figure');
    set(fig,'WindowState','maximized');
    hold on
    plot(x_left,y_left,'k');
    plot(x_right,y_right,'k');
    scatter(x(1),y(1),'+r','LineWidth',0.5);
    if length(z_array) > 2
        for i = 2:length(z_array)-1
            scatter(x(z_array(i,1)),y(z_array(i,1)),'xb');
            text(x(z_array(i,1)),y(z_array(i,1)),[num2str(z_array(i,2)),'m'],'FontSize',20);
        end
    end
    
    subplot(2,1,2);
    
    plot(polyshape(distance,z,'Simplify',0),'FaceColor','k','FaceAlpha',0.75);
    xlim([0,max(distance)]);
    title('Track z Height');
    xlabel('Distance (m)');
    ylabel('Track z height (m)');
    subplot(2,1,1);
    while size(q,1) < 1
        c = ginput_zoom(1);
        if isempty(c); close; break; end
        scatter(c(1),c(2),'xb');
        q=[q;c];
    end
    pause(0.1)
    close
    if size(q,1) < 1; break; end
    new_z = input('Enter height for this point on the track (m): ');
    if isempty(new_z)
    else
        [~,position] = min(((x-q(1)).^2 + (y-q(2)).^2).^0.5);
        
        if position == length(x)
            z_array(end,2) = new_z;
        elseif position == 1
            z_array(1,2) = new_z;
        else
            z_array = [z_array;position,new_z];
            z_array = sortrows(z_array,1);
        end
    end
    [~,z] = SmoothFit(z_array(:,1),z_array(:,2),length(x),2,'pchip');
    clear q
end
z = z - min(z);

disp(' ')
disp('The height of the track has now been tuned...')
disp(' ')

%% Tuning track camber
disp('You will now tune the track camber at each point of the track...')
disp('Click a point on the track then type the camber angle in (deg)...')
disp('Press "+" to zoom in, "-" to zoom out and "Enter" when finished.')
pause(1)
input('Press "Enter" to start...');

t_array = [0,0;length(x),0];
while true
    q = [];
    hold off
    [x_left,y_left,x_right,y_right,~,~] = Track_Boundary(x,y,w);
    subplot(2,1,1);
    plot(x,y,'r');
    title({'Click a point on the track to set the track camber.'...
        ;'Press "+" to zoom in, "-" to zoom out and "Enter" when finished.'});
    axis equal
    ax = gca;
    fig = ancestor(ax, 'figure');
    set(fig,'WindowState','maximized');
    hold on
    plot(x_left,y_left,'k');
    plot(x_right,y_right,'k');
    scatter(x(1),y(1),'+r','LineWidth',0.5);
    if length(t_array) > 2
        for i = 2:length(t_array)-1
            scatter(x(t_array(i,1)),y(t_array(i,1)),'xb');
            text(x(t_array(i,1)),y(t_array(i,1)),[num2str(t_array(i,2)),'deg'],'FontSize',20);
        end
    end
    
    subplot(2,1,2);
    
    plot(polyshape(distance,t,'Simplify',0),'FaceColor','k','FaceAlpha',0.75);
    xlim([0,max(distance)]);
    title('Track Camber Angle');
    xlabel('Distance (m)');
    ylabel('Camber Angle (deg)');
    subplot(2,1,1);
    while size(q,1) < 1
        c = ginput_zoom(1);
        if isempty(c); close; break; end
        scatter(c(1),c(2),'xb');
        q=[q;c];
    end
    pause(0.1)
    close
    if size(q,1) < 1; break; end
    new_t = input('Enter camber angle for this point on the track (deg) (tilting right is positive): ');
    if isempty(new_t)
    else
        [~,position] = min(((x-q(1)).^2 + (y-q(2)).^2).^0.5);
        
        if position == length(x)
            t_array(end,2) = new_t;
        elseif position == 1
            t_array(1,2) = new_t;
        else
            t_array = [t_array;position,new_t];
            t_array = sortrows(t_array,1);
        end
    end
    [~,t] = SmoothFit(t_array(:,1),t_array(:,2),length(x),2,'pchip');
    clear q
end

disp(' ')
disp('The camber of the track has now been tuned...')
disp(' ')

%% Plot result
disp('The track processing is now complete.')
disp('Check the finished track looks correct before saving...')
disp('Press "Enter" to close the figure.')
pause(1)
input('Press "Enter" to continue...');
disp(' ')
[x1,y1,x4,y4,~,~] = Track_Boundary(x,y,w);

x1 = Interpolate(length(x1),Length,x1,'spline')';
y1 = Interpolate(length(y1),Length,y1,'spline')';
x4 = Interpolate(length(x4),Length,x4,'spline')';
y4 = Interpolate(length(y4),Length,y4,'spline')';

z1 = zeros(length(x1),1);
z4 = zeros(length(x4),1);
x2 = x1;
y2 = y1;
x3 = x4;
y3 = y4;

z2 = Interpolate(length(z),Length,z,'spline')' + (Interpolate(length(w),Length,w,'spline')'./2).*sind(Interpolate(length(t),Length,t,'spline')');
z3 = Interpolate(length(z),Length,z,'spline')' - (Interpolate(length(w),Length,w,'spline')'./2).*sind(Interpolate(length(t),Length,t,'spline')');
disp('Loading finished 3D track visualisation...')
disp(' ')
figure
hold on
for i = 1:length(x1)-1
    fill3([x1(i:i+1);flip(x2(i:i+1))],[y1(i:i+1);flip(y2(i:i+1))],[z1(i:i+1);flip(z2(i:i+1))],'k',...
        [x2(i:i+1);flip(x3(i:i+1))],[y2(i:i+1);flip(y3(i:i+1))],[z2(i:i+1);flip(z3(i:i+1))],[z2(i:i+1);flip(z3(i:i+1))],...
        [x3(i:i+1);flip(x4(i:i+1))],[y3(i:i+1);flip(y4(i:i+1))],[z3(i:i+1);flip(z4(i:i+1))],'k','EdgeColor','none');
end
set(gca,'XColor', 'none','YColor','none','ZColor','none')
daspect([1 1 (max(z)*10)/max(x)])
title('Press "Enter" to close the figure.')
c = colorbar;
c.Label.String = 'z height (m)';
ax = gca;
fig = ancestor(ax, 'figure');
set(fig,'WindowState','maximized');
view(0,45)
disp('Track visualisation loaded.')
disp(' ')
button = 0;
while button == 0
    button = waitforbuttonpress;
    zlim([min([min(z1),min(z2),min(z3),min(z4)]) max([max(z1),max(z2),max(z3),max(z4)])]);
end
close
%% Saving finished track
output = table(x,y,z,w,t);
saveop = [];
while 1
    saveop = input('Is the finished track correct and to be saved? (yes/no) ','s');
    if strcmpi(saveop,'yes') == 1
        break
    elseif strcmpi(saveop,'no') == 1
        break
    end
end
if strcmpi(saveop,'yes') == 1
    savename = [];
    disp(' ')
    disp('Please select location to save file...')
    input('Press "Enter" to continue...');
    disp(' ')
    location = uigetdir;
    while isempty(savename)
        savename = input('Enter name to save file: ','s');
    end
    
    if ispc == 1
        writetable(output,strcat([location,'\',savename],'.csv'));
    end
    
    if ismac == 1
        writetable(output,strcat([location,'/',savename],'.csv'));
    end
    
    disp(' ')
    disp('Saving complete...')
else
    disp(' ')
    disp('Track has not been saved.')
    disp(' ')
end
disp('Track Processing Tool finished.')
%% End