%% Project in KAA052
clear
clf

q_convection_rad_in1 = 1; q_conduction2 = 1; q_convection_rad_out3 = 1; q_rad_radiation4 = 1; 
q_top_radiation5 = 1; q_convection_top_out6 = 1; q_vap7 = 1; q_convection_top_in8 = 1;

% --------------------------Inputs-----------------------------------------
T1 = readtable('large_exp1.txt');        % Import the Data
T2 = readtable('large_exp2.txt');
T3 = readtable('large_exp3.txt');

T = (T1.T__C_ + T2.T__C_ + T3.T__C_)/3;

m = (T1.m__g_ + T2.T__C_ + T3.T__C_)/3;



m_A0 = m(1)/1000;

Beaker_vol = 0.250;                     % Volume of the Beaker (liter)                         % Inital Mass of water (kg)
D_out = 0.07;                           % Inner Diameter   (m)
D_in =  0.067;                          % Outer Diameter   (m)
H_raw = 0.095;                          % Height of Beaker (m)
H = (m_A0 / Beaker_vol) * H_raw;        % Height of water  (m)
% -------------------------------------------------------------------------


% --------------------------Definitions------------------------------------
y0 = [353.15 m_A0];                      % Inital Temperature and mass at t=0
% -------------------------------------------------------------------------


% --------------------------Solver-----------------------------------------     
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H);                    % System of ODE   
 t_span = linspace(0,1800,1800);                                         % Timespan                                                        
     
 [t, y] = ode45(odefunc, t_span, y0);                                    % Solution for temp. and mass 
 q_convection_rad_in1=q_convection_rad_in1(2:end);
 q_conduction2=q_conduction2(2:end);
 q_convection_rad_out3=q_convection_rad_out3(2:end);
 q_rad_radiation4=q_rad_radiation4(2:end);
 q_top_radiation5=q_top_radiation5(2:end);
 q_convection_top_out6=q_convection_top_out6(2:end);
 q_vap7=q_vap7(2:end);
 q_convection_top_in8=q_convection_top_in8(2:end);
% -------------------------------------------------------------------------



% --------------------------Plotting---------------------------------------

%---------------------------Plot of flows---------------------------------- 
 y(:,1) = y(:,1) - 273.15;    % Transform Temperature from Kelvin to Celsius
 y(:,2) = y(:,2).*1000;       % Transfrom Mass from kg to g
 
 figure(1)                    % Temperature
 subplot(2,1,1)
 plot(t, y(:, 1))
 hold on
 plot(T1.t__s_, T, 'x')
 ylabel('Temperature (C)')
 xlabel('Time (s)')
 title('Temperature')
 
 subplot(2,1,2)
 plot(t, y(:, 2))
 hold on
 plot(T1.t__s_, m, 'x')
 ylabel('Mass (g)')
 xlabel('Time (s)')
 title('Mass')
 % ------------------------------------------------------------------------


 % -------------------------Residual Plot----------------------------------
vq_T = interp1(t_span,y(:,1),T1.t__s_);
figure(2)
 subplot(1,2,1);
 plot(vq_T, T, 'o')
 hold on
 plot(T, T)
 xlabel('Predicted Value')
 ylabel('Actual')

vq_m = interp1(t_span,y(:,2),T1.t__s_);
 subplot(1,2,2);
 plot(vq_m, m, 'o')
 hold on
 plot(m, m)
  xlabel('Predicted Value')
 ylabel('Actual')
 
 sgtitle('Actual vs Predicted')


residual_m = vq_m - m;
residual_T = vq_T - T;

figure(3)
subplot(2,1,1);
plot(vq_m, residual_m, 'o')
subplot(2,1,2);
plot(vq_T, residual_T, 'o')
sgtitle('Residuals')



Rsq_T = 1 - sum((residual_T).^2)/sum((T - mean(T)).^2)
Rsq_m = 1 - sum((residual_m).^2)/sum((m - mean(m)).^2)
% -------------------------------------------------------------------------

%------------------- Heat Flows -------------------------------------------

q_tot = q_convection_rad_in1 + q_convection_top_in8;


p_q_convection_rad_in = q_convection_rad_in1./q_tot;

p_q_conduction = q_conduction2./q_tot;

p_q_convection_rad_out = q_convection_rad_out3./q_tot;

p_q_rad_radiation = q_rad_radiation4./q_tot;

p_q_top_radiation = q_top_radiation5./q_tot;

p_q_convection_top_out = q_convection_top_out6./q_tot;

p_q_vap = q_vap7./q_tot;

p_q_convection_top_in = q_convection_top_in8./q_tot;

% -------------------------------------------------------------------------



p_q_vap + p_q_convection_top_out + p_q_top_radiation + p_q_rad_radiation + p_q_convection_rad_out;

%convection heat loss

p_conv = p_q_convection_top_out + p_q_convection_rad_out;
p_rad = p_q_top_radiation + p_q_rad_radiation;


t_fusk = linspace(0,1800,85);

T_fusk = interp1(t_span, y(:,1), t_fusk);


figure(4)
plot(T_fusk, p_conv)
hold on
plot(T_fusk, p_rad)
hold on
plot(T_fusk, p_q_vap)
legend({'Convection', 'Radiation', 'Evaporation'},'Location','NorthWest')
title('Percentage of different heat Loss Mechanisms')

% figure(7)
% plot(t_fusk, q_convection_rad_in1)
% hold on
% plot(t_fusk, q_conduction2)
% hold on
% plot(t_fusk, q_convection_rad_out3)
% hold on
% plot(t_fusk, q_rad_radiation4)
% hold on
% plot(t_fusk, q_top_radiation5)
% hold on
% plot(t_fusk, q_convection_top_out6)
% hold on
% plot(t_fusk, q_vap7)
% hold on
% plot(t_fusk, q_convection_top_in8)