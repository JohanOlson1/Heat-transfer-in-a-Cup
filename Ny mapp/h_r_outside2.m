function F = h_r_outside2(T_r_outer, H) 
    % This function calculates the heat transfer coefficient at the outside
    % wall, the inputs required are the outer wall temperature and the charachteristic length H, which is
    % the height of the wall (against the water!)
    
    T_O = 293.15;
    T_film = (T_r_outer + T_O)/2;
    Pr_air = 0.705; g = 9.82;
    
    % Should be lower than 10^9
    Ra_L = (Pr_air * g * 1/T_O * (T_r_outer - T_O) / (my_air(T_film)/rho_air(T_film))^2 * H^3)
    
    
    F = (k_air(T_film) / H) * (0.68 + 0.67 * (Ra_L^0.25)/(1 + (0.492/Pr_air)^(9/16))^(4/9));
    
end