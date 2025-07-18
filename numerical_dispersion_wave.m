%% Parameter
epsilon_0 = 8.854187817e-12;
mu_0 = 12.56637061e-7;
c = 1 / sqrt(epsilon_0 * mu_0);

% Parametres de l'onde
fmax = 1.0d9;                    % Frequence
lambda = c / fmax;               % Wavelength
omega0 = 2 * pi * fmax;          % Angular frequency
k0 = 2 * pi / lambda;            % Wavenumber
attfmax = 1000.;
att0 = 1000.;
a0 = 1.0;
T = sqrt( log(attfmax) ) / (pi * fmax);
t0 = T * sqrt( log(att0) );


% Approximation parameter
CFL = 0.98;
S = CFL;


% Parametres de discretisation
Nt = 1000;
Nx = 500;
mesh_density = [10, 20, 30, 50, 100];
snapshot = 5;       % Data sauvegardé 
n_block = Nt / snapshot;
dx = zeros(numel(mesh_density), 1);
dt = zeros(numel(mesh_density), 1);

for idx = 1:numel(mesh_density)
    dx(idx) = lambda / mesh_density(idx);
    dt(idx) = S * dx(idx) / c;
end

fprintf( "\n  dx(i) = %f\n %f\n %f\n %f\n \n", dx(1), dx(2), dx(3), dx(4));
fprintf( "\n  dt(i) = %.15f\n %.15f\n %.15f\n %.15f\n \n", dt(1), dt(2), dt(3), dt(4));


% Snapshot time
snapshot = 100;                 % On enregistre qu'une fois sur deux sur 5 itérations --> 2 * 5



%% Chargement des données

% Data Loading
x      = zeros(Nx, numel(mesh_density));
fddata = zeros(Nx, numel(mesh_density));             
cndata = zeros(Nx, numel(mesh_density));

for idx = 1:numel(mesh_density)
    % Chargement des données FDTD
    M1 = load(sprintf("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_%d.txt", idx));
    
    % Chargement des données CN-FDTD
    M2 = load(sprintf("/home/emin/Documents/CN_FDTD1D/E_%d.txt", idx));

    % Extraction du temps de simulation choisi
    M1_1 = reshape(M1, [Nx, n_block + 1]);
    M2_1 = reshape(M2, [Nx, n_block + 1]);

    % Extraction des snapshots
    FD_snap_times = M1_1(:, snapshot);
    CN_snap_times = M2_1(:, snapshot);

    % Reshape des données chargées
    x(:,idx) = M1_1(:,1);  % Premier colonne pour l'axe spatial
    fddata(:,idx) = FD_snap_times;
    cndata(:,idx) = CN_snap_times;
end
fprintf("\n\n Size fd-data %d %d \n\n Size cn-data %d %d \n\n", size(fddata), size(cndata));

% Initialisation de l'onde plane analytique
E_ana = zeros(Nx, numel(mesh_density));
fprintf("\n Size E analytic = %d %d \n",size(E_ana));






%% Calcul de l'onde plane analytique
for idt = 1:numel(mesh_density)
    t = 5 * (snapshot - 2) * dt(idt);                 % Temps de l'onde analytique

    E_ana(:,idt) = sin(omega0 * t - k0 * x(:,idt));  % Onde plane analytique
end

figure();
fig = gcf;
fig.Position = [250,50,1200,800];

tl = tiledlayout('flow','TileSpacing','compact');

for i = 1:numel(mesh_density)
    nexttile
    plot(x(:,i),E_ana(:,i),'LineWidth',1.25); hold on
    plot(x(:,i),fddata(:,i),"o--",'MarkerIndices',1:5:length(fddata(:,i)))
    plot(x(:,i),cndata(:,i), "^--r",'MarkerIndices',1:5:length(fddata(:,i))); 
    ax = gca;
    ax.YLim = [-1 1];
    ax.XLim = [0 0.3];
    title('Densité spatiale : \lambda / ', num2str(mesh_density(i)) );
    grid on;
end

lg = legend('Signal Analyitque', 'Signal approximé par FDTD', "Signal approximé par CNFDTD");
lg.Layout.Tile = 6;
lg.FontSize = 14;
