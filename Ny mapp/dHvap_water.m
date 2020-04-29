function out = dHvap_water(T)

% Ångbildningsvärme för vatten, J/kg
%
% dHvap=dHvap_water(T), T i Kelvingrader

out = 2498714.3-2247.4*(T-273)+1.688*(T-273)^2;
