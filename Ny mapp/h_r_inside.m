function F = h_r_inside(T_r_inner, T_A, H)
    % This function calculates the heat transfer coefficient at the inside
    % wall, the inputs required are the inner wall temperature, the
    % temperature of the water and the charachteristic length H, which is
    % the height of the wall (against the water!)
    
    T_film = (T_r_inner + T_A)/2;
    f_pr = 0.736;
    F = (1.669 * k_water(T_film) * f_pr * (1/T_A)^(0.25) * (T_A - T_r_inner)^(0.25))/(H^(0.25) * (my_water(T_film)/rho_water(T_film))^0.5);


end

