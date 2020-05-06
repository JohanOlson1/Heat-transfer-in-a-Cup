function F = h_top_outside(T_top, D_in)
    
    T_O = 293.15; 
    
    T_film = (T_top + T_O)/2;
    g = 9.82;
    
    Gr = g * (1/T_O) * (T_top - T_O) * (D_in/4)^3 / ((my_air(T_film)/rho_air(T_film))^(2));
    Pr = 0.705;
    
    Ra_L = Gr * Pr;
    
    F = 0.54 * k_air(T_film)/(D_in/4) * Ra_L^(1/4);
    

    
    %F = (0.216 * k_air(T_film) * (T_top - T_O)^(0.25))/((D_in/4)^(0.25) * (my_air(T_film)/rho_air(T_film))^0.5);
    
end