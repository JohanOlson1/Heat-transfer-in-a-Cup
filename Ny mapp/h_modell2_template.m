function F = h_r_inside2(T_r_inner, T_A, H) 
    % This function calculates the heat transfer coefficient at the outside
    % wall, the inputs required are the outer wall temperature and the charachteristic length H, which is
    % the height of the wall (against the water!)

    F = (k_ö(T_f) / H) * (0.68 + 0.67 * ((Pr_ö(T_f) * g * 1/T_ö * (T_ö - T_ö) * H^3)^0.25)/(1 + (0.492/Pr_ö)^(9/16))^(4/9))
    
end