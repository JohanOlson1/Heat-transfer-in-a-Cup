function F = h_r_outside(T_r_outer, H)
    % This function calculates the heat transfer coefficient at the outside
    % wall, the inputs required are the outer wall temperature and the charachteristic length H, which is
    % the height of the wall (against the water!)
    T_O = 293.15;
    T_film = (T_r_outer + T_O)/2;
    
    F = (0.125 * k_air(T_film) * (T_r_outer - T_O)^(0.25)) / (H^(0.25) * (my_air(T_film)/rho_air(T_film))^0.5);
    
end

