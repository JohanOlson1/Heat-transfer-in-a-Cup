function F = h_top_outside(T_top, D_in)
    
    T_O = 293.15; 
    
    T_film = (T_top + T_O)/2;
    %T_film = (T_film + T_top)/2;
    g = 9.82; T_inf = 293.15;
    Gr = g * (1/T_inf) * (T_top - T_O) * D_in^3 / ((my_air(T_film)/rho_air(T_film))^(2/3));
    Pr = 0.725;
    F = 0.14 * k_air(T_film) * Gr^(1/3) * Pr^(1/3);
    
    %F = (0.216 * k_air(T_film) * (T_top - T_O)^(0.25))/((D_in/4)^(0.25) * (my_air(T_film)/rho_air(T_film))^0.5);
    
end