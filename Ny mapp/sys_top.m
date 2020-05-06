function F = sys_top(T_top, T_A, D_in, dmA)
    
    A_top = pi * (D_in/2)^2; eps = 0.945; boltz = 1.38064852 * 1e-23; T_O = 293.15;
    
    % Heat Flows
    q_radiation = - eps * boltz * A_top * (T_top^4 - T_O^4);
    q_convection_out = - h_top_outside(T_top, D_in) * A_top * (T_top - T_O);
    q_vap = - dHvap_water((T_A + T_top)/2) * dmA;
    q_convection_in = - h_top_inside(T_top, T_A) * A_top * (T_A - T_top);
    
    F = q_convection_out + q_radiation + q_vap - q_convection_in;
    
end