%% Chargement des données
data_fd = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_1.txt';
data_cn = '/home/emin/Documents/CN_FDTD1D/E_1.txt';
path_params = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/params.txt';

E_fd_interm = load(data_fd);
E_cn_interm = load(data_cn);

fprintf('\n Données E chargées.\n');
fprintf('\n Taille données E_fd : [%d, %d]\n', size(E_fd_interm));
fprintf('\n Taille données E_cn : [%d, %d]\n', size(E_fd_interm));


%% Traitement des données - Redimensionnement
% Paramètres du redimensionnement
params = load(path_params);  % Nt, Nx + 1, dx, dt, snapshot
Nt = params(1);
Nx = params(2);
dx = params(3);
dt = params(4);
snapshot = params(5);
n_block = Nt / snapshot; 

% Pas spatial et temporel
fprintf('\n Pas spatial dx: %.3e m\n', dx);
fprintf('\n Pas temporel dt: %.3e s\n', dt);

% Redimensionnement
E_fd = reshape(E_fd_interm, [Nx, n_block]);  
E_cn = reshape(E_cn_interm, [Nx, n_block]);

fprintf('\n Taille données E (FD après reshape): [%d, %d]\n', size(E_fd));
fprintf('\n Taille données E (CN après reshape): [%d, %d]\n', size(E_cn));

%% Paramètres de la simulation
epsilon_0 = 8.854187817e-12;  % Permittivité du vide [F/m]
mu_0 = 4 * pi * 1e-7;         % Perméabilité du vide [H/m]
c = 1 / sqrt(epsilon_0 * mu_0); % Vitesse de la lumière [m/s]
fprintf('\n Vitesse de la lumière c: %.3e m/s\n', c);


fmax = 1e9;                    % Fréquence maximale [Hz]
lambda = c / fmax;             % Longueur d'onde [m]
omega = 2 * pi * fmax;         % Pulsation [rad/s]
k0 = 2 * pi / lambda;          % Nombre d'onde [rad/m]

attfmax = 1000;
att0 = 1000;
a0 = 1.0;
T = sqrt(log(attfmax)) / (pi * fmax);
t0 = T * sqrt(log(att0));
CFL = 0.5;
S = CFL;


%% Sélection du point spatial
x_j0 = 250; % Indice spatial
e_fd = E_fd(x_j0, :); % Signal temporel FD
e_cn = E_cn(x_j0, :); % Signal temporel CN

fprintf('\n Taille e_fd: %d\n', length(e_fd));
fprintf('\n Taille e_cn: %d\n', length(e_cn));

%% Analyse spectrale par FFT
% Calcul des FFT
Efd_fft = fft(e_fd);
Ecn_fft = fft(e_cn);

n_ech = length(e_fd);
fprintf("\n Echantillon temporels : %d \n", size(e_fd))
T_max =  n_ech * snapshot * dt ;
fs = 1 / (snapshot * dt); % Fréquence d'échantillonnage [Hz]
fprintf('\n Fréquence d''échantillonnage fs: %.3e Hz \n', fs);
df = 1 / T_max;           % Résolution fréquentielle
f_axis = ( 0 : n_ech - 1 )*df;
f_semi = f_axis <= fs/4;            % Masque booléen des fréquences positives
f_ax_pos = f_axis(f_semi);

z_fd = Efd_fft;
z_cn = Ecn_fft;


z_fd_pos = z_fd(f_semi);
z_cn_pos = z_cn(f_semi);

omega_pos = 2 * pi * f_ax_pos;  % Fréquence angulairs

%% Phase
x_obs = x_j0 * dx;              % Position du point d'observation
k_theo = omega_pos / c;                                     % Onde physique

phase_theo = k_theo * x_obs;
phase_fd = unwrap(angle(z_fd_pos));
phase_cn = unwrap(angle(z_cn_pos));

%% Calcul des nombres d'onde
k_fd_measured =  phase_fd ./x_obs;                          % Dispersion numerique FDTD
k_cn_measured =  phase_cn ./ x_obs;                         % Dispersion numérique CN
k_fd_theo = (2/dx) * asin((1/S) * sin(omega_pos * dt/2));   % Relations de dispersion numériques théoriques
k_cn_theo = (2/dx) * atan((1/S) * sin(omega_pos * dt/2));


%% Calcul des vitesses relatives
vp = (omega_pos ./ k_theo) / c;  % Vitesse de phase théorique
vp_fd = (omega_pos ./ k_fd_theo) / c;  % Vitesse de phase FDTD
vp_cn = (omega_pos ./ k_cn_theo) / c;  % Vitesse de phase CN
vp_fd_measured = (omega_pos ./ k_fd_measured) / c;  % Vitesse de phase mesurée FDTD
vp_cn_measured = (omega_pos ./ k_cn_measured) / c;  % Vitesse de phase mesurée CN


%% Tracé du spectre

% Amplitude de l'onde
figure('Position', [100 100 1200 800], 'Color','white');
subplot(2,2,1);
plot(f_ax_pos,abs(z_fd_pos),'DisplayName','FDTD', LineWidth=1); hold on
plot(f_ax_pos,abs(z_cn_pos),'--','DisplayName','CNFDTD', LineWidth=1)
xlabel('Fréquence (Hz)');
ylabel('Amplitude Champ E');
legend('show');
grid on;

% Etude de phase
subplot(2,2,2);
plot(f_ax_pos,unwrap(angle(z_fd_pos),[],2),'DisplayName','FDTD', LineWidth=1); hold on
plot(f_ax_pos,unwrap(angle(z_cn_pos),[],2),'--','DisplayName','CNFDTD',LineWidth=1);
plot(f_ax_pos, phase_theo, 'k-', 'DisplayName', 'Physique',LineWidth=1);
title('Phase');
xlabel('Frequency [Hz]');
ylabel('Phase / \pi');
legend('Show')
grid on;

% Dispersions numeriques
subplot(2,2,3);
plot(omega_pos, k_fd_theo,'DisplayName','FD theo'); hold on
plot(omega_pos, k_cn_theo,'DisplayName','CN theo');
plot(omega_pos, k_fd_measured, 'DisplayName','FD exp');
plot(omega_pos, k_cn_measured, 'DisplayName','CN exp');
plot(omega_pos, k_theo, 'k-', 'DisplayName','Physique');
legend('show');
xlabel('Fréquences Angulaire [rad/s]')
ylabel('Nombre d''onde k [rad/m]')
title('Relation de dispersion')
grid on;

% Vitesses relatives
subplot(2,2,4)
plot(omega_pos, vp, 'k-', 'DisplayName','Physique'); hold on
plot(omega_pos, vp_fd, 'DisplayName','FD théorique');
plot(omega_pos, vp_cn, 'DisplayName','CN théorique');
plot(omega_pos, vp_fd_measured, 'DisplayName','FD mesuré');
plot(omega_pos, vp_cn_measured, 'DisplayName','CN mesuré');
xlabel('Fréquence Angulaire [rad/s]');
ylabel('Vitesse de phase relative');
legend('show');
grid on;


