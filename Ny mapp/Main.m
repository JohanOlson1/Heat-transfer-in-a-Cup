clear

% --------------------------Inputs-----------------------------------------
T = readtable('small_exp5.txt');        % Import the Data

Beaker_vol = 0.250;                     % Volume of the Beaker (liter)
m_A0 = 0.1795;                          % Inital Mass of water (kg)
D_out = 0.07;                           % Inner Diameter   (m)
D_in =  0.067;                          % Outer Diameter   (m)
H_raw = 0.095;                          % Height of Beaker (m)
H = (m_A0 / Beaker_vol) * H_raw;            % Height of water  (m)
% -------------------------------------------------------------------------

t_span = [0 1800];
y0 = [353.15 m_A0];

odefun = @(t, y)sys_ODE_full(t, y, D_in, D_out, H)

[t, y] = ode45(odefun, t_span, y0)