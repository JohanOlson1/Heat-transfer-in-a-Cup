function F = sys_rad(T, T_A, D_out, D_in, H, k, eps)
    T_r_inner = T(1);
    T_r_outer = T(2);
    
    d = (D_out - D_in)/2; r_o = D_out/2; r_in = D_in/2; A_inner = 2 * r_in * pi * H; A_outer = 2 * r_o * pi * H;
    T_O = 293.15; boltz = 5.67e-8;
    
    % Heat Flows
    q_convection_rad_in = - h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner);
    q_conduction = - 2 * pi * k * d * (T_r_inner - T_r_outer) / (log(r_o/r_in));
    q_convection_rad_out = - h_r_outside2(T_r_outer, H) * A_outer * (T_r_outer - T_O);
    q_rad_radiation = - eps * boltz * A_outer * ((T_r_outer)^4 - T_O^4);
 
    
    F(1) = q_conduction - q_convection_rad_in;
    F(2) = q_convection_rad_out + q_rad_radiation - q_convection_rad_in;
    
    
    
end
    