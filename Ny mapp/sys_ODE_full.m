function [y] = sys_ODE_full(t, y, D_in, D_out, H, k, eps)
        % Constants
    r_in = D_in/2; A_inner = 2 * r_in * pi * H; A_top = pi * (D_in/2)^2;  
    d = (D_out - D_in)/2; r_o = D_out/2; A_outer = 2 * r_o * pi * H;
    T_O = 293.15; boltz = 5.67e-8;
    
        T_A = y(1);
        m_A = y(2);
        
    % Get the surface Temperatures
    T_0_rad = [300, 300]; T_0_top = 300;                                    % Inital guesses for surfaces, no need to change!
    
    fun1 = @(T)sys_rad(T, T_A, D_out, D_in, H, k, eps);                            % Function for solving the radial surface temp.
    T_surface_rad = fsolve(fun1, T_0_rad);                                  % Solution of surface temp.
 
     
    fun2 = @(T)sys_top_modified(T, T_A, D_in, eps);                              % Function for solving the top surface temp.
    T_surface_top = fsolve(fun2, T_0_top);                                  % Solution of surface temp.    
    
    T_top = T_surface_top;
    
    T_r_inner = T_surface_rad(1);
    T_r_outer = T_surface_rad(2);
    
    % Two Choices of expressions for the concentration of water at the
    % surface
    rho_water_1 = 0.00377 * exp(17.27 * (T_top -273.15)/(T_top - 16.01));
    rho_water_2 = 0.01801528/(T_top * 8.3145) * p_water(T_top);
    delta_conc = (rho_water_1 - 0.00864);
    % 100 % relativ fuktighet 0.017274 g/m^3
    % 50 % rel fukt 0.00864 g/m^3
    
    % Mass Flux
    D_AB = ((2.9e-6) * (T_top))^(3/2);
    kc = h_top_outside(T_top, D_in) * D_AB^(2/3) / (rho_air((T_A + T_top)/2)^(1/3) * cp_air((T_A + T_top)/2)^(1/3) * k_air((T_A + T_top)/2)^(2/3));
    
    % Heat Flux 
    q_convection_rad_in = - h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner);
    q_conduction = - 2 * pi * k * d * (T_r_inner - T_r_outer) / (log(r_o/r_in));
    q_convection_rad_out = - h_r_outside2(T_r_outer, H) * A_outer * (T_r_outer - T_O);
    q_rad_radiation = - eps * boltz * A_outer * ((T_r_outer)^4 - T_O^4);  
    
    q_top_radiation = - eps * boltz * A_top * (T_top^4 - T_O^4);
    q_convection_top_out = - h_top_outside(T_top, D_in) * A_top * (T_top - T_O);
    q_vap = - dHvap_water(T_top) * delta_conc * A_top * kc;
    q_convection_top_in = - h_top_inside(T_top, T_A, D_in) * A_top * (T_A - T_top);
      
 
    dF = zeros(2,1);
    
    y(1) = (q_convection_rad_in + q_convection_top_in)/(m_A * cp_water(T_A));
    y(2) = - delta_conc * A_top * kc;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    %------------------------------------------------------
    
    q_convection_rad_in1 = q_convection_rad_in;
    assignin('base','varInBase',q_convection_rad_in1);
    evalin('base','q_convection_rad_in1(end+1)=varInBase');
    
    q_conduction2 = q_conduction;
    assignin('base','varInBase',q_conduction2);
    evalin('base','q_conduction2(end+1)=varInBase');
    
    q_convection_rad_out3 = q_convection_rad_out;
    assignin('base','varInBase',q_convection_rad_out3);
    evalin('base','q_convection_rad_out3(end+1)=varInBase');
    
    q_rad_radiation4 = q_rad_radiation;
    assignin('base','varInBase',q_rad_radiation4);
    evalin('base','q_rad_radiation4(end+1)=varInBase');
    
    q_top_radiation5 = q_top_radiation;
    assignin('base','varInBase',q_top_radiation5);
    evalin('base','q_top_radiation5(end+1)=varInBase');
    
    q_convection_top_out6 = q_convection_top_out;
    assignin('base','varInBase',q_convection_top_out6);
    evalin('base','q_convection_top_out6(end+1)=varInBase');
    
    q_vap7 = q_vap;
    assignin('base','varInBase',q_vap7);
    evalin('base','q_vap7(end+1)=varInBase');
    
    q_convection_top_in8 = q_convection_top_in;
    assignin('base','varInBase',q_convection_top_in8);
    evalin('base','q_convection_top_in8(end+1)=varInBase');

  
end