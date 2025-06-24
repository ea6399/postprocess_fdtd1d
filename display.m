
%% Affichage de la Gaussienne
% Parametre 
Nx = 499;
Nx = Nx + 1;
Nt = 1000;
snapshot = 5;
CFL = 0.98;
n_block = Nt / snapshot;       
disp(n_block);

M = load('/home/emin/Documents/CN_FDTD1D/data/E.txt');
disp(size(M));

M_resh = reshape(M,[Nx,n_block + 1]);
disp("Reshape M");
disp(size(M_resh));


% On charge les données :
n1 = 10;
n2 = 50;
n3 = 150;
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