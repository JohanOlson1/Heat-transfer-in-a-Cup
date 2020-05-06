function [dF] = sys_ODE_full(t, y, D_in, D_out, H)
        % Constants
    r_in = D_in/2; A_inner = 2 * r_in * pi * H; A_top = pi * (D_in/2)^2; 
    
        T_A = y(1);
        m_A = y(2);
        
    % Get the surface Temperatures
    T_0_rad = [300, 300]; T_0_top = 300;                                    % Inital guesses for surfaces, no need to change!
    
    fun1 = @(T)sys_rad(T, T_A, D_out, D_in, H);                            % Function for solving the radial surface temp.
    T_surface_rad = fsolve(fun1, T_0_rad);                                  % Solution of surface temp.
 
     
    fun2 = @(T)sys_top_modified(T, T_A, D_in);                              % Function for solving the top surface temp.
    T_surface_top = fsolve(fun2, T_0_top);                                  % Solution of surface temp.    
    
    T_top = T_surface_top;
    
    T_r_inner = T_surface_rad(1);
    T_r_outer = T_surface_rad(2);
    
    % Two Choices of expressions for the concentration of water at the
    % surface
    rho_water_1 = 0.00377 * exp(17.27 * (T_top -273.15)/(T_top - 16.01));
    rho_water_2 = 0.01801528/(T_top * 8.3145) * p_water(T_top);
    % 100 % relativ fuktighet 0.017274 g/m^3
    % 50 % rel fukt 0.00864 g/m^3
    
    % Heat Flux  
    q_convection_rad = (- h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner));
    q_convection_top = h_top_inside(T_top, T_A, D_in) * A_top * (T_A - T_top);
    
    % Mass Flux
    delta_conc = (rho_water_1 - 0.00864);
    kc = h_top_outside(T_top, D_in) * (2.9e-6) * ((T_A + T_top)/2) / (rho_air((T_A + T_top)/2)^(1/3) * cp_air((T_A + T_top)/2)^(1/3) * k_air((T_A + T_top)/2)^(2/3));
    
 
    dF = zeros(2,1);
    
    dF(1) = (q_convection_rad - q_convection_top)/(m_A * cp_water(T_A));
    dF(2) = - delta_conc * A_top * kc;
    
    
    
  
end