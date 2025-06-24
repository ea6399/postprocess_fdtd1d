%% Parametre d'affichage
Nx = 2000; % Nx + 1 points de 0 a 499
Nt = 1000;
snapshot = 5;       % Data sauvegardé 
n_block = Nt / snapshot;
spatial_density = 10;
CFL = 0.98;
fprintf("Nombre de block : %d\n", n_block);
fprintf("Densite spatial %d \n",spatial_density);


%% Data loading

M_temp_fd = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E.txt");
M_temp_cn = load("/home/emin/Documents/CN_FDTD1D/data/E.txt");

M_fd = reshape(M_temp_fd, [Nx, n_block + 1]);       % La première colonne est l'intervalle d'étude
M_cn = reshape(M_temp_cn, [Nx, n_block + 1]);
fprintf("Shape(M_fd) = %d %d\n" + ...
        "Shape(M_cn) = %d %d\n", ...
        size(M_fd),size(M_cn));


%% Display times 

n1 = 10;
n2 = n_block/2;
    if (mod(n2,2) > 0) 
        n2 = int32(n2) + 1;
    end
n3 = n_block; 

fprintf("Temps d'affichage :\n n1 = %d \n n2 = %d\n n3 = %d\n", n1, n2, n3);

%% Display parameter
x = M_fd(:,1);      % Intervalle d'etude

fd1 = M_fd(:,n1);
fd2 = M_fd(:,n2);
fd3 = M_fd(:,n3);

cn1 = M_cn(:,n1);
cn2 = M_cn(:,n2);
cn3 = M_cn(:,n3);


%%  figure 1
f1 = figure('Color','white');
fig1 = gcf;
fig1.Position = [300,120,1200,800];

subplot(3,1,1)
plot(x,fd1,x,cn1);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n1)]);
grid on;

subplot(3,1,2)
plot(x,fd2,x,cn2);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps :', num2str(n2)])
grid on;

subplot(3,1,3)
plot(x,fd3,x,cn3);
ax = gca;
ax.YLim = [-1 1];
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n3)])
xlabel('x');
ylabel('E(x,t)');
grid on;
%close(1);

sgtitle(['Comparaison CN-FDTD avec FDTD pour un ' ...
    'echantillonage spatial de ', num2str(spatial_density), ' par \lambda'])


%% Figure 2 (Stabilité)
f2 = figure('Color','white');
fig2 = gcf;
fig2.Position = [250,250,800,600];

subplot(2,2,1)
plot(x,fd1);
ax = gca;
ax.YLim = [-1 1];
title('FDTD ');
grid on;

subplot(2,2,3)
plot(x,fd2);
ax = gca;
ax.YLim = [-1 1];
grid on;

subplot(2,2,2)
plot(x,cn1);
ax = gca;
ax.YLim = [-1 1];
title('CN-FDTD ');
grid on;

subplot(2,2,4)
plot(x,cn2);
ax = gca;
ax.YLim = [-1 1];
grid on;

sgtitle(['Comparaison Crank Nicolson et FDTD pour ' ...
    'un echantillonage spatial de ', num2str(spatial_density), ' par \lambda'])

%close(2);

