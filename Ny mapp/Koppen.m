%% Project in KAA052
clear
clf

q_convection_rad_in1 = 1; q_conduction2 = 1; q_convection_rad_out3 = 1; q_rad_radiation4 = 1; 
q_top_radiation5 = 1; q_convection_top_out6 = 1; q_vap7 = 1; q_convection_top_in8 = 1;

% --------------------------Inputs-----------------------------------------
Beaker_vol = 0.150;                     % Volume of the Beaker (liter)                         
D_out = 0.07;                           % Inner Diameter   (m)
D_in =  0.067;                          % Outer Diameter   (m)
H = 0.095;                          % Height of Beaker (m)

m_A0 = Beaker_vol*0.972;
% -------------------------------------------------------------------------


% --------------------------Definitions------------------------------------
y0 = [353.15 m_A0];                      % Inital Temperature and mass at t=0
% -------------------------------------------------------------------------


% --------------------------Solver-----------------------------------------  
 t_span = linspace(0,1800,1800);
 
 % Beaker 1
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H);                                                                                                                       
     
    [t, y] = ode45(odefunc, t_span, y0);  
 
 q_convection_rad_in1=q_convection_rad_in1(2:end);
 q_conduction2=q_conduction2(2:end);
 q_convection_rad_out3=q_convection_rad_out3(2:end);
 q_rad_radiation4=q_rad_radiation4(2:end);
 q_top_radiation5=q_top_radiation5(2:end);
 q_convection_top_out6=q_convection_top_out6(2:end);
 q_vap7=q_vap7(2:end);
 q_convection_top_in8=q_convection_top_in8(2:end);
% -------------------------------------------------------------------------

% --------------------------Adjust Data------------------------------------

y(:,1) = y(:,1) - 273.15;    
y(:,2) = y(:,2).*1000;     
%--------------------------------------------------------------------------

%---------------------------Plot of flows---------------------------------- 
 figure(1)                  
 plot(t, y(:,1), 'r')
 hold on
 ylabel('Temperature ($^{\circ} C$)', 'Interpreter', 'latex')
 xlabel('Time (s)', 'Interpreter', 'latex')
 title('Temperature', 'Interpreter', 'latex')

 
 
 figure(2)
 plot(t, y(:,2), 'r')
 hold on
 ylabel('Mass (g)', 'Interpreter', 'latex')
 xlabel('Time (s)', 'Interpreter', 'latex')
 title('Mass', 'Interpreter', 'latex')