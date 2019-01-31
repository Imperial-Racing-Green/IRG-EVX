clear
close all

tic

addpath([char(pwd) '\PolyfitnTools'])
%% Data File Selection
% Hoosier 10" Lateral
filename_lat = "C:\Users\Owen Heaney\Documents\FSAE TTC Data\RunData_10inch_Cornering_Matlab_SI\B1654run21.mat";

%Hoosier 10" Longitudinal & Combined
filename_comb = "Z:\Tyre Test Consortium Data\Round 6\RunData_10inch_DriveBrake_Matlab_SI\B1654run35.mat";

load(filename_lat)
datamode = 'lateral';
% datamode = 'longitudinal';

%% Plot Raw Data, make bins
% Code plots some key test input data, then finds the values of these
% inputs used in the test cases (i.e. the vertical loads used)

%Vertical Force
figure
plot(ET,FZ,'.'); 
grid on
xlabel('Elapsed Time (s)');
ylabel('FZ (N)');
title('Variation of FZ','FontSize',10);
[countsFZ,edgesFZ] = histcounts(FZ);
[~,locsFZ] = findpeaks([countsFZ(2), countsFZ, countsFZ(end-1)]);

%Pressure
figure 
plot(ET,P);
xlabel('Elapsed Time (s)');
ylabel('P (kPa)');
grid on
title('Variation of Pressure','FontSize',10);
[countsP,edgesP] = histcounts(P);
[~,locsP] = findpeaks([countsP(2), countsP, countsP(end-1)]);

%Inclination Angle
figure 
plot(ET,IA);
xlabel('Elapsed Time (s)');
ylabel('IA ({\circ}''s)');
grid on
title('Variation of IA','FontSize',10);
[countsIA,edgesIA] = histcounts(IA);
[~,locsIA] = findpeaks([countsIA(2), countsIA, countsIA(end-1)]);

%Extract bin values
FZ_binvalues = unique(round(abs(edgesFZ(locsFZ))));
P_binvalues = unique(round(edgesP(locsP)));
IA_binvalues = unique(round(edgesIA(locsIA)));

if( isempty(FZ_binvalues) || isempty(P_binvalues) || isempty(IA_binvalues) )
    error('One or more of the *_binValues arrays was empty.')
end

P_eps = 8;  % Pressure tolerance
P_bin = P>(P_binvalues-P_eps-0.3)&P<(P_binvalues+P_eps); 

IA_eps = 0.2; % Inclination angle tolerance (deg)
IA_bin = (IA>IA_binvalues-IA_eps)&(IA<IA_binvalues+IA_eps); %(deg)

FZ_eps1 = 50; % Normal force tolerance (N)
FZ_bin = abs(FZ)>((FZ_binvalues-FZ_eps1))&abs(FZ)<((FZ_binvalues+FZ_eps1)); %(N)

% if strcmp(datamode, 'lateral')
    S_0 = (-1<SA)&(SA<1);
% elseif strcmp(datamode, 'longitudinal')
%     S_0 = (-1<SR)&(SR<1);
% end

[IA_mat,FZ_mat] = meshgrid(IA_binvalues,FZ_binvalues);

%% Data Fitting
% Code loops through pressure, vertical load and camber (in that order),
% fitting the 6 coefficients of the Pacejka model to the data for each test
% case

% Preallocate memory
A = cell(length(P_binvalues),length(IA_binvalues),length(FZ_binvalues));
[S_binfzia, F_binfzia, NF_binfzia, ET_binfzia, FZ_binfzia, IA_binfzia, ...
    MX_binfzia, MZ_binfzia, CS_fzia, mu_fzia, S_H_fzia, S_V_fzia, S_bar_fzia, ...
    F_bar_fzia, B_fzia, C_fzia, D_fzia, E_fzia, F_M, S_M] = deal(A);

Bb = cell(length(P_binvalues), 1);
[B, C, D, E, Sh, Sv, B_coef, C_coef, D_coef, E_coef, Sv_coef, Sh_coef, B_surf, C_surf, ...
    D_surf, E_surf, Sv_surf, Sh_surf, coef, resnorm, res, residual] = deal(Bb);
testcases = zeros(length(P_binvalues)*size(FZ_bin,2)*size(IA_bin,2),3);

idx2 = 1;
for i=1:length(P_binvalues)
    for m=1:size(FZ_bin,2)
        for n=1:size(IA_bin,2)
            
            %validIdx contains the indices of all data points with the
            %desired input parameters
            if strcmp(datamode, 'lateral')
                validIdx = FZ_bin(:,m) & P_bin(:,i) & IA_bin(:,n);
            elseif strcmp(datamode, 'longitudinal')
                validIdx = FZ_bin(:,m) & P_bin(:,i) & IA_bin(:,n) & S_0;
            end
            ET_binfzia{i,n,m}  =  ET(validIdx);  % Time Bins
            FZ_binfzia{i,n,m}  =  FZ(validIdx);  % Vertical Load bins
            IA_binfzia{i,n,m}  =  IA(validIdx);  % Inclination Angle bins
            MX_binfzia{i,n,m}  =  MX(validIdx);  % Overturning Moment bins
            MZ_binfzia{i,n,m}  =  MZ(validIdx);  % Aligning Moment bins
            
            if strcmp(datamode, 'longitudinal')
                F_binfzia{i,n,m}  =  FX(validIdx);  % Logitudinal Force Bins
                NF_binfzia{i,n,m} =  NFX(validIdx); % Force Coefficient bins
                S_binfzia{i,n,m}  =  SR(validIdx);  % Slip Ratio Bins
            elseif strcmp(datamode, 'lateral')
                F_binfzia{i,n,m}  =  FY(validIdx);  % Lateral Force Bins
                NF_binfzia{i,n,m} =  NFY(validIdx); % Force Coefficient bins
                S_binfzia{i,n,m}  =  0.0174533*SA(validIdx);  % Slip Angle Bins (convert deg to rad)
            end
            
            %fit the Pacejka coefficients for the test case; slip negative
            %because of the sign conventions used in the TTC being opposite
            %to how the MF works
            [coef{i,n,m}, resnorm{i,n,m}, residual{i,n,m}] = fit_pacejka(-S_binfzia{i,n,m},F_binfzia{i,n,m});
            disp(num2str(coef{i,n,m}))
            res{i,n,m} = sqrt(resnorm{i,n,m})/length(S_binfzia{i,n,m});
            disp(num2str(res{i,n,m}))
            
            testcases(idx2,1) = P_binvalues(i);
            testcases(idx2,3) = IA_binvalues(n);
            testcases(idx2,2) = FZ_binvalues(m);
            
            %Plotting of results 
            
            clear pac_fit
            if exist('h', 'var')
                close(h)
            end
            h = figure('units','normalized','outerposition',[0 0 1 1]);
%             subplot(121)
            scatter(S_binfzia{i,n,m},F_binfzia{i,n,m})
            hold on
            pac_fit = zeros(500,1);
            slip = linspace(-1,1,500);
            for idx = 1:500
                pac_fit(idx) = pacejka4(coef{i,n,m},slip(idx));
            end
            plot(-slip,pac_fit)
            ylim([-4000 4000])
            xlim([-0.6 0.6])
            idx2 = idx2+1;
            xlabel('Slip Angle (rad)')
            ylabel('Lateral Force (N)')
            legend('Test Data','Pacejka Fit')
            
%             B2= polyvaln(B_surf, [70, 180, 0]);
%             C2= polyvaln(C_surf, [70, 180, 0]);
%             D2=polyvaln(D_surf, [70, 180, 0]);
%             E2=polyvaln(E_surf, [70, 180, 0]);
%             Sh2=polyvaln(Sh_surf, [70, 180, 0]);
%             Sv2=polyvaln(Sv_surf, [70, 180, 0]);
%             coef_test = [B2, C2, D2, E2, Sv2, Sh2];
%             for idx = 1:500
%                 pac_fit2(idx) = pacejka4(coef_test,slip(idx));
%             end
%             plot(-slip,pac_fit2)
            
%             subplot(122)
%             scatter(pacejka4(coef{i,n,m},-S_binfzia{i,n,m}),residual{i,n,m})
%             xlabel('Predicted Fy (N)')
%             ylabel('residual')
%             %keyboard
            pause(1)
            
            % Put coefficients into separate arrays for outputting
            B_coef{i,n,m} = coef{i,n,m}(1);
            C_coef{i,n,m} = coef{i,n,m}(2); 
            D_coef{i,n,m} = coef{i,n,m}(3); 
            E_coef{i,n,m} = coef{i,n,m}(4); 
            Sv_coef{i,n,m} = coef{i,n,m}(5); 
            Sh_coef{i,n,m} = coef{i,n,m}(6); 
            
        end
    end
    
    % Plot surfaces
    if(false)
        % Defining figures:
        [x_plot,y_plot] = meshgrid(0:0.25:4,linspace(FZ_binvalues(1),FZ_binvalues(end),11));      
        figure
        ax2 = axes;
        hold on
        grid on
        title('B vs. FZ vs. IA');
        xlabel('Inclination Angle ({\circ}''s)','Rotation',20);
        ylabel('F_Z (N)','Rotation',-30);
        zlabel('B (-)');
        view([-37.5 30]);
        
        figure
        ax3 = axes;
        hold on
        grid on
        title('C vs. FZ vs. IA');
        xlabel('Inclination Angle ({\circ}''s)');
        ylabel('F_Z (N)','FontSize',10,'Rotation',-30);
        zlabel('C (-)');
        view([-37.5 30]);
        
        figure
        ax4 = axes;
        hold on
        grid on
        title('D vs. FZ vs. IA','FontSize',10);
        xlabel('Inclination Angle ({\circ}''s)','Rotation',20);
        ylabel('F_Z (N)','Rotation',-30);
        zlabel('D (-)','FontSize',10);
        view([-37.5 30]);
        
        figure
        ax5 = axes;
        hold on
        grid on
        title('E vs. FZ vs. IA','FontSize',10);
        xlabel('Inclination Angle ({\circ}''s)','FontSize',10,'Rotation',20);
        ylabel('F_Z (N)','Rotation',-30);zlabel('E (-)');
        view([-37.5 30]);
        
        
%         plot3(ax2,IA_mat,FZ_mat,B_surf{i}(IA_mat,FZ_mat),'.','MarkerSize',25,...
%             'MarkerEdgeColor',[i==1 i==2 i==3],'HandleVisibility','off');
%         mesh(ax2,x_plot,y_plot,(B_surf{i}(x_plot,y_plot)),'EdgeColor','none','LineWidth',2,...
%             'FaceAlpha',0.4,'FaceColor',[i==1 i==2 i==3],'DisplayName',[mat2str(P_binvalues(i)) ' kPa']);
%         plot3(ax3,IA_mat,FZ_mat,C_surf{i}(IA_mat,FZ_mat),'.','MarkerSize',25,...
%             'MarkerEdgeColor',[i==1 i==2 i==3],'HandleVisibility','off');
%         mesh(ax3,x_plot,y_plot,(C_surf{i}(x_plot,y_plot)),'EdgeColor','none','LineWidth',2,...
%             'FaceAlpha',0.4,'FaceColor',[i==1 i==2 i==3],'DisplayName',[mat2str(P_binvalues(i)) ' kPa']);
%         plot3(ax4,IA_mat,FZ_mat,D_surf{i}(IA_mat,FZ_mat),'.','MarkerSize',25,...
%             'MarkerEdgeColor',[i==1 i==2 i==3],'HandleVisibility','off');
%         mesh(ax4,x_plot,y_plot,(D_surf{i}(x_plot,y_plot)),'EdgeColor','none','LineWidth',2,...
%             'FaceAlpha',0.4,'FaceColor',[i==1 i==2 i==3],'DisplayName',[mat2str(P_binvalues(i)) ' kPa']);
%         plot3(ax5,IA_mat,FZ_mat,E_surf{i}(IA_mat,FZ_mat),'.','MarkerSize',25,...
%             'MarkerEdgeColor',[i==1 i==2 i==3],'HandleVisibility','off');
%         mesh(ax5,x_plot,y_plot,(E_surf{i}(x_plot,y_plot)),'EdgeColor','none','LineWidth',2,...
%             'FaceAlpha',0.4,'FaceColor',[i==1 i==2 i==3],'DisplayName',[mat2str(P_binvalues(i)) ' kPa']);

    end
end
    %% Fit Coefficient Surfaces
    % Currently the code can only fit to a polynomial with 2 independent
    % variables; using polyfitn might allow for fitting in more dimensions
    % (TODO!)
    x = P_binvalues;
    y = IA_binvalues;
    z = FZ_binvalues;
    
    % convert coeffients into arrays rather than cells
    B = cell2mat(B_coef);
    C = cell2mat(C_coef);
    D = cell2mat(D_coef);
    E = cell2mat(E_coef);
    Sv = cell2mat(Sv_coef);
    Sh = cell2mat(Sh_coef);
    
    B_1D = reshape(B,[i*n*m,1]);
    C_1D = reshape(C,[i*n*m,1]);
    D_1D = reshape(D,[i*n*m,1]);
    E_1D = reshape(E,[i*n*m,1]);
    Sv_1D = reshape(Sh,[i*n*m,1]);
    Sh_1D = reshape(Sv,[i*n*m,1]);
    
    %Fit surfaces
    B_surf = polyfitn(testcases,B_1D,2);
    C_surf = polyfitn(testcases,C_1D,2);
    D_surf = polyfitn(testcases,D_1D,2);
    E_surf = polyfitn(testcases,E_1D,2);
    Sv_surf = polyfitn(testcases,Sv_1D,2);
    Sh_surf = polyfitn(testcases,Sh_1D,2);

try
    hLegend(1) = legend(ax2,'show');
    hLegend(2) = legend(ax3,'show');
    % hLegend(3) = legend(ax4,'show');
    hLegend(4) = legend(ax5,'show');
catch 
end

n_points = 20;
x = linspace(FZ_binvalues(1),FZ_binvalues(end),n_points);
y = linspace(IA_binvalues(1),IA_binvalues(end),n_points);
[x,y] = meshgrid(x,y);
for i = 1:n_points
    for j = 1:n_points
        z(i,j) = polyvaln(D_surf,[P_binvalues(1), x(i,j), y(i,j)]);
    end
end
figure
surf(x,y,z,'EdgeColor','none')
hold on

loop = 1;
for i = 1:length(FZ_binvalues)
    for j = 1:length(IA_binvalues)
        x2(loop) = FZ_binvalues(i);
        y2(loop) = IA_binvalues(j);
        z2(loop) = D(1,j,i);
        loop = loop + 1;
    end
end
scatter3(x2, y2, z2)
xlabel('Vertical Load [N]')
ylabel('Inclination Angle [deg]')
zlabel('D')
legend('Model Fit','Test Points')

%% Prepare results for saving
% Data Value points
% IA_vect = IA_binvalues;
% FZ_vect = FZ_binvalues;
% 
% % n-D-LookUp Table Output
% bp3d1 = FZ_binvalues;
% bp3d2 = IA_binvalues;
% bp3d3 = P_binvalues;
% 
% B_Lookup3d_map = B_surf{1}(IA_mat,FZ_mat);
% C_Lookup3d_map = C_surf{1}(IA_mat,FZ_mat);
% D_Lookup3d_map = D_surf{1}(IA_mat,FZ_mat);
% E_Lookup3d_map = E_surf{1}(IA_mat,FZ_mat);
% Sh_Lookup3d_map = Sh_surf{1}(IA_mat,FZ_mat);
% Sv_Lookup3d_map = Sv_surf{1}(IA_mat,FZ_mat);
% 
% for Pidx = 2:numel(P_binvalues)
%     B_Lookup3d_map = cat(3, B_Lookup3d_map, B_surf{Pidx}(IA_mat,FZ_mat));
%     C_Lookup3d_map = cat(3, C_Lookup3d_map, C_surf{Pidx}(IA_mat,FZ_mat));
%     D_Lookup3d_map = cat(3, D_Lookup3d_map, D_surf{Pidx}(IA_mat,FZ_mat));
%     E_Lookup3d_map = cat(3, E_Lookup3d_map, E_surf{Pidx}(IA_mat,FZ_mat));
%     Sh_Lookup3d_map = cat(3, Sh_Lookup3d_map, Sh_surf{Pidx}(IA_mat,FZ_mat));
%     Sv_Lookup3d_map = cat(3, Sv_Lookup3d_map, Sv_surf{Pidx}(IA_mat,FZ_mat));
% end


%% Save Results
[pathstr,name,ext] = fileparts(filename_lat);

% save(fullfile(pwd,"surface_fits",[char(name) char("_MagicFormula_datapoints.mat")]),...
%     'bp3d1', 'bp3d2', 'bp3d3', 'B_Lookup3d_map', 'C_Lookup3d_map', 'D_Lookup3d_map', 'E_Lookup3d_map');
% save( fullfile(pwd,'surface_fits',[char(name) char('_MagicFormula_datasurfaces.mat')]),...
%     'B_surf','C_surf','D_surf','E_surf');
% save( fullfile(pwd,'models',[char(name) char('_MagicFormula_coefficient_model.mat')]),...
%     'B_surf','C_surf','D_surf','E_surf','FZ_binvalues','IA_binvalues',...
%     'P_binvalues');
toc