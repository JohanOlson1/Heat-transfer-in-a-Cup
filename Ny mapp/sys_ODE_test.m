function [dF] = sys_ODE_test(t, T_A, m_A)
    % Constants
    D = 0.067; H = 0.068; r_in = 0.067/2; A_inner = 2 * r_in * pi * H; A_top = pi * D^2; 
    
    dF = zeros(2,1);
    
    % Solve the radial surface temp at each T_A
    
    T_0_rad = [340, 330];
    
    fun1 = @(T)sys_rad(T, T_A, 0.068);

    T_surface_rad = fsolve(fun1, T_0_rad);
    
    T_r_inner = T_surface_rad(1);
    
    % Solve the top surface temp at each T_A
    
    
    T_0_top = 340;
    
    
    fun2 = @(T)sys_top(T, T_A);

    T_top = fsolve(fun2, T_0_top);
    
    %
    
    
    T_film_top_out = (T_A + T_top)/2;
    

    dF(1) = (- h_r_inside(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner) - h_top_inside(T_top, T_A) * A_top * (T_A - T_top))/(m_A * cp_water(T_A));
    dF(2) = rho_water(T_A) * A_top * h_top_outside(T_top) * 2.9 * 10^(-6) * (T_film_top_out) / (rho_air(T_film_top_out)^(1/3) * cp_air(T_film_top_out)^(1/3) * k_air(T_film_top_out)^(2/3));

end