%% Data loading
path_params = '/home/emin/Documents/CN_FDTD1D/data/params.txt';
params = load(path_params);  % Nt, Nx + 1, dx, dt, snapshot
Nx = params(1);
Nt = params(2);
dx = params(3);
dt = params(4);
mesh_density = params(5);
CFL = params(6);
snapshot = params(7);



%% Affichage de la Gaussienne
% Parametre 
Nx = Nx + 1;
n_block = Nt / snapshot;       
disp(n_block);

M = load('/home/emin/Documents/CN_FDTD1D/data/E.txt');
%M = load('/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E.txt')
disp(size(M));

M_resh = reshape(M,[Nx,n_block + 1]);
disp("Reshape M");
disp(size(M_resh));

fprintf('Temps de propagation %d', n_block)



% On charge les données :
n1 = 10;
n2 = 500;
n3 = 900;
x = M_resh(:,1);             % Intervalle spatial
y = M_resh(:,n1);             % Observateur 1 | 2 | 3
y1 = M_resh(:,n2);           
y2 = M_resh(:,n3);

figure(1);
fig = gcf;
fig.Position = [300,120,1200,800];


subplot(3,1,1)
plot(x,y);
ax = gca;
ax.YLim = [-1 1];
title(['Temps : ', num2str(0)]);
grid on;

subplot(3,1,2)
plot(x,y1);
ax = gca;
ax.YLim = [-1 1];
title(['Temps :', num2str(n2)])
grid on;

subplot(3,1,3)
plot(x,y2)
ax = gca;
ax.YLim = [-1 1];
title(['Temps : ', num2str(n3)])
xlabel('x');
ylabel('f(x)');
grid on;

sgtitle('Crank Nicolson FDTD');
%close(1);

figure(2);
fig2 = gcf;
ax2 = gca;
fig2.Position = [300,250,800,600];
ax2.YLim = [-1 1];
plot(x,y1);
title('CN-FDTD avec CFL = ',num2str(CFL));
grid on;
close(2);