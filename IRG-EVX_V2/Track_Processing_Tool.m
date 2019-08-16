%% Track Processing Tool
% Script to convert x-y track files from WebPlotDigitizer to full x-y-z-w track files for the Lap Simulation.
% William Foster - wjfoster@hotmail.co.uk - 2019

%% Initialisation
clc
clear all
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
title('Track Map');
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
close all
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
Length = input('Enter track length (m): ');
Width = input('Enter general track width (m): ');

distance = Track_Dist(x,y);
% scale track to new distance
x = (Length/max(distance)) .* x;
y = (Length/max(distance)) .* y;
% create width and height arrays
w = Width * ones(length(x),1);
z = zeros(length(x),1);

disp(' ')

%% Tuning track width
disp('You will now tune the track width at each point of the track...')
disp('Click the start and end points of a section then type the track width for this section in (m)...')
disp('Press "+" to zoom in, "-" to zoom out and "Enter" when finished.')
pause(1)
input('Press "Enter" to start...');

while true
    q = [];
    hold off
    [x_left,y_left,x_right,y_right,~,~] = Track_Boundary(x,y,w);
    
    plot(x,y,'r');
    title('Track Map');
    axis equal
    ax = gca;
    fig = ancestor(ax, 'figure');
    set(fig,'WindowState','maximized');
    hold on
    plot(x_left,y_left,'k');
    plot(x_right,y_right,'k');
    
    while size(q,1) < 2
        c = ginput_zoom(1);
        if isempty(c); close all; break; end
        scatter(c(1),c(2),'xb');
        q=[q;c];
    end
    pause(0.1)
    close all
    if size(q,1) < 2; break; end
    new_w = input('Enter width for this section of track (m): ');
    if isempty(new_w)
    else
        [~,start_row] = min(((x-q(1,1)).^2 + (y-q(1,2)).^2).^0.5);
        [~,end_row] = min(((x-q(2,1)).^2 + (y-q(2,2)).^2).^0.5);
        
        if end_row < start_row
            temp = start_row;
            start_row = end_row;
            end_row = temp;
            clear temp
        end
        
        w(start_row:end_row) = new_w;
    end
    clear q
end
disp(' ')
disp('The width of the track has now been tuned...')
disp(' ')
%% Tuning track height
disp('You will now tune the track heigth at each point of the track...')
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
    title('Track Map');
    axis equal
    ax = gca;
    fig = ancestor(ax, 'figure');
    set(fig,'WindowState','maximized');
    hold on
    plot(x_left,y_left,'k');
    plot(x_right,y_right,'k');
    subplot(2,1,2);
    
    plot(z_array(:,1).*(Length/length(x)),z_array(:,2),'k');
    title('Track z Height');
    xlabel('Distance (m)');
    ylabel('Track z height (m)');
    subplot(2,1,1);
    while size(q,1) < 1
        c = ginput_zoom(1);
        if isempty(c); close all; break; end
        scatter(c(1),c(2),'xb');
        q=[q;c];
    end
    pause(0.1)
    close all
    if size(q,1) < 1; break; end
    new_z = input('Enter height for this section of track (m): ');
    if isempty(new_z)
    else
        [~,position] = min(((x-q(1)).^2 + (y-q(2)).^2).^0.5);
        
        if position == length(x)
            z_array(end,2) = new_z;
        else
            z_array = [z_array;position,new_z];
            z_array = sortrows(z_array,1);
        end
    end
    clear q
end
z = interp1(z_array(:,1),z_array(:,2),linspace(1,length(x),length(x)),'linear')';

disp(' ')
disp('The height of the track has now been tuned...')
disp(' ')

%% Saving finished track
disp('The track processing is now complete...')
disp(' ')
disp('The new file must now be saved...')
output = table(x,y,z,w);

savename = [];
while isempty(savename)
    savename = input('Enter name to save file: ','s');
end

writetable(output,strcat(savename,'.csv'));

disp(' ')
disp('Saving complete...')
disp('Track Processing Tool finished.')