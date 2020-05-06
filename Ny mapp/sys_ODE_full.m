function F = sys_ODE_full(t, y, D_in, D_out, H)

    T_0_rad = [300, 300]; T_0_top = 300;
    
    fun1 = @(T)sys_rad(T, y(1), D_out, D_in, H);                            % Function for solving the radial surface temp.
    T_surface_rad = fsolve(fun1, T_0_rad);                                  % Solution of surface temp.

    
    fun2 = @(T)sys_top(T, y(1), D_in, 1e-6);                                % Function for solving the top surface temp.
    T_surface_top = fsolve(fun2, T_0_top);                                  % Solution of surface temp.
    
    F = zeros(2,1);
    
    odegrej = @(t, y)sys_ODE(t, y, T_surface_rad(1), T_surface_top, D_in, H); 
    
    F = odegrej
    
    
  
end