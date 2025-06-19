%% Parameter
Nx = 500; % Nx + 1 points de 0 a 499
Nt = 1000;
snapshot = 5;       % Data sauvegardé 
n_block = Nt / snapshot;
spatial_density = [2.5, 5, 10, 20, 50, 100];
CFL = 0.98;
fprintf("\n Nombre de block : %d\n", n_block);
fprintf("\n Densite spatial %d \n",spatial_density);


%% Choix du temps
T_1 = int64(Nx / 8);                    %% On enregistre seulement un pas sur 2
fprintf('\n Choix du temps %d \n', T_1);


%% Chargement des donnees
fd1_interm   = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_1.txt")  ;
fd2_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_2.txt") ;
fd3_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_3.txt") ;
fd4_interm  = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_4.txt") ;
fd5_interm = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_5.txt");
fd6_interm = load("/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_6.txt");

CN1_interm   = load("/home/emin/Documents/CN_FDTD1D/E_1.txt") ;
CN2_interm  = load("/home/emin/Documents/CN_FDTD1D/E_2.txt") ;
CN3_interm  = load("/home/emin/Documents/CN_FDTD1D/E_3.txt") ;
CN4_interm  = load("/home/emin/Documents/CN_FDTD1D/E_4.txt") ;
CN5_interm = load("/home/emin/Documents/CN_FDTD1D/E_5.txt") ;
CN6_interm = load("/home/emin/Documents/CN_FDTD1D/E_6.txt") ;

% Reshape
FD1   = reshape(fd1_interm, [Nx, n_block + 1])  ;
FD2  = reshape(fd2_interm, [Nx, n_block + 1]) ;
FD3  = reshape(fd3_interm, [Nx, n_block + 1]) ;
FD4  = reshape(fd4_interm, [Nx, n_block + 1]) ;
FD5 = reshape(fd5_interm, [Nx, n_block + 1]);
FD6 = reshape(fd6_interm, [Nx, n_block + 1]);

CN1   = reshape(CN1_interm, [Nx, n_block + 1])  ;
CN2  = reshape(CN2_interm, [Nx, n_block + 1]) ;
CN3  = reshape(CN3_interm, [Nx, n_block + 1]) ;
CN4  = reshape(CN4_interm, [Nx, n_block + 1]) ;
CN5 = reshape(CN5_interm, [Nx, n_block + 1]);
CN6 = reshape(CN6_interm, [Nx, n_block + 1]);

%% Ecriture des fonctions au temps T_1
x = FD1(:,1);

yfd1 = FD1(:,T_1);

f1 = figure('Color','white');
fig1 = gcf;
fig1.Position = [300,120,1200,800];

subplot(3,2,1)
plot(x,yfd1,x,CN1(:,T_1));
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Densité spatial : ', ...
    num2str(spatial_density(1)), ' au temps : t = ', ...
    num2str(T_1) '*dt']);
grid on;

subplot(3,2,2)
plot(x,FD2(:,T_1),x,CN2(:,T_1));
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Densité spatial : ', ...
    num2str(spatial_density(2)), ' au temps : t = ', ...
    num2str(T_1) '*dt']);
grid on;

subplot(3,2,3)
plot(x,FD3(:,T_1),x,CN3(:,T_1));
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Densité spatial : ', ...
    num2str(spatial_density(3)), ' au temps : t = ', ...
    num2str(T_1) '*dt']);
grid on;

subplot(3,2,4)
plot(x,FD4(:,T_1),x,CN4(:,T_1));
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Densité spatial : ', ...
    num2str(spatial_density(4)), ' au temps : t = ', ...
    num2str(T_1) '*dt']);
grid on;

subplot(3,2,5)
plot(x,FD5(:,T_1),x,CN5(:,T_1));
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Densité spatial : ', ...
    num2str(spatial_density(5)), ' au temps : t = ', ...
    num2str(T_1) '*dt']);
grid on;

subplot(3,2,6)
plot(x,FD6(:,T_1),x,CN6(:,T_1));
ax = gca;
ax.YLim = [-1 1];
xlabel('x');
ylabel('E(x,t)');
legend('fdtd', 'cnfdtd')
title(['Densité spatial : ', ...
    num2str(spatial_density(6)), ' au temps : t = ', ...
    num2str(T_1) '*dt']);
grid on;


