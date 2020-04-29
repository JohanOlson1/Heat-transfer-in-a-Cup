function out = rho_water(T)

% Densitet för vatten, kg/m3
%
% rho=rho_water(T), T i Kelvingrader


out = 809.136623692068+1.548175498218*T-0.003079092136*T^2;

