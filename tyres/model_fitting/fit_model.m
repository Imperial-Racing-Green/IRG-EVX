clear
close all

load("Z:\Tyre Test Consortium Data\Round 6\RunData_10inch_Cornering_Matlab_SI\B1654run21.mat")
datamode = 'lateral';
% datamode = 'longitudinal';

figure
plot(ET,FZ,'.'); 
grid on
xlabel('Elapsed Time (s)');
ylabel('FZ (N)');
title('Variation of FZ','FontSize',10);
[countsFZ,edgesFZ] = histcounts(FZ);
[~,locsFZ] = findpeaks([countsFZ(2), countsFZ, countsFZ(end-1)]);

figure 
plot(ET,P);
xlabel('Elapsed Time (s)');
ylabel('P (kPa)');
grid on
title('Variation of Pressure','FontSize',10);
[countsP,edgesP] = histcounts(P);
[~,locsP] = findpeaks([countsP(2), countsP, countsP(end-1)]);

figure 
plot(ET,IA);
xlabel('Elapsed Time (s)');
ylabel('IA ({\circ}''s)');
grid on
title('Variation of IA','FontSize',10);
[countsIA,edgesIA] = histcounts(IA);
[~,locsIA] = findpeaks([countsIA(2), countsIA, countsIA(end-1)]);

FZ_binvalues = unique(round(abs(edgesFZ(locsFZ))));
P_binvalues = unique(round(edgesP(locsP)));
IA_binvalues = unique(round(edgesIA(locsIA)));

if( isempty(FZ_binvalues) || isempty(P_binvalues) || isempty(IA_binvalues) )
    error('One or more of the *_binValues arrays was empty.')
end

P_eps = 0.8;  % Pressure tolerance (psi)
P_bin = P>(P_binvalues-P_eps-0.3)&P<(P_binvalues+P_eps); %(psi)

IA_eps = 0.2; % Inclination angle tolerance (deg)
IA_bin = (IA>IA_binvalues-IA_eps)&(IA<IA_binvalues+IA_eps); %(deg)

FZ_eps1 = 50; % Normal force tolerance (N)
FZ_bin = abs(FZ)>((FZ_binvalues-FZ_eps1))&abs(FZ)<((FZ_binvalues+FZ_eps1)); %(N)

if strcmp(datamode, 'lateral')
    S_0 = (-1<SA)&(SA<1);
elseif strcmp(datamode, 'longitudinal')
    S_0 = (-1<SR)&(SR<1);
end

[IA_mat,FZ_mat] = meshgrid(IA_binvalues,FZ_binvalues);

A = cell(length(P_binvalues),length(IA_binvalues),length(FZ_binvalues));
[S_binfzia, F_binfzia, NF_binfzia, ET_binfzia, FZ_binfzia, IA_binfzia, ...
    MX_binfzia, MZ_binfzia, CS_fzia, mu_fzia, S_H_fzia, S_V_fzia, S_bar_fzia, ...
    F_bar_fzia, B_fzia, C_fzia, D_fzia, E_fzia, F_M, S_M] = deal(A);

B = cell(length(P_binvalues), 1);
[B_P, C_P, D_P, E_P, S_S_P, S_V_P, mu_P, S_H_P, CS_P, S_H_surf_IA_P, ...
    S_V_surf_IA_P, Mu_surf_IA_P, CS_surf_IA_P, B_surf_IA_P, C_surf_IA_P, ...
    D_surf_IA_P, E_surf_IA_P, coef] = deal(B);

idx2 = 1;
for i=1:length(P_binvalues)
    for m=1:size(FZ_bin,2)
        for n=1:size(IA_bin,2)
            validIdx = FZ_bin(:,m) & P_bin(:,i) & IA_bin(:,n);% & S_0;
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
%                 S_binfzia{i,n,m}  =  SA(validIdx);  % Slip Angle Bins
                S_binfzia{i,n,m}  =  0.0174533*SA(validIdx);  % Slip Angle Bins (convert deg to rad)
            end
            
            coef{i,n,m} = fit_pacejka(-S_binfzia{i,n,m},F_binfzia{i,n,m});
            
            x = IA_binvalues;
            y = FZ_binvalues;
            
            
%             if (i==1) && (n==1) && (m==1)
                clear pac_fit
                if exist('h')
                    close(h)
                end
                h = figure(5);
                scatter(S_binfzia{i,n,m},F_binfzia{i,n,m})
                hold on

                for idx = 1:length(S_binfzia{i,n,m})
                    pac_fit(idx) = pacejka4(coef{i,n,m},S_binfzia{i,n,m}(idx));
                end
                plot(-S_binfzia{i,n,m},pac_fit)
                disp(num2str(coef{i,n,m}))
                coef_out(idx2,:) = coef{i,n,m};
                idx2 = idx2+1;
%                 keyboard
                pause(0.01)
%             end

        end
    end
end