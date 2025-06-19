%% Parameter
Nt = 1000;
Nx = 500;
mesh_density = [3. 6. 20. 50.];
snapshot = 5;       % Data sauvegardé 
n_block = Nt / snapshot;
epsilon_0 = 8.854187817e-12;
mu_0 = 12.56637061e-7;
c = 1 / sqrt(epsilon_0 * mu_0);

fmax = 1.0d9;                    % Frequence
lambda = c / fmax;               % Wavelength
omega0 = 2 * pi * fmax;           % Angular frequency
k0 = 2 * pi / lambda;            % Wavenumber

% Approximation parameter
CFL = 0.98;
S = CFL;
dx = zeros(numel(mesh_density), 1);
dt = zeros(numel(mesh_density), 1);

for idx = 1:numel(mesh_density)
    dx(idx) = lambda / mesh_density(idx);
    dt(idx) = S * dx(idx) / c;
end

fprintf( "\n  dx(i) = %f\n %f\n %f\n %f\n \n", dx(1), dx(2), dx(3), dx(4));
fprintf( "\n  dt(i) = %.15f\n %.15f\n %.15f\n %.15f\n \n", dt(1), dt(2), dt(3), dt(4));


% Snapshot times
snap_times = [10, 50, 150];
number_snap = numel(snap_times);

% Data Loading
FD1 = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_4.txt");
CN1 = load("/home/emin/Documents/CN_FDTD1D/E_4.txt");

fddata = reshape(FD1, [Nx, n_block + 1]);
cndata = reshape(CN1, [Nx,n_block + 1]);
fprintf("\n Size data %d %d \n Size cn-data %d %d", size(fddata), size(cndata));

% Initialisation de l'onde plane analytique
E_ana = zeros(Nx, number_snap);
E_num = zeros(Nx, number_snap);
CN_E_num = zeros(Nx, number_snap);
fprintf("\n Size E analytic = %d %d \n",size(E_ana));

% Axe spatial
x = fddata(:,1);                     
disp(size(x));

% Chargement des temps de comparaison
for idx = 1:number_snap
    t = snap_times(idx) * dt;

    E_ana(:,idx) = sin(omega0 * t - k0 * x);

    E_num(:,idx) = fddata(:,snap_times(idx));
    CN_E_num(:,idx) = cndata(:,snap_times(idx));
end

figure();
fig = gcf;
fig.Position = [450,250,800,600];
plot(x,E_ana(:,2),"red"); hold on
plot(x,E_num(:,2),"--b");
plot(x,CN_E_num(:,2), "--g");
ax = gca;
ax.YLim = [-1 1];
ax.XLim = [0 1];
legend('Signal Analyitque', 'Signal approximé par FDTD', "Signal approximé par CNFDTD");
grid on;
