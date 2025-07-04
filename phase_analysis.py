# Récuperer les data de propagation de l'onde puis faire une fft pour visualiser l'amplitude et l'onde de phase
import numpy as np
import matplotlib.pyplot as plt

def reshape_data(data, n, m):
    return data.reshape(n,m, order = 'F')




if __name__ == "__main__":

    ## DATA LOADING
    path_fd = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/E_1.txt'
    path_cn = '/home/emin/Documents/CN_FDTD1D/E_1.txt'
    path_params = '/home/emin/Documents/TP_FDTD/1D/stage_tp_fdtd/params.txt'

    data_fd = np.loadtxt(path_fd)
    data_cn = np.loadtxt(path_cn)
    params = np.loadtxt(path_params)
    print(f"Données chargées aves succès : {path_fd}")
    print(f"Données chargées aves succès : {path_cn}")
    print(f"Paramètres chargés aves succès : {path_params}")
    print("Shape data :", data_fd.shape, data_cn.shape)

    ## PARAMS
    Nt = int(params[0])  # Nombre de pas de temps
    Nx = int(params[1])  # Nombre de points spatiaux
    dx = params[2]  # Pas spatial
    dt = params[3]  # Pas de temps
    snapshot = int(params[4])  # Pas d'échantillonnage
    S = params[5]  # Condition de stabilité S
    c = params[6]  # Vitesse de la lumière

    print(f"Paramètres : Nt={Nt}, \n Nx={Nx}, \n dx={dx}, \n dt={dt}, \n snapshot={snapshot}, \n S={S}")

    ## RESHAPE DATA
    E_fd = reshape_data(data_fd, Nx, Nt)                #  Appel à la fonction reshape_data
    E_cn = reshape_data(data_cn, Nx, Nt)
    print("Données reshaped :", E_fd.shape, E_cn.shape)

    ## Afficahge pour vérifier les data
    x = np.linspace(0, (Nx-1) * dx, Nx)  # Coordonnées spatiales
    t = np.linspace(0, (Nt-1) * dt, Nt)  # Coordonnées temporelles
    print("x :", x.shape, "t :", t.shape)
    fig1 = plt.figure(figsize=(10, 6))
    x0 = 250
    plt.plot(t, E_fd[x0, :], label='FDTD')
    plt.plot(t, E_cn[x0, :], label='CN', linestyle='--')
    xlabel = 'Temps (s)'
    ylabel = 'Amplitude du champ E'
    legend = plt.legend()
    plt.grid(True)
    #plt.show()
    plt.close()


    plt.figure(figsize=(10, 6))
    t0 = 500
    plt.plot(x, E_fd[:, t0], label='FDTD')
    plt.plot(x, E_cn[:, t0], label='CN', linestyle='--')
    xlabel = 'Position (m)'
    ylabel = 'Amplitude du champ E'
    legend = plt.legend()
    plt.title(f'Champ E FDTD - t={t0}')
    plt.grid(True)
    #plt.show()
    plt.close()


    
    
    ##### FFT


    n_ech = len(E_fd[0, :]);
    print(f"Nombre d'échantillons temporels: {n_ech}")
    T_max = n_ech * (snapshot * dt)                             # Durée totale 
    print(f"Durée totale de l'échantillonnage: {T_max} s")
    df = 1 / (T_max)                                              # Résolution fréquentielle
    print(f"Résolution fréquentielle : {df:.2e} Hz")
    fs = 1 / (snapshot * dt)  # Fréquence d'échantillonnage
    print(f"Fréquence d'échantillonnage : {fs:.2e} Hz")


    pt_observation2 = int(Nx / 2)  # Point d'observation
    print(f"Point d'observation : {pt_observation2}")
    sp_fd2 = np.fft.fft(E_fd[pt_observation2,:])  # FFT le long de l'axe temporel
    sp_cn2 = np.fft.fft(E_cn[pt_observation2,:])
    print("Shape des spectres au point d'observation ",pt_observation2, ":", sp_fd2.shape, sp_cn2.shape)

    #f_ax = np.fft.fftfreq(n_ech, d = snapshot * dt)  # Fréquences associées
    f_ax = np.arange(0,fs,df)   # Fréquences associées avec la résolution df
    print("Fréquences associées :", f_ax.shape)
    



    # Afficher les spectres

    # Calcul des amplitudes
    fig3 = plt.figure(figsize=(10, 6))
    plt.plot(f_ax, np.abs(sp_fd2), label='FDTD')
    plt.plot(f_ax, np.abs(sp_cn2), label='CN', linestyle='--')
    xlabel = 'Fréquence (Hz)'
    ylabel = 'Amplitude du spectre'
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    legend = plt.legend()
    plt.grid(True)
    plt.show()
    plt.close()


    # Calcul des phases   
    phase_fd2 = np.angle(sp_fd2)  
    phase_cn2 = np.angle(sp_cn2)  
    phase_fd_unwrapped2 = np.unwrap(np.angle(sp_fd2))     
    phase_cn_unwrapped2 = np.unwrap(np.angle(sp_cn2))     


    fig4 = plt.figure(figsize=(10, 6))
    plt.plot(f_ax, phase_fd2, label='FDTD')
    plt.plot(f_ax, phase_cn2, label='CN', linestyle='--')
    xlabel = 'Fréquence (Hz)'
    ylabel = 'Phase du spectre'
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    legend = plt.legend()
    plt.grid(True)
    plt.show()
    plt.close()

    fig5 = plt.figure(figsize=(10, 6))
    plt.plot(f_ax, phase_fd_unwrapped2, label='FDTD')
    plt.plot(f_ax, phase_cn_unwrapped2, label='CN', linestyle='--')
    xlabel = 'Fréquence (Hz)'
    ylabel = 'Phase dépliée du spectre'
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    legend = plt.legend()
    plt.grid(True)
    plt.show()


    # Calculer la relation de dispersion numérique (nombre d'onde k en fonction de w)
    x_obs2 = pt_observation2 * dx  # Position du point d'observation

    omega = 2 * np.pi * f_ax[:n_ech//2]  # Fréquences angulaires w = 2*pi*f

    # Relation de dispersion théorique pour référence
    k_theo = omega / c

    # Dispersion numérique théorique
    k_fd_theo = (2/dx) * np.arcsin( (1/S) * np.sin(omega * dt/2) )
    k_cn_theo = (2/dx) * np.arctan( (1/S) * np.sin(omega * dt/2) )


     # Vitesses de phase numériques (vp = ω/k) normalisées par c
    #vp_fd = (omega / k_fd) / c
    #vp_cn = (omega / k_cn) / c

    # Afficher les relations de dispersion
    fig1 = plt.figure(figsize=(10, 6))
    plt.plot(omega, k_theo, 'k-', label='Physique')
    plt.plot(omega, k_fd_theo, '-', label='FDTD Théorique')
    plt.plot(omega, k_cn_theo, '-', label='CN-FDTD Théorique')
    plt.xlabel('Fréquence angulaire ω (rad/s)')
    plt.ylabel('Nombre d\'onde k (rad/m)')
    plt.title('Relations de dispersion numériques')
    plt.legend()
    plt.grid(True)
    plt.xlim(0, np.max(omega))  # Limiter aux fréquences basses pour mieux voir
    plt.ylim(0, 75)
    plt.show()

    # Afficher les vitesses de phase normalisées
    # plt.figure(figsize=(10, 6))
    # plt.plot(omega, vp_fd, label='FDTD')
    # plt.plot(omega, vp_cn, label='CN-FDTD')
    # plt.plot(omega, np.ones_like(omega), 'k--', label='Théorique')
    # plt.xlabel('Fréquence angulaire ω (rad/s)')
    # plt.ylabel('Vitesse de phase normalisée (v/c)')
    # plt.title('Dispersion numérique: vitesse de phase')
    # plt.legend()
    # plt.grid(True)
    # plt.xlim(0, np.max(omega)/3)
    # plt.ylim(0,2)
    # plt.show()

    # plt.figure(figsize=(10, 6))
    # plt.plot(k_theo, omega_fd_theo, 'b-', label='FDTD Théorique')
    # plt.plot(k_theo, omega_cn_theo, '-', label='CN-FDTD Théorique')
    # plt.plot(k_theo, omega_fd, linestyle='None',label='FDTD', marker='o', markersize=1.2)
    # plt.plot(k_theo, omega_cn, linestyle='None', marker='+', label='CN-FDTD', markersize=1.2)
    # plt.plot(k_theo, omega, 'k-', label='Physique')
    # plt.xlabel('Nombre d\'onde k (rad/m)')
    # plt.ylabel('Fréquence angulaire ω (rad/s)')
    # plt.title('Relations de dispersion numériques')
    # plt.legend()
    # plt.grid(True)
    # plt.show()

















