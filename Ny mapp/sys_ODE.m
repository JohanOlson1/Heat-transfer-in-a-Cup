function [dF] = sys_ODE(t, y, T_r_inner, T_top, D_in, H)
    % Constants
    r_in = D_in/2; A_inner = 2 * r_in * pi * H; A_top = pi * (D_in/2)^2; 
    
        T_A = y(1);
        m_A = y(2);
    
    
    % Two Choices of expressions for the concentration of water at the
    % surface
    rho_water_1 = 0.00377 * exp(17.27 * (T_top -273.15)/(T_top - 16.01));
    rho_water_2 = 0.01801528/(T_top * 8.3145) * p_water(T_top);
    % 100 % relativ fuktighet 17.274 g/m^3
    % 50 % rel fukt 8.64 g/m^3
    
    % Heat Flux  
    q_convection_rad = (- h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner));
    q_convection_top = h_top_inside(T_top, T_A) * A_top * (T_A - T_top);
    
    % Mass Flux
    delta_conc = (rho_water_2 - 0.017274);
    kc = h_top_outside(T_top, D_in) * (2.9e-6) * ((T_A + T_top)/2) / (rho_air((T_A + T_top)/2)^(1/3) * cp_air((T_A + T_top)/2)^(1/3) * k_air((T_A + T_top)/2)^(2/3));
    
 
    dF = zeros(2,1);
    
    dF(1) = (q_convection_rad - q_convection_top)/(m_A * cp_water(T_A));
    dF(2) = - delta_conc * A_top * kc;

end

