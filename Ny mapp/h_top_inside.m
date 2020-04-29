function F = h_top_inside(T_top, T_A)
    
    T_film = (T_top + T_A)/2;
    
    F = (0.3 * pr_water(T_film)^(1/3) * k_water(T_film) * 1/(T_A^(1/3)) * (T_A - T_top)^(1/3)) / ((my_water(T_film)/rho_water(T_film))^(2/3));
    
end