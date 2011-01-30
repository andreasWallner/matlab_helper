clc
clear

output_bits = 8;

t = 0 : 0.0001 : pi;
x = discretize( sin(t), 2^8);
avg = sum(x) / length(x);

xn = zeros(16, length(t));
tn = xn;
diff = xn;
avg = xn;
delta_sq = xn;
dev = zeros(16);

% 00  0000
% 01  0101
% 10  1010
% 11  1111

for i = 1:16 
    tn(i,:) = discretize( t, 2^i);
    xn(i,:) = discretize( sin(tn(i,:)), 2^output_bits);
    diff(i, :) = abs(x - xn(i,:));
    avg(i, :) = sum(diff(i, :)) / length(t);
    delta_sq(i,:) = (avg(i,:) - diff(i, :)).^2;
    std_dev = sqrt(sum(delta_sq(i,:))) / length(t);
    dev(i) = std_dev;
end;

% analyse the results via graphs