function F = h_r_inside2(T_r_inner, T_A, H) 
    % This function calculates the heat transfer coefficient at the outside
    % wall, the inputs required are the outer wall temperature and the charachteristic length H, which is
    % the height of the wall (against the water!)
    T_film = (T_r_inner + T_A)/2; 
    g = 9.82; 

    F = (k_water(T_film) / H) * (0.68 + 0.67 * ((pr_water(T_film) * g * (1/T_A) * (T_A - T_r_inner) * H^3 / (my_water(T_film)/rho_water(T_film))^2)^0.25)/(1 + (0.492/pr_water(T_film))^(9/16))^(4/9));
    
end