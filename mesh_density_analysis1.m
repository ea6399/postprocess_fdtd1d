%% Parameter
Nx = 500; % Nx + 1 points de 0 a 499
Nt = 1000;
snapshot = 5;       % Data sauvegardé 
n_block = Nt / snapshot;
spatial_density = [5, 10, 30, 50, 100];
CFL = 0.98;
fprintf("Nombre de block : %d\n", n_block);
%fprintf("Densite spatial %d \n",spatial_density);


%% Chargement des données
fd5_interm   = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_5.txt")  ;
fd10_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_10.txt") ;
fd30_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_30.txt") ;
fd50_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_50.txt") ;
fd100_interm = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_100.txt");

CN5_interm   = load("/home/emin/Documents/CN_FDTD1D/E_5.txt")  ;
CN10_interm  = load("/home/emin/Documents/CN_FDTD1D/E_10.txt") ;
CN30_interm  = load("/home/emin/Documents/CN_FDTD1D/E_30.txt") ;
CN50_interm  = load("/home/emin/Documents/CN_FDTD1D/E_50.txt") ;
CN100_interm = load("/home/emin/Documents/CN_FDTD1D/E_100.txt");

% Reshape

FD5   = reshape(fd5_interm, [Nx, n_block + 1])  ;
FD10  = reshape(fd10_interm, [Nx, n_block + 1]) ;
FD30  = reshape(fd30_interm, [Nx, n_block + 1]) ;
FD50  = reshape(fd50_interm, [Nx, n_block + 1]) ;
FD100 = reshape(fd100_interm, [Nx, n_block + 1]);

CN5   = reshape(CN5_interm, [Nx, n_block + 1])  ;
CN10  = reshape(CN10_interm, [Nx, n_block + 1]) ;
CN30  = reshape(CN30_interm, [Nx, n_block + 1]) ;
CN50  = reshape(CN50_interm, [Nx, n_block + 1]) ;
CN100 = reshape(CN100_interm, [Nx, n_block + 1]);

%% Display times
n1 = 10;
n2 = n_block/2;
    if (mod(n2,2) > 0) 
        n2 = int32(n2) + 1;
    end
n3 = n_block - 3 * snapshot; 

fprintf("Temps d'affichage :\n n1 = %d \n n2 = %d\n n3 = %d\n", n1, n2, n3);

%% Display parameter
x = FD5(:,1);      % Intervalle d'etude


%% Figure 1
fd5_n1 = FD5(:,n1);
cn5_n1 = CN5(:,n1);

fd5_n2 = FD5(:,n2);
cn5_n2 = CN5(:,n2);

fd5_n3 = FD5(:,n3);
cn5_n3 = CN5(:,n3);


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
title(['Temps : ', num2str(n2)]);
grid on;

subplot(3,1,3)
plot(x,fd3,x,cn3);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n3)]);
grid on;

sgtitle(['Comparaison Crank-Nicolson / FDTD pour une densité spatial de ' ...
    '', num2str(spatial_density(1)), ' pas spatial par \lambda']);



%%  figure 2

fd10_n1 = FD10(:,n1);
cn10_n1 = CN10(:,n1);

fd10_n2 = FD10(:,n2);
cn10_n2 = CN10(:,n2);

fd10_n3 = FD10(:,n3);
cn10_n3 = CN10(:,n3);

f2 = figure('Color','white');
fig2 = gcf;
fig2.Position = [300,120,1200,800];

subplot(3,1,1)
plot(x,fd10_n1,x,cn10_n1);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n1)]);
grid on;

subplot(3,1,2)
plot(x,fd10_n2,x,cn10_n2);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n2)]);
grid on;

subplot(3,1,3)
plot(x,fd10_n3,x,cn10_n3);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n3)]);
grid on;

sgtitle(['Comparaison Crank-Nicolson / FDTD pour une densité spatial de ' ...
    '', num2str(spatial_density(2)), ' pas spatial par \lambda'])




%%  figure 3

fd30_n1 = FD30(:,n1);
cn30_n1 = CN30(:,n1);

fd30_n2 = FD30(:,n2);
cn30_n2 = CN30(:,n2);

fd30_n3 = FD30(:,n3);
cn30_n3 = CN30(:,n3);

f3 = figure('Color','white');
fig3 = gcf;
fig3.Position = [300,120,1200,800];

subplot(3,1,1)
plot(x,fd30_n1,x,cn30_n1);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n1)]);
grid on;

subplot(3,1,2)
plot(x,fd30_n2,x,cn30_n2);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n2)]);
grid on;

subplot(3,1,3)
plot(x,fd30_n3,x,cn30_n3);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n3)]);
grid on;

sgtitle(['Comparaison Crank-Nicolson / FDTD pour une densité spatial de ' ...
    '', num2str(spatial_density(3)), ' pas spatial par \lambda'])



%%  figure 4

fd50_n1 = FD50(:,n1);
cn50_n1 = CN50(:,n1);

fd50_n2 = FD50(:,n2);
cn50_n2 = CN50(:,n2);

fd50_n3 = FD50(:,n3);
cn50_n3 = CN50(:,n3);

f4 = figure('Color','white');
fig4 = gcf;
fig4.Position = [300,120,1200,800];

subplot(3,1,1)
plot(x,fd50_n1,x,cn50_n1);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n1)]);
grid on;

subplot(3,1,2)
plot(x,fd50_n2,x,cn50_n2);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n2)]);
grid on;

subplot(3,1,3)
plot(x,fd50_n3,x,cn50_n3);
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Temps : ', num2str(n3)]);
grid on;

sgtitle(['Comparaison Crank-Nicolson / FDTD pour une densité spatial de ' ...
    '', num2str(spatial_density(4)), ' pas spatial par \lambda'])



%close(1);
%close(2);
%close(3);





