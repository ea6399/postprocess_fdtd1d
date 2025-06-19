%% Numerical dispersion

% Paramètres
c = 3e8;
CFL    = 0.98;           % nombre de Courant c*dt/dx
N      = 500;           % nombre de points
kdx     = linspace(0, pi, N);  % k*dx de 0 à pi
dx = abs(pi)/N;

% Relation de dispersion numérique pour FDTD
omega_dt = 2 * asin( CFL * sin(kdx/2) );
% Relation de dispersion numerique pour CN
CN_omega_dt = 2 * atan( CFL * sin(kdx/2) );

% Vitesse de phase normalisée
vphi_c = omega_dt ./ (kdx * CFL);
CN_vphi_c = CN_omega_dt ./ (kdx * CFL);

vphi_c(1) = 1;  % limite k->0
CN_vphi_c(1) = 1;

% Vitesse de groupe normalisée
vg_c = (CFL *dx / 2) / c * cos(kdx/2) ./ sqrt(1 - (CFL*sin(kdx/2)).^2);
CN_vg_c = (CFL * dx / 2) / c * cos(kdx/2) ./ (1 + CFL^2 * sin(kdx/2).^2);


%% Display
% 1) Dispersion : omega_dt vs kd
figure('Color','white');
fig = gcf;
fig.Position = [400,250,800,600];
plot(kdx, CFL*kdx, 'LineWidth',1.2); hold on        %w dt = CFL * k dx (Dispersion physique)
plot(kdx, omega_dt, '--', 'LineWidth',1.5);
plot(kdx, CN_omega_dt, 'b--o','MarkerIndices', 1:30:length(CN_vg_c)); hold off
xlabel('k \Deltax');
ylabel('\omega \Delta t');
legend('Dispersion physique','FDTD','CN-FDTD','Location','NorthWest');
title('Relation de dispersion FDTD 1D');
grid on

% 2) Vitesse de phase
figure('Color','white');
fig = gcf;
fig.Position = [400,250,800,600];
plot(kdx, vphi_c, "Color", "#D95319"); hold on
plot(kdx,CN_vphi_c, 'Color','blue'); hold off
xlabel('k \Delta x');
ylabel('v_\phi / c');
title('Vitesse de phase normalisée');
legend('FDTD','CN-FDTD')
grid on
%close(2);

% 3) Vitesse de groupe
figure('Color','white');
fig = gcf;
fig.Position = [400,250,800,600];
plot(kdx, vg_c, 'Color', '#D95319'); hold on
plot(kdx, CN_vg_c, 'Color', 'blue'); hold off
xlabel('k \Delta x');
ylabel('v_g / c');
title('Vitesse de groupe normalisée');
legend('FDTD','CN-FDTD')
grid on
%close(3);



err_tol = abs(CFL * kdx - omega_dt) ./ (CFL * kdx);
CN_err_tol = abs(CFL * kdx - CN_omega_dt) ./ (CFL * kdx);
tol = 0.01;



figure('Color','white');
fig = gcf;
fig.Position = [400,250,800,600];
plot(kdx,err_tol,kdx,CN_err_tol); hold on
xline(0.292325, '--r', 'Tol = 1% pour CN'); 
xline(1.965,'--r','Tol = 1% pour Yee');
plot(0.292325, 0, ...
    'xr', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
plot(1.965, 0, ...
    'xr', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
ax = gca;
ax.YLim = [0 0.01];
dim1 = [0.25 0.1 0.25 0.2];
dim2 = [0.65 0.7 0.25 0.2];
str1 = 'N_\lambda \approx 2 \pi / 0.3 \approx 20 pts /\lambda min';
str2 = 'N_\lambda \approx 2 \pi / 1.9 \approx 3 pts /\lambda min';
annotation('textbox',dim1, ...
           'String', str1, ...
           'FitBoxToText', ...
           'on')
annotation('textbox',dim2, ...
           'String', str2, ...
           'FitBoxToText', ...
           'on')
xlabel('k\Deltax');
ylabel('err');
title('Erreur tolérable en %');
legend('FDTD','CNFDTD', 'Location', 'SouthEast');
grid on;
