%% Project in KAA052
clear

% --------------------------Inputs-----------------------------------------
T = readtable('small_exp5.txt');        % Import the Data

Beaker_vol = 0.250                      % Volume of the Beaker (liter)
m_A0 = 0.1795                           % Inital Mass of water (kg)
D_out = 0.07;                           % Inner Diameter   (m)
D_in =  0.067;                          % Outer Diameter   (m)
H_raw = 0.095;                          % Height of Beaker (m)
H = (m_A0 / Beaker_vol) * 0.095;        % Height of water  (m)
% -------------------------------------------------------------------------


% --------------------------Definitions------------------------------------
T_0_rad = [300, 300]; T_0_top = 300;    % Inital guesses for surfaces, no need to change!
y = [353.15 m_A0];                      % Inital Temperature and mass at t=0

DmA(1, 1) = 0.919201390986246e-5;       % Inital guess for the mass loss per second, needed for t=0
% -------------------------------------------------------------------------


% --------------------------Solver-----------------------------------------
for i=0:1:1800                                                              % Timespan for solution
    
    fun1 = @(T)sys_rad(T, y(1), D_out, D_in, H);                            % Function for solving the radial surface temp.
    T_surface_rad = fsolve(fun1, T_0_rad);                                  % Solution of surface temp.

    
    fun2 = @(T)sys_top(T, y(1), D_in, DmA(i+1, 1));                         % Function for solving the top surface temp.
    T_surface_top = fsolve(fun2, T_0_top);                                  % Solution of surface temp.
    
    
    odefunc = @(t, y)sys_ODE(t, y, T_surface_rad(1), T_surface_top, D_in, H); % System of ODE
    
    t_span = [i i+1];                                                       % Timespan between each solution, eg. step length
    mA = y(end,2);                                                          % Mass at t=0
    
    [t, y] = ode45(odefunc, t_span, y(end,:));                              % Solution for temp. and mass at time i                                                                
    
    dmA = mA - y(end,2)                                                     % Mass Difference over one second
    
    DmA(i+2, 1) = dmA;                                                      % Append Mass Difference for use in next loop
    
    Y(i+1, :) = [t(end), y(end, :)];                                        % Append solution to a matrix
end
% -------------------------------------------------------------------------


% --------------------------Plotting---------------------------------------
Y(:,2) = Y(:,2) - 273.15;    % Transform Temperature from Kelvin to Celsius
Y(:,3) = Y(:,3).*1000;       % Transfrom Mass from kg to g

figure(1)                    % Temperature
plot(Y(:, 1), Y(:, 2))
hold on
plot(T.t__s_, T.T__C_, 'x')


figure(2)                    % Mass
plot(Y(:, 1), Y(:, 3))
hold on
plot(T.t__s_, T.m__g_, 'x')
% -------------------------------------------------------------------------





