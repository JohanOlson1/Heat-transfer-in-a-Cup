clear
clf

q_convection_rad_in1 = 1; q_conduction2 = 1; q_convection_rad_out3 = 1; q_rad_radiation4 = 1; 
q_top_radiation5 = 1; q_convection_top_out6 = 1; q_vap7 = 1; q_convection_top_in8 = 1;

% --------------------------Inputs-----------------------------------------
T = readtable('small_exp2.txt');        % Import the Data

k = 0.9;
eps = 0.94;
D_in =  0.067; 
H_raw = 0.095;                          % Height of Beaker (m)
Beaker_vol = pi*H_raw*(D_in/2)^2;       % Volume of the Beaker (liter)                         
D_out = 0.07;                           % Inner Diameter   (m)

m_A0 = T.m__g_(1)/1000;

H = (m_A0*0.972 / (1000* Beaker_vol)) * H_raw;        % Height of water 
% -------------------------------------------------------------------------

% --------------------------Definitions------------------------------------
y0 = [353.15 m_A0];                      % Inital Temperature and mass at t=0
% -------------------------------------------------------------------------


% --------------------------Solver-----------------------------------------  
 t_span = linspace(0,1800,1800);
 
 % Beaker 1
 odefunc = @(t, y)sys_ODE_full(t, y, D_in, D_out, H, k, eps);                                                                                                                       
     
    [t, y] = ode45(odefunc, t_span, y0);  
 
param = [D_in, H, k, eps];


Z = zeros(1800, 4)
for i=1:4
    param(i) = 1.1 * param(i)
    
    odefunc1 = @(t, y)sys_ODE_full(t, y, param(1), D_out, param(2), param(3), param(4));                                                                                                                       
     
    [tau, yau] = ode45(odefunc1, t_span, y0);  
    
    Z(:,i) = yau(:,1);
    
    param(i) = param(i)/1.1;
end
% -------------------------------------------------------------------------

S = Z - y(:,1);

for j=1:4
    Sense(j) = sum(S(:,j))/1800;
end

Sense

%plot(t,y(:,1), 'r', t, yau(:,1))

% --------------------------Adjust Data------------------------------------

y(:,1) = y(:,1) - 273.15;    
y(:,2) = y(:,2).*1000;     
