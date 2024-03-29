function F = h_top_inside(T_top, T_A, D_in)
    
    T_film = (T_top + T_A)/2;
    g = 9.82; 
    Ra_L = g * pr_water(T_film) * (1/T_A) * (T_A - T_top) * D_in/4 / ((my_water(T_film)/rho_water(T_film))^2);
    
    F = (k_water(T_film) / (D_in/4)) * 0.14 * Ra_L^(1/3);
    
end