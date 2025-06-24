%% Data loading

% Path
path_fd     = "/home/emin/Documents/RUNTIME/times_fd.csv";
path_cn_def = "/home/emin/Documents/RUNTIME/times_cn_default.csv";
path_cn_inv = "/home/emin/Documents/RUNTIME/times_cn_inv.csv";

% Loading
fd_times     = readmatrix(path_fd);
cn_def_times = readmatrix(path_cn_def);
cn_inv_times = readmatrix(path_cn_inv);


%% Curve Display 

% Nombre d'éléments
n_elt = fd_times(:,1);
fprintf('\n Nombre d''éxécution : %d \n',n_elt(end));

% Temps d'éxécution
y_fd = fd_times(:,2);
y_cn_def = cn_def_times(:,2);
y_cn_inv = cn_inv_times(:,2);

%Temps moyen
m_fd = mean(y_fd);
m_cn_def = mean(y_cn_def);
m_cn_inv = mean(y_cn_inv);


%% Display graph
figure('Position',[150,100,1200,800],'Color','white');

%Graphs
plot(n_elt, y_fd,'-^', 'DisplayName','FDTD'); hold on
plot(n_elt, y_cn_def,'-^','DisplayName','Default CN');
plot(n_elt, y_cn_inv,'-^','DisplayName','CN with inversion');

% Mean value
yline(m_fd,'--','Mean(FDTD)',LabelHorizontalAlignment='right');
yline(m_cn_inv,'--','Mean(CN w inversion)',LabelHorizontalAlignment='right');
yline(m_cn_def,'--', 'Mean(CN default)',LabelHorizontalAlignment='right');

% Annotation
xlabel('Run')
ylabel('Times [s]')
legend('FDTD','CN-FDTD default','CN w inverted A');
grid on;


