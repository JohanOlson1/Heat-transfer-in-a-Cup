%% Project in KAA052
clear

% --------------------------Inputs-----------------------------------------
T = readtable('large_exp1.txt');        % Import the Data

Beaker_vol = 0.800;                     % Volume of the Beaker (liter)
m_A0 = 0.53805;                          % Inital Mass of water (kg)
D_out = 0.098;                           % Inner Diameter   (m)
D_in =  0.093;                          % Outer Diameter   (m)
H_raw = 0.135;                          % Height of Beaker (m)
H = (m_A0 / Beaker_vol) * H_raw;        % Height of water  (m)
% -------------------------------------------------------------------------


% --------------------------Definitions------------------------------------
T_0_rad = [300, 300]; T_0_top = 300;    % Inital guesses for surfaces, no need to change!
y0 = [353.15 m_A0];                      % Inital Temperature and mass at t=0
% -------------------------------------------------------------------------


% --------------------------Solver-----------------------------------------     
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H);                    % System of ODE
     
 t_span = linspace(0,1800,3*1801);                                       % Timespan                                                        
     
 [t, y] = ode45(odefunc, t_span, y0);                                    % Solution for temp. and mass                                                                 
     
% -------------------------------------------------------------------------

% --------------------------Plotting---------------------------------------
 y(:,1) = y(:,1) - 273.15;    % Transform Temperature from Kelvin to Celsius
 y(:,2) = y(:,2).*1000;       % Transfrom Mass from kg to g
 
 figure(1)                    % Temperature
 plot(t, y(:, 1))
 hold on
 plot(T.t__s_, T.T__C_, 'x')
 ylabel('Temperature (C)')
 xlabel('Time (s)')
 
 figure(2)                    % Mass
 plot(t, y(:, 2))
 hold on
 plot(T.t__s_, T.m__g_, 'x')
 ylabel('Mass (g)')
 xlabel('Time (s)')
 
 
 
 
 
MK_T = 0; MK_m = 0;

for i=90:90:5400
    MK_T = MK_T + (y(i,1)-T.T__C_(i/90+1))^2;
    MK_m = MK_m + (y(i,2)-T.m__g_(i/90+1))^2;
end
 
MK_tot = MK_T + MK_m
% -------------------------------------------------------------------------