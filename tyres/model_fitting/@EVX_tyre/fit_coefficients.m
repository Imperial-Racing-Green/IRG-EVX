function [coef,testcases] = fit_coefficients(filename)
%FIT_DATASET Summary of this function goes here
%   Detailed explanation goes here
data = load(filename);

%% Make data bins

if max(data.SL) > 0.1
    datatype = 'long';
else
    datatype = 'lat';
end

[countsFZ,edgesFZ] = histcounts(data.FZ);
[~,locsFZ] = findpeaks([countsFZ(2), countsFZ, countsFZ(end-1)]);

[countsP,edgesP] = histcounts(data.P);
[~,locsP] = findpeaks([countsP(2), countsP, countsP(end-1)]);

[countsIA,edgesIA] = histcounts(data.IA);
[~,locsIA] = findpeaks([countsIA(2), countsIA, countsIA(end-1)]);

if strcmp(datatype,'long')
    [countsSA,edgesSA] = histcounts(data.SA);
    [~,locsSA] = findpeaks([countsSA(2), countsSA, countsSA(end-1)]);
    SA_binvalues = unique(round(edgesSA(locsSA)));
else
    SA_binvalues = 0;
end

FZ_binvalues = unique(round(abs(edgesFZ(locsFZ))));
P_binvalues = unique(round(edgesP(locsP)));
IA_binvalues = unique(round(edgesIA(locsIA)));

if( isempty(FZ_binvalues) || isempty(P_binvalues) || isempty(IA_binvalues) || isempty(SA_binvalues) )
    error('One or more of the *_binValues arrays was empty.')
end

P_eps = 8;  % Pressure tolerance
P_bin = data.P>(P_binvalues-P_eps-0.3)&data.P<(P_binvalues+P_eps);

IA_eps = 0.2; % Inclination angle tolerance (deg)
IA_bin = (data.IA>IA_binvalues-IA_eps)&(data.IA<IA_binvalues+IA_eps); %(deg)

FZ_eps1 = 50; % Normal force tolerance (N)
FZ_bin = abs(data.FZ)>((FZ_binvalues-FZ_eps1))&abs(data.FZ)<((FZ_binvalues+FZ_eps1)); %(N)

if strcmp(datatype,'long')
    SA_eps = 0.5; % Inclination angle tolerance (deg)
    SA_bin = (data.SA>SA_binvalues-SA_eps)&(data.SA<SA_binvalues+SA_eps); %(deg)
end

if strcmp(datatype, 'lat')
    S_0 = (-1<data.SA)&(data.SA<1);
elseif strcmp(datatype, 'long')
    S_0 = (-1<data.SR)&(data.SR<1);
end

idx2 = 1;
h = figure('units','normalized','outerposition',[0 0 1 1]);
for j = 1:length(SA_binvalues)
    for i=1:length(P_binvalues)
        for m=1:size(FZ_bin,2)
            for n=1:size(IA_bin,2)
                
                %validIdx contains the indices of all data points with the
                %desired input parameters
                
                if strcmp(datatype, 'long')
                    validIdx = FZ_bin(:,m) & P_bin(:,i) & IA_bin(:,n) & SA_bin(:,j);
                else
                    validIdx = FZ_bin(:,m) & P_bin(:,i) & IA_bin(:,n);
                end
                
                ET_binfzia{i,n,m,j}  =  data.ET(validIdx);  % Time Bins
                FZ_binfzia{i,n,m,j}  =  data.FZ(validIdx);  % Vertical Load bins
                IA_binfzia{i,n,m,j}  =  data.IA(validIdx);  % Inclination Angle bins
                MX_binfzia{i,n,m,j}  =  data.MX(validIdx);  % Overturning Moment bins
                MZ_binfzia{i,n,m,j}  =  data.MZ(validIdx);  % Aligning Moment bins
                
                FY_binfzia{i,n,m,j}  =  data.FY(validIdx);  % Lateral Force Bins
                FX_binfzia{i,n,m,j}  =  data.FX(validIdx);  % Longitudinal Force Bins
                NF_binfzia{i,n,m,j} =  data.NFY(validIdx); % Force Coefficient bins
                SA_binfzia{i,n,m,j}  =  0.0174533*data.SA(validIdx);  % Slip Angle Bins (convert deg to rad)
                SR_binfzia{i,n,m,j}  =  data.SR(validIdx);  % Slip Angle Bins (convert deg to rad)
                
                %fit the Pacejka coefficients for the test case; slip angle negative
                %because of the sign conventions used in the TTC being opposite
                %to how the MF works
                
                if strcmp(datatype, 'lat')
                    [coef{i,n,m,j}] = fit_pacejka(-SA_binfzia{i,n,m,j},FY_binfzia{i,n,m,j},datatype);
                elseif strcmp(datatype, 'long')
                    [coef{i,n,m,j}] = fit_pacejka(SR_binfzia{i,n,m,j},FX_binfzia{i,n,m,j},datatype);
                    %TODO: need to fit some sort of combined slip coefficients
                end
                disp(num2str(coef{i,n,m,j}))
                
                testcases(idx2,1) = P_binvalues(i);
                testcases(idx2,3) = IA_binvalues(n);
                testcases(idx2,2) = FZ_binvalues(m);
                if strcmp(datatype, 'long')
                    testcases(idx2,4) = SA_binvalues(j);
                end
                
                %Plotting of results
                
                            %             subplot(121)
                            if strcmp(datatype, 'long')
                                scatter(-SR_binfzia{i,n,m,j},FX_binfzia{i,n,m,j})
                                xlabel('Slip Ratio')
                                ylabel('Longitudinal Force (N)')
                            elseif strcmp(datatype, 'lat')
                                scatter(SA_binfzia{i,n,m,j},FY_binfzia{i,n,m,j})
                                xlabel('Slip Angle (rad)')
                                ylabel('Lateral Force (N)')
                            end
                            hold on
                            [pac_fit, slip] = eval_pacejka(coef{i,n,m,j});
                            plot(-slip,pac_fit)
                            ylim([-4000 4000])
                            xlim([-0.6 0.6])
                            idx2 = idx2+1;
                            legend('Test Data','Pacejka Fit')
                            grid on
                            hold off
                            pause(1)
%                             keyboard
            end
        end
        
    end
end
end

