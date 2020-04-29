function F = sys_rad(T, T_A, D_out, D_in, H)
    T_r_inner = T(1);
    T_r_outer = T(2);
    
    k = 0.9; d = (D_out - D_in)/2; r_o = D_out/2; r_in = D_in/2; A_inner = 2 * r_in * pi * H; A_outer = 2 * r_o * pi * H;
    T_O = 293.15; eps = 0.945; boltz = 1.38064852 * 1e-23;
    
    F(1) = 2 * pi * k * d * (T_r_inner - T_r_outer) / (log(r_o/r_in)) - h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner);
    F(2) = h_r_outside2(T_r_outer, H) * A_outer * (T_r_outer - T_O) + eps * boltz * A_outer * ((T_r_outer)^4 - T_O^4) - h_r_inside2(T_r_inner, T_A, H) * A_inner * (T_A - T_r_inner);
    F(3) = 2 * pi * k * d * (T_r_inner - T_r_outer) / (log(r_o/r_in)) - h_r_outside2(T_r_outer, H) * A_outer * (T_r_outer - T_O) + eps * boltz * A_outer * ((T_r_outer)^4 - T_O^4);
end
    