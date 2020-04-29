%% Projekt i KAA052
clear

T = readtable('large_exp1.txt'); %läs in datan

D_out = 0.098;
D_in =  0.093;
H = (538/800) * 0.135;
%H = 0.095;

T_0_rad = [300, 300];

%fun1 = @(T)sys_rad(T, 353.15, 0.068);

%T_surface_rad = fsolve(fun1, T_0_rad);

T_0_top = 300;

%fun2 = @(T)sys_top(T, 353.15, 0.000005);

%T_surface_top = fsolve(fun2, T_0_top);


y = [353.15 0.538];
Y = zeros(991, 3);

DmA = zeros(992, 1);

DmA(1, 1) = 1.919201390986246e-5;

for i=0:1:1800
    
    fun1 = @(T)sys_rad(T, y(1), D_out, D_in, H);

    T_surface_rad = fsolve(fun1, T_0_rad);

    
    fun2 = @(T)sys_top(T, y(1), D_in, DmA(i+1, 1));

    T_surface_top = fsolve(fun2, T_0_top);
    
    
    odefunc = @(t, y)sys_ODE(t, y, T_surface_rad(1), T_surface_top, D_in, H);
    
    t_span = [i i+1];
    
    mA = y(end,2); % Massa innan
    
    [t, y] = ode45(odefunc, t_span, y(end,:));
    y(end,:)      % Massa efter
    
    dmA = mA - y(end,2) % Skillnad massa
    
    DmA(i+2, 1) = dmA;
    format long
    
    Y(i+1, :) = [t(end), y(end, :)];
end

Y(:,2) = Y(:,2) - 273.15;
Y(:,3) = Y(:,3).*1000;

figure(1)
plot(Y(:, 1), Y(:, 2))
hold on
plot(T.t__s_, T.T__C_, 'x')


figure(2)
plot(Y(:, 1), Y(:, 3))
hold on
plot(T.t__s_, T.m__g_, 'x')