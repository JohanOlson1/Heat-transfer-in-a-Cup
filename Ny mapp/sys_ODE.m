function [dF] = sys_ODE(t, y, T_r_inner, T_top, D_in, H)
    % Constants
    r_in = D_in/2; A_inner = 2 * r_in * pi * H; A_top = pi * (D_in/2)^2; 
    
    %T_film_top_out = ((T_A + T_top)/2);
    
    % Two Choices of expressions for the concentration of water at the
    % surface
    
    % rho_water = 0.00377 * exp(17.27 * (T_top -273.15)/(T_top - 16.01))
    % rho_water = 0.018/(T_top * 8.3145) * p_water(T_top)
    
    T_A = y(1);
    m_A = y(2); 
    dF = zeros(2,1);
 
    dF(1) = (- h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner) - h_top_inside(T_top, T_A) * A_top * (T_A - T_top))/(m_A * cp_water(T_A));
    dF(2) = - (0.018/(T_top * 8.3145) * p_water(T_top) - 0.00864) * A_top * h_top_outside(T_top, D_in) * (2.9e-6) * ((T_A + T_top)/2) / (rho_air((T_A + T_top)/2)^(1/3) * cp_air((T_A + T_top)/2)^(1/3) * k_air((T_A + T_top)/2)^(2/3));

end

