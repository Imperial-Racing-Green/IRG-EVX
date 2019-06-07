    clear
    Track_Dist = 1000; %track distance in metres
    Track_Width = 4; %track width in meteres
    % Max_Track_Resolution = 1; %track points per metre
    Steps = 1; %steps in optmisation smoothness
    % Resolutions = linspace(0.5,Max_Track_Resolution,Steps);
    Resolution = 0.5;
    Iterations = 5000; %max iterations for optmisation

    %[x,y,theta,curvature,radius,Distance] = Track_Gen(filename,Interpolation,Length,Smoothing,Line_Optim,Track_Width,Optim_Iterations);
     [x,y,theta_d,curve_d,radius_d,distanceTrack] = Track_Gen('FSUK Track Endurance.csv',Track_Dist*Resolution,Track_Dist,'On','Off',Track_Width,Iterations);
