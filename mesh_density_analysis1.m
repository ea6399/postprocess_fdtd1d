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
fd1_interm   = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_1.txt")  ;
fd2_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_2.txt") ;
fd3_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_3.txt") ;
fd4_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_4.txt") ;
fd5_interm = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_5.txt");

CN1_interm   = load("/home/emin/Documents/CN_FDTD1D/E_1.txt")  ;
CN2_interm  = load("/home/emin/Documents/CN_FDTD1D/E_2.txt") ;
CN3_interm  = load("/home/emin/Documents/CN_FDTD1D/E_3.txt") ;
CN4_interm  = load("/home/emin/Documents/CN_FDTD1D/E_4.txt") ;
CN5_interm = load("/home/emin/Documents/CN_FDTD1D/E_5.txt");

% Reshape

FD1   = reshape(fd1_interm, [Nx, n_block + 1])  ;
FD2  = reshape(fd2_interm, [Nx, n_block + 1]) ;
FD3  = reshape(fd3_interm, [Nx, n_block + 1]) ;
FD4  = reshape(fd4_interm, [Nx, n_block + 1]) ;
FD5 = reshape(fd5_interm, [Nx, n_block + 1]);

CN1   = reshape(CN1_interm, [Nx, n_block + 1])  ;
CN2  = reshape(CN2_interm, [Nx, n_block + 1]) ;
CN3  = reshape(CN3_interm, [Nx, n_block + 1]) ;
CN4  = reshape(CN4_interm, [Nx, n_block + 1]) ;
CN5 = reshape(CN5_interm, [Nx, n_block + 1]);

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
fd1_n1 = FD1(:,n1);
cn1_n1 = CN1(:,n1);

fd1_n2 = FD1(:,n2);
cn1_n2 = CN1(:,n2);

fd1_n3 = FD1(:,n3);
cn1_n3 = CN1(:,n3);


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





