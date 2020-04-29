function F = h_top_outside(T_top, D_in)
    
    T_O = 293.15; 
    
    T_film = (T_top + T_O)/2;
    %T_film = (T_film + T_top)/2;
    
    F = (0.216 * k_air(T_film) * (T_top - T_O)^(0.25))/((D_in/4)^(0.25) * (my_air(T_film)/rho_air(T_film))^0.5);
    
end