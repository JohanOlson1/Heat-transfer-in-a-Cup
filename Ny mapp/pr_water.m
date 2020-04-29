function out = pr_water(T)

% Prandtl tal för vatten
%
% Pr=pr_water(T), T i Kelvingrader

out = 0.25+0.1*T+0.00591826667655*T^2-0.00005322442111*T^3+0.00000015117052*T^4-0.00000000014174*T^5;

