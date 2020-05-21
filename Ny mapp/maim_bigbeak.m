%% Big Beaker
clear
clf

q_convection_rad_in1 = 1; q_conduction2 = 1; q_convection_rad_out3 = 1; q_rad_radiation4 = 1; 
q_top_radiation5 = 1; q_convection_top_out6 = 1; q_vap7 = 1; q_convection_top_in8 = 1;

% --------------------------Inputs-----------------------------------------
T1 = readtable('large_exp1.txt');        % Import the Data
T2 = readtable('large_exp2.txt');
T3 = readtable('large_exp3.txt');

k = 0.9;
eps = 0.94;
D_in =  0.093; 
H_raw = 0.135;                          % Height of Beaker (m)
Beaker_vol = 1000 * pi*H_raw*(D_in/2)^2;       % Volume of the Beaker (liter)                         
D_out = 0.098;                           % Inner Diameter   (m)

m_A01 = T1.m__g_(1)/1000;
m_A02 = T2.m__g_(1)/1000;
m_A03 = T3.m__g_(1)/1000;

H1 = (m_A01*0.972 / Beaker_vol) * H_raw;        % Height of water  (m)
H2 = (m_A02*0.972 / Beaker_vol) * H_raw;
H3 = (m_A03*0.972 / Beaker_vol) * H_raw;
% -------------------------------------------------------------------------
% --------------------------Definitions------------------------------------
y01 = [353.15 m_A01];                      % Inital Temperature and mass at t=0
y02 = [353.15 m_A02];
y03 = [353.15 m_A03];
% -------------------------------------------------------------------------
% --------------------------Solver-----------------------------------------  
 t_span = linspace(0,1800,1800);
 
 % Beaker 1
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H1, k, eps);                                                                                                                       
     
    [t1, y1] = ode45(odefunc, t_span, y01);  
 
 % Beaker 2
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H2,k, eps);                                                                                                                       
     
    [t2, y2] = ode45(odefunc, t_span, y02);
    
 % Beaker 3
 
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H3, k, eps);                                                                                                                       
     
    [t3, y3] = ode45(odefunc, t_span, y03);
 
 q_convection_rad_in1=q_convection_rad_in1(2:end);
 q_conduction2=q_conduction2(2:end);
 q_convection_rad_out3=q_convection_rad_out3(2:end);
 q_rad_radiation4=q_rad_radiation4(2:end);
 q_top_radiation5=q_top_radiation5(2:end);
 q_convection_top_out6=q_convection_top_out6(2:end);
 q_vap7=q_vap7(2:end);
 q_convection_top_in8=q_convection_top_in8(2:end);
% -------------------------------------------------------------------------

%---------------------------Normalize--------------------------------------
T_norm1 = (y1(:,1) - min(y1(:,1)))/(max(y1(:,1))-min(y1(:,1)));
T_norm2 = (y2(:,1) - min(y2(:,1)))/(max(y2(:,1))-min(y2(:,1)));
T_norm3 = (y3(:,1) - min(y3(:,1)))/(max(y3(:,1))-min(y3(:,1)));

m_norm1 = (y1(:,2) - min(y1(:,2)))/(max(y1(:,2))-min(y1(:,2)));
m_norm2 = (y2(:,2) - min(y2(:,2)))/(max(y2(:,2))-min(y2(:,2)));
m_norm3 = (y3(:,2) - min(y3(:,2)))/(max(y3(:,2))-min(y3(:,2)));

T_data1 = (T1.T__C_ - min(T1.T__C_))/(max(T1.T__C_)-min(T1.T__C_));
T_data2 = (T2.T__C_ - min(T2.T__C_))/(max(T2.T__C_)-min(T2.T__C_));
T_data3 = (T3.T__C_ - min(T3.T__C_))/(max(T3.T__C_)-min(T3.T__C_));

m_data1 = (T1.m__g_ - min(T1.m__g_))/(max(T1.m__g_)-min(T1.m__g_));
m_data2 = (T2.m__g_ - min(T2.m__g_))/(max(T2.m__g_)-min(T2.m__g_));
m_data3 = (T3.m__g_ - min(T3.m__g_))/(max(T3.m__g_)-min(T3.m__g_));
%--------------------------------------------------------------------------
% --------------------------Adjust Data------------------------------------

y1(:,1) = y1(:,1) - 273.15;    
y1(:,2) = y1(:,2).*1000;     

y2(:,1) = y2(:,1) - 273.15;    
y2(:,2) = y2(:,2).*1000;

y3(:,1) = y3(:,1) - 273.15;    
y3(:,2) = y3(:,2).*1000;
%--------------------------------------------------------------------------
%--------------------------Residual for R^2--------------------------------
vq_T1_R = interp1(t_span,y1(:,1) ,T1.t__s_);
vq_T2_R = interp1(t_span,y2(:,1) ,T1.t__s_);
vq_T3_R = interp1(t_span,y3(:,1) ,T1.t__s_);

vq_m1_R = interp1(t_span, y1(:,2), T1.t__s_);
vq_m2_R = interp1(t_span, y2(:,2), T1.t__s_);
vq_m3_R = interp1(t_span, y3(:,2), T1.t__s_);

res_T1 = vq_T1_R - T1.T__C_;
res_T2 = vq_T2_R - T2.T__C_;
res_T3 = vq_T3_R - T3.T__C_;

res_m1 = vq_m1_R - T1.m__g_;
res_m2 = vq_m2_R - T2.m__g_;
res_m3 = vq_m3_R - T3.m__g_;

Rsq_T1 = 1 - sum((res_T1).^2)/sum((T1.T__C_ - mean(T1.T__C_)).^2);
Rsq_T2 = 1 - sum((res_T2).^2)/sum((T2.T__C_ - mean(T2.T__C_)).^2);
Rsq_T3 = 1 - sum((res_T3).^2)/sum((T3.T__C_ - mean(T3.T__C_)).^2);

Rsq_m1 = 1 - sum((res_m1).^2)/sum((T1.m__g_ - mean(T1.m__g_)).^2);
Rsq_m2 = 1 - sum((res_m2).^2)/sum((T2.m__g_ - mean(T2.m__g_)).^2);
Rsq_m3 = 1 - sum((res_m3).^2)/sum((T3.m__g_ - mean(T3.m__g_)).^2);

%---------------------------Plot of flows---------------------------------- 
 figure(1)                  
 plot(t1, y1(:,1), 'r', t2, y2(:,1), 'b', t3, y3(:,1), 'g')
 hold on
 plot(T1.t__s_, T1.T__C_, 'rx', T1.t__s_, T2.T__C_, 'bx', T1.t__s_, T3.T__C_, 'gx')
 ylabel('Temperature ($^{\circ} C$)', 'Interpreter', 'latex')
 xlabel('Time (s)', 'Interpreter', 'latex')
 title('Temperature', 'Interpreter', 'latex')
 
str1 = sprintf('Small Experiment 1  R^2=%.*f', 3,Rsq_T1);
str2 = sprintf('Small Experiment 2  R^2=%.*f', 3,Rsq_T2);
str3 = sprintf('Small Experiment 3  R^2=%.*f', 3,Rsq_T3);
legend({str1, str2, str3});

 figure(2)
 plot(t1, y1(:,2), t2, y2(:,2), t3, y3(:,2))
 hold on
 plot(T1.t__s_, T1.m__g_, 'x', T1.t__s_, T2.m__g_, 'x', T1.t__s_, T3.m__g_, 'x')
 ylabel('Mass (g)', 'Interpreter', 'latex')
 xlabel('Time (s)', 'Interpreter', 'latex')
 title('Mass', 'Interpreter', 'latex')
 
str1 = sprintf('Small Experiment 1  R^2=%.*f', 3,Rsq_m1);
str2 = sprintf('Small Experiment 2  R^2=%.*f', 3,Rsq_m2);
str3 = sprintf('Small Experiment 3  R^2=%.*f', 3,Rsq_m3);
legend({str1, str2, str3});
%------------------------------------------------------------------------
 % -------------------------Residual Plot----------------------------------
vq_T1 = interp1(t_span,T_norm1 ,T1.t__s_);
vq_T2 = interp1(t_span,T_norm2 ,T1.t__s_);
vq_T3 = interp1(t_span,T_norm3 ,T1.t__s_);

vq_m1 = interp1(t_span, m_norm1, T1.t__s_);
vq_m2 = interp1(t_span, m_norm2, T1.t__s_);
vq_m3 = interp1(t_span, m_norm3, T1.t__s_);

figure(3)
 subplot(1,2,1);
 plot(vq_T1, T_data1, 'o', vq_T2, T_data2, 'o', vq_T3, T_data3, 'o')
 hold on
 plot(T_data1, T_data1, 'k', 'linewidth', 1.2)
 xlabel('Predicted Normalized Value')
 ylabel('Actual Normalized Value')
 title('Temperature')

 subplot(1,2,2);
 plot(vq_m1, m_data1, 'o', vq_m2, m_data2, 'o', vq_m3, m_data3, 'o')
 hold on
 plot(m_data1, m_data1, 'k', 'linewidth', 1.2)
 xlabel('Predicted Normalized Value')
 ylabel('Actual Normalized Value')
 title('Mass')
%----------------------Residuals-------------------------------------------
residual_T1 = vq_T1 - T_data1;
residual_T2 = vq_T2 - T_data2;
residual_T3 = vq_T3 - T_data3;

residual_m1 = vq_m1 - m_data1;
residual_m2 = vq_m2 - m_data2;
residual_m3 = vq_m3 - m_data3;

figure(4)
subplot(2,1,1);
plot(T1.t__s_, residual_T1, 'ro', T1.t__s_, residual_T2, 'bo', T1.t__s_, residual_T3, 'go')
hold on
plot(vq_T1, residual_T1, 'r', vq_T2, residual_T2, 'b', vq_T3, residual_T3, 'g')
plot([0 1], [0 0], 'black', 'linewidth', 2)
ylabel('Normalized Residuals')
title('Temperature')

subplot(2,1,2);
plot(T1.t__s_, residual_m1, 'ro', T1.t__s_, residual_m2, 'bo', T1.t__s_, residual_m3, 'go')
hold on
plot(T1.t__s_, residual_m1, 'r', T1.t__s_, residual_m2, 'b', T1.t__s_, residual_m3, 'g')
plot([0 1], [0 0], 'black', 'linewidth', 2)
ylabel('Normalized Residuals')
xlabel('Time (s)')
title('Mass')
%sgtitle('Residual plot')
% -------------------------------------------------------------------------
%------------------- Heat Flows Total -------------------------------------------
q_tot = q_convection_rad_in1 + q_convection_top_in8;

p_q_convection_rad_in = q_convection_rad_in1./q_tot;
p_q_conduction = q_conduction2./q_tot;
p_q_convection_rad_out = q_convection_rad_out3./q_tot;
p_q_rad_radiation = q_rad_radiation4./q_tot;
p_q_top_radiation = q_top_radiation5./q_tot;
p_q_convection_top_out = q_convection_top_out6./q_tot;
p_q_vap = q_vap7./q_tot;
p_q_convection_top_in = q_convection_top_in8./q_tot;
% ---------------------------Heat flows top--------------------------------
TOP_p_q_top_radiation = q_top_radiation5./q_convection_top_in8;
TOP_p_q_vap = q_vap7./q_convection_top_in8;
TOP_p_q_convection_top_out = q_convection_top_out6./q_convection_top_in8
% -------------------------------------------------------------------------
RADq_convection_rad_out = q_convection_rad_out3./q_convection_rad_in1;
RADp_q_rad_radiation = q_rad_radiation4./q_convection_rad_in1;
% ---------------------------Heat flows rad--------------------------------
%convection heat loss
p_conv = p_q_convection_top_out + p_q_convection_rad_out;
p_rad = p_q_top_radiation + p_q_rad_radiation;

t_fusk = linspace(0,1800,85);
T_fusk = interp1(t_span, y1(:,1), t_fusk);

figure(5)
subplot(2,2,1);
plot(T_fusk, p_conv(1:85))
hold on
plot(T_fusk, p_rad(1:85))
hold on
plot(T_fusk, p_q_vap(1:85))
legend({'Convection', 'Radiation', 'Evaporation'},'Location','East')
title('Different mechanisms')
xlabel('Temperature ($^{\circ} C$)', 'Interpreter', 'latex')
axis([55 80 0 1])

subplot(2,2,2);
plot(T_fusk, p_q_convection_top_in(1:85))
hold on
plot(T_fusk, p_q_convection_rad_in(1:85))
hold on
legend({'Top', 'Radial'},'Location','East')
title('Different geometry')
axis([55 80 0 1])
xlabel('Temperature ($^{\circ} C$)', 'Interpreter', 'latex')

subplot(2,2,3);
plot(T_fusk, TOP_p_q_convection_top_out(1:85))
hold on
plot(T_fusk, TOP_p_q_top_radiation(1:85))
hold on
plot(T_fusk,TOP_p_q_vap(1:85))

hold on
legend({'Convection', 'Radiation', 'Evaporation'},'Location','NorthWest')
title('Top outside')
axis([55' 80 0 1])
xlabel('Temperature ($^{\circ} C$)', 'Interpreter', 'latex')

subplot(2,2,4);
plot(T_fusk, RADq_convection_rad_out(1:85))
hold on
plot(T_fusk,RADp_q_rad_radiation(1:85))
hold on
legend({'Convection', 'Radiation'},'Location','NorthWest')
title('Radial outside')
axis([55 80 0 1])
xlabel('Temperature ($^{\circ} C$)', 'Interpreter', 'latex') 