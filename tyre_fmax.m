function [F_x,F_y,F_xmax,F_ymax,F_xmin,F_ymin] = tyre_fmax(Fz,points)

SL = linspace(-1,1,points);

SA = linspace(-30,30,points);

[SA,SL] = meshgrid(SA,SL);

[F_x,F_y,~] = PacejkaTest(SA,SL,Fz);
% F_x = rmmissing(F_x);
% F_y = rmmissing(F_y);
F_x(isnan(F_x)) = 0;
F_y(isnan(F_y)) = 0;

% figure
% surf(SA,SL,F_y)
% figure
% hold on
Force = zeros(length(F_x),length(F_x));
for i = 1:length(F_x)
    for j = 1:length(F_x)
%         scatter(F_x(i,j),F_y(i,j))
        Force(j + length(F_x) * (i-1),1) = F_x(i,j);
        Force(j + length(F_x) * (i-1),2) = F_y(i,j);
    end
end
% xlabel('Fx')
% ylabel('Fy')

k = boundary(Force(:,1),Force(:,2),0);
% k2 = k(1:end-1);
% k = k2;
k = k(1:end-1);

% xmin = 1;
% xmax = 1;
% ymin = 1;
% ymax = 1;
% % k_xmax = zeros(length(k),1);
% % k_xmin = zeros(length(k),1);
% % k_ymax = zeros(length(k),1);
% % k_ymin = zeros(length(k),1);
% for i = 1:length(k)
%     Fx = Force(k(i),1);
%     Fy = Force(k(i),2);
%     if Fx >= 0
% %         F_xmax(xmax) = Force(k(i),1);
%         k_xmax(xmax) = k(i);
%         xmax = xmax + 1;
%     end
%     if Fx <= 0
% %         F_xmin(xmin) = Force(k(i),1);
%         k_xmin(xmin) = k(i);
%         xmin = xmin + 1;
%     end
%     if Fy >= 0
% %         F_ymax(ymax) = Force(k(i),2);
%         k_ymax(ymax) = k(i);
%         ymax = ymax + 1;
%     end
%     if Fy <= 0
% %         F_ymin(ymin) = Force(k(i),2);
%         k_ymin(ymin) = k(i);
%         ymin = ymin + 1;
%     end
% end
Fx = Force(k,1);
Fy = Force(k,2);
k_xmax = k(Fx >= 0);
k_xmin = k(Fx <= 0);
k_ymax = k(Fy >= 0);
k_ymin = k(Fy <= 0);

if abs(Fz) == 0
    F_xmax = 0;
    F_xmin = 0;
    F_ymax = 0;
    F_ymin = 0;
else
    F_xmax = [Force(k_xmax,1),Force(k_xmax,2)];
    F_xmin = [Force(k_xmin,1),Force(k_xmin,2)];
    
    F_ymax = [Force(k_ymax,1),Force(k_ymax,2)];
    F_ymin = [Force(k_ymin,1),Force(k_ymin,2)];
end

% for i = 1:length(F_x)
%     [Fmax,pos] = max(F_x(:,i));
%     F_xmax(i,1) = Fmax;
%     F_xmax(i,2) = F_y(pos,i);
%     [Fmin,pos] = min(F_x(:,i));
%     F_xmin(i,1) = Fmin;
%     F_xmin(i,2) = F_y(pos,i);
% end
% 
% for i = 1:length(F_y)
%     [Fmax,pos] = max(F_y(i,:));
%     F_ymax(i,1) = F_x(i,pos);
%     F_ymax(i,2) = Fmax;
%     [Fmin,pos] = min(F_y(i,:));
%     F_ymin(i,1) = F_x(i,pos);
%     F_ymin(i,2) = Fmin;
% end

% figure
% hold on;
% scatter(F_xmax(:,1),F_xmax(:,2),1)
% scatter(F_ymax(:,1),F_ymax(:,2),1)
% scatter(F_xmin(:,1),F_xmin(:,2),1)
% scatter(F_ymin(:,1),F_ymin(:,2),1)
% title('Tyre Force Potential')
% xlabel('Tyre Fx Max (N)')
% ylabel('Tyre Fy Max (N)')