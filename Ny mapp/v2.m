clear

x1 = ones(12,1);

x2 = [20 20 6.67 6.67 4 4 1.82 1.82 0.91 0.91 0.40 0.4]';

X = [x1, x2];

y = [3.013 2.835 1.483 1.325 0.94 1.16 0.875 0.88 0.677 0.616 0.677 0.7]';

b = inv(X' * X) * X' * y;


ymodel = X * b;

ymean = sum(y)/12;

SS_tot = sum((y - ymean).^2)
SS_reg = sum((ymodel - ymean).^2)
SS_E   = sum((ymodel - y).^2)

fuskX = X' * X;
fuskX = inv(fuskX)

SS_b0 = sqrt(SS_E/9 * fuskX(1,1))
SS_b1 = sqrt(SS_E/9 * fuskX(2,2))

ysum = 0;
for i = 1:2:12
    y_a = (y(i) + y(i+1))/2;
    
    ysum = ysum + (y(i) - y_a)^2 + (y(i+1) - y_a)^2
end




