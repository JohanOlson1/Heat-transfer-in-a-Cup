function out = my_air(T)

% Dynamisk viskositet för luft, Pa*s
%
% my=my_air(T), T i Kelvingrader

out = (19.98+0.04650*(T-333))*1e-6;
