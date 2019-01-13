function [F_x,F_y,F_xmax,F_ymax,F_xmin,F_ymin] = tyre_fmax(Fz,mesh)

SL = linspace(-1,1,mesh);

SA = linspace(-30,30,mesh);

[SA,SL] = meshgrid(SA,SL);

[F_x,F_y,~] = PacejkaTest(SA,SL,Fz);

% figure
% surf(SA,SL,F_y)
% figure
% hold on
% for i = 1:length(F_x)
%     for j = 1:length(F_x)
%         scatter(F_x(i,j),F_y(i,j))
%     end
% end
% xlabel('Fx')
% ylabel('Fy')

for i = 1:length(F_x)
    [Fmax,pos] = max(F_x(:,i));
    F_xmax(i,1) = Fmax;
    F_xmax(i,2) = F_y(pos,i);
    [Fmin,pos] = min(F_x(:,i));
    F_xmin(i,1) = Fmin;
    F_xmin(i,2) = F_y(pos,i);
end

for i = 1:length(F_y)
    [Fmax,pos] = max(F_y(i,:));
    F_ymax(i,1) = F_x(i,pos);
    F_ymax(i,2) = Fmax;
    [Fmin,pos] = min(F_y(i,:));
    F_ymin(i,1) = F_x(i,pos);
    F_ymin(i,2) = Fmin;
end

% figure
% hold on;
% plot(F_xmax(:,1),F_xmax(:,2))
% plot(F_ymax(:,1),F_ymax(:,2))
% plot(F_xmin(:,1),F_xmin(:,2))
% plot(F_ymin(:,1),F_ymin(:,2))
% title('Tyre Force Potential')
% xlabel('Tyre Fx Max (N)')
% ylabel('Tyre Fy Max (N)')