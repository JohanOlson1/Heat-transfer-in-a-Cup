function F = sys_top_modified(T_top, T_A, D_in, eps)
    
    A_top = pi * (D_in/2)^2; boltz =  5.67e-8; T_O = 293.15;
    
    % For the mass Difference!
    % 100 % relativ fuktighet 0.017274 kg/m^3
    % 50 % rel fukt 0.00864 kg/m^3
    rho_water_1 = 0.00377 * exp(17.27 * (T_top -273.15)/(T_top - 16.01));
    rho_water_2 = 0.01801528/(T_top * 8.3145) * p_water(T_top);
    delta_conc = (rho_water_1 - 0.00864);
    kc = h_top_outside(T_top, D_in) * (2.9e-6) * (T_top) / (rho_air((T_A + T_top)/2)^(1/3) * cp_air((T_A + T_top)/2)^(1/3) * k_air((T_A + T_top)/2)^(2/3));
    
    % Heat Flows
    q_top_radiation = - eps * boltz * A_top * (T_top^4 - T_O^4);
    q_convection_top_out = - h_top_outside(T_top, D_in) * A_top * (T_top - T_O);
    q_vap = - dHvap_water(T_top) * delta_conc * A_top * kc;
    q_convection_top_in = - h_top_inside(T_top, T_A, D_in) * A_top * (T_A - T_top);
    
    F = q_convection_top_out + q_top_radiation + q_vap - q_convection_top_in;
    
end