function out = cp_water(T)

% Värmekapacivitet för vatten, J/(kg K)
%
% cp=cp_water(T), T i Kelvingrader

out = 4190-0.72504*(T-273)+9.3615e-3*(T-273)^2;
