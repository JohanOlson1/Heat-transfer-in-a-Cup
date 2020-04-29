function out = cp_air(T)

% Värmekapacivitet för luft, J/(kg K)
%
% cp=cp_air(T), T i Kelvingrader

out = 1003.4+0.07*(T-273);
