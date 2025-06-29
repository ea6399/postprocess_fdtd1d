%% Chargement des données
data_fd = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_5.txt';
data_cn = '/home/emin/Documents/CN_FDTD1D/E_5.txt';
path_params = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/params.txt';

E_fd_interm = load(data_fd);
E_cn_interm = load(data_cn);

fprintf('\n Données E chargées.\n');
fprintf('\n Taille données E: [%d, %d]\n', size(E_fd_interm));

%% Traitement des données - Redimensionnement
% Paramètres du redimensionnement
params = load(path_params);  % Nt, Nx + 1, dx, dt, snapshot
Nt = params(1);
Nx = params(2);
dx = params(3);
dt = params(4);
snapshot = params(5);
n_block = Nt / snapshots; 

% Pas spatial et temporel
fprintf('\n Pas spatial dx: %.3e m\n', dx);
fprintf('\n Pas temporel dt: %.3e s\n', dt);

% Redimensionnement
E_fd = reshape(E_fd_interm, n_block + 1, Nx).';  % Transposition pour [Nx, n_block+1]
E_cn = reshape(E_cn_interm, n_block + 1, Nx).';

fprintf('\n Taille données E (FD après reshape): [%d, %d]\n', size(E_fd));
fprintf('\n Taille données E (CN après reshape): [%d, %d]\n', size(E_cn));

%% Paramètres de la simulation
epsilon_0 = 8.854187817e-12;  % Permittivité du vide [F/m]
mu_0 = 4 * pi * 1e-7;         % Perméabilité du vide [H/m]
c = 1 / sqrt(epsilon_0 * mu_0); % Vitesse de la lumière [m/s]
fprintf('\n Vitesse de la lumière c: %.3e m/s\n', c);

mesh_density = 50;
fmax = 1e9;                    % Fréquence maximale [Hz]
lambda = c / fmax;             % Longueur d'onde [m]
omega = 2 * pi * fmax;         % Pulsation [rad/s]
k0 = 2 * pi / lambda;          % Nombre d'onde [rad/m]

attfmax = 1000;
att0 = 1000;
a0 = 1.0;
T = sqrt(log(attfmax)) / (pi * fmax);
t0 = T * sqrt(log(att0));
CFL = 0.98;
S = CFL;

fs = 1 / dt; % Fréquence d'échantillonnage [Hz]
fprintf('\n Fréquence d''échantillonnage fs: %.3e Hz', fs);

%% Création de l'axe temporel
t = 0:dt:(Nt-1)*dt; % Vecteur temps [s]
fprintf('\n Taille vecteur temps: %d\n', length(t));

%% Sélection du point spatial
x_j0 = 50; % Indice spatial (Nx/4 pour Nx=500)
e_fd = E_fd(x_j0, :); % Signal temporel FD
e_cn = E_cn(x_j0, :); % Signal temporel CN

fprintf('\n Taille e_fd: %d\n', length(e_fd));
fprintf('\n Taille e_cn: %d\n', length(e_cn));

%% Analyse spectrale par FFT
% Calcul des FFT
Efd_fft = fft(e_fd);
Ecn_fft = fft(e_cn);

z_fd = fftshift(Efd_fft);
z_cn = fftshift(Ecn_fft);

% Calcul du vecteur fréquence
%frequencies = (0:n_block) * (fs / (n_block));
frequencies = (-n_block/2 : n_block/2)/n_block * fs;


%% Tracé du spectre
figure('Position', [100 100 1200 800], 'Color','white');
subplot(1,2,1)
plot(frequencies,abs(z_fd),'DisplayName','FDTD'); hold on
plot(frequencies,abs(z_cn),'--','DisplayName','CNFDTD')
title('Amplitude');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
legend('show');
grid on;

subplot(1,2,2);
plot(frequencies,unwrap(angle(z_fd)),'DisplayName','FDTD'); hold on
plot(frequencies,unwrap(angle(z_cn)),'--','DisplayName','CNFDTD');
title('Phase');
xlabel('Frequency [Hz]');
ylabel('Phase / \pi');
legend('Show')
grid on;
