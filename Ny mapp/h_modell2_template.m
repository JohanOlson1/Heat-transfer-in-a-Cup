function F = h_r_inside2(T_r_inner, T_A, H) 
    % This function calculates the heat transfer coefficient at the outside
    % wall, the inputs required are the outer wall temperature and the charachteristic length H, which is
    % the height of the wall (against the water!)

    F = (k_�(T_f) / H) * (0.68 + 0.67 * ((Pr_�(T_f) * g * 1/T_� * (T_� - T_�) * H^3)^0.25)/(1 + (0.492/Pr_�)^(9/16))^(4/9))
    
end