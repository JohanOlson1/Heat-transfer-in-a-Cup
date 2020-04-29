function out = my_water(T)

% Dynamisk viskositet för vatten, Pa * s
%
% my=my_water(T), T i Kelvingrader

out = (464.86-7.543*(T-333)+0.1171*(T-333)^2)*1e-6;