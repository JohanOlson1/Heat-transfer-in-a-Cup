function F = sys_top(T_top, T_A, D_in, dmA)
    
    A_top = pi * (D_in/2)^2; eps = 0.945; boltz = 1.38064852 * 1e-23; T_O = 293.15;
    
    F = h_top_outside(T_top, D_in) * A_top * (T_top - T_O) + eps * boltz * A_top * (T_top^4 - T_O^4) + dHvap_water((T_A + T_top)/2) * dmA - h_top_inside(T_top, T_A) * A_top * (T_A - T_top);
    
end