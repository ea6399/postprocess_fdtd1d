%% Chargement des données
data_fd = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_5.txt';
data_cn = '/home/emin/Documents/CN_FDTD1D/E_5.txt';
path_params = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/params.txt';

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
%t0 = T * sqrt(log(att0));
CFL = 0.98;
S = CFL;

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


E_fd_interm = load(data_fd);
E_cn_interm = load(data_cn);

fprintf('\n Données E chargées.\n');
fprintf('\n Taille données E: [%d, %d]\n', size(E_fd_interm));

%% Redimensionnement
E_fd = reshape(E_fd_interm, n_block + 1, Nx).';  % Transposition pour [Nx, n_block+1]
E_cn = reshape(E_cn_interm, n_block + 1, Nx).';

fprintf('\n Taille données E (FD après reshape): [%d, %d]\n', size(E_fd));
fprintf('\n Taille données E (CN après reshape): [%d, %d]\n', size(E_cn));

n_ech = numel(E_fd(1,:))-1;
T_max = n_ech * (snapshot*dt);
df = 1 / T_max;
fs = 1 / (snapshot*dt); % Fréquence d'échantillonnage [Hz]
fprintf('\n Nombre échantillon %d \n', n_ech);
fprintf('\n T max = %.2e \n',T_max);
fprintf('\n delta f = %f',df);
fprintf('\n Fréquence d''échantillonnage fs: %.3e Hz\n', fs);


%% Création de l'axe temporel
%t = (0:length(e_fd)-1)*dt*snapshot; % Vecteur temps [s]
t = (0:dt*snapshot:T_max);
fprintf('\n Taille vecteur temps: %d\n', length(t));

%% Sélection du point spatial
x_j0 = 419; % Indice spatial (Nx/4 pour Nx=1500)
e_fd = E_fd(x_j0, :); % Signal temporel FD
e_cn = E_cn(x_j0, :); % Signal temporel CN

fprintf('\n Taille e_fd: %d\n', length(e_fd));
fprintf('\n Taille e_cn: %d\n', length(e_cn));

%% Analyse spectrale par FFT
% Calcul des FFT
Efd_fft = fft(e_fd);
Ecn_fft = fft(e_cn);

% Calcul du vecteur fréquence
frequencies = (0:length(e_fd)-1) * (fs/(length(e_fd) - 1));


% Sélection des fréquences positives
%pfreq = frequencies >= 0;

% Normalisation des amplitudes
amplitude_fd = abs(Efd_fft);
amplitude_cn = abs(Ecn_fft);
amplitude_fd = amplitude_fd / max(amplitude_fd);
amplitude_cn = amplitude_cn / max(amplitude_cn);

disp(size(amplitude_cn));


nufig = 5;

%% Tracé de la réponse temporel
figure(nufig);clf(nufig);
set(gcf,'Position', [100 100 900 600], 'Color', 'white');
plot(t, e_fd, '-', 'DisplayName', 'FDTD');hold on
plot(t, e_cn, '--', 'DisplayName','CNFDTD');
legend('show');
grid on;
hold on;

nufig=nufig+1;
%% Tracé du spectre
figure(nufig);clf(nufig);
set(gcf,'Position', [100 100 900 600], 'color', 'white');
plot(frequencies, 20*log10(amplitude_fd), '-', 'DisplayName', 'FDTD');
hold on;
plot(frequencies, 20*log10(amplitude_cn), '--', 'DisplayName', 'CNFDTD');
title('Spectre');
xlabel('Fréquence (Hz)');
ylabel('Decibel');
grid on;
legend('show');