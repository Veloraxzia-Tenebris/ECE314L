% Sonny Ji
% ECE314L Lab
% Homework #2
% Problems: 2.83, 2.87



%----------------Problem 2.83
%\/----------------------------------------\/
figure('Name', 'Problem 2.83', 'NumberTitle', 'off')
%Global variables get angry if not done with a clear workspace
clearvars -except intel
%Defining functions
global nx ny nz nw nf ng a b x y z w f g;
x = [1 1 1 1 1 1 1];
nx = -5:1;
y = [1 1 1 1 -1 -1 -1 -1];
ny = -3:4;
z = [1 1 1 1 2 2 2 2 2];
nz = 0:8;
w = [-1 0 1 2 3 2 1 0 -1];
nw = -4:4;
f = [-2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5];
nf = -5:5;
g = [1 1 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1];
ng = -8:10;
%Making vectors of problem parts
a = ['x' 'x' 'x' 'x' 'y' 'y' 'y' 'y' 'z' 'w' 'f'];
b = ['z' 'y' 'f' 'g' 'z' 'g' 'w' 'f' 'g' 'g' 'g'];

%Making loop for all problem parts
for i = 1:11
	plotconv(eval(a(i)), eval(b(i)), i)
end
%/\----------------------------------------/\



%----------------Problem 2.87
%\/----------------------------------------\/
figure('Name', 'Problem 2.87', 'NumberTitle', 'off')
clearvars -except intel
load intel.mat
%Setting initial variables and coefficients
data = intel;
a = [1 -1.143 0.4128];
b = [0.0675 0.1349 0.675];
%Making sample range
n = 0:50;
%Part (a)
xi = [0 0];
xn = zeros(1, length(n));
xn(1:end) = 1;
y = filter(b, a, xn);

subplot(3, 2, 1)
stem(n, y, 'ms', 'MarkerFaceColor', 'm')
title('(a) Particular Solution')
xlabel('n')
ylabel('s[n]')
%Part (b)
xi = [-1 2];
xn = zeros(1, length(n));
y = filter(b, a, xn, xi);

subplot(3, 2, 2)
stem(n, y, 'ms', 'MarkerFaceColor', 'm')
title('(b) Homogeneous Solution')
xlabel('n')
ylabel('y[n]')
%Part (c)
xi = [0 0];
xn = cos((pi * n) / 10);
y = filter(b, a, xn, xi);

subplot(3, 2, 3)
stem(n, y, 'ms', 'MarkerFaceColor', 'm')
title('(c) Low Frequency')
xlabel('n')
ylabel('Response to x[n] = $$cos \left( \frac{1}{10} \pi n \right)$$', 'interpreter', 'latex')
%Part (d)
xn = cos((pi * n) / 5);
y = filter(b, a, xn, xi);

subplot(3, 2, 4)
stem(n, y, 'ms', 'MarkerFaceColor', 'm')
title('(d) Medium Frequency')
xlabel('n')
ylabel('Response to x[n] = $$cos \left( \frac{1}{5} \pi n \right)$$', 'interpreter', 'latex')
%Part (e)
xn = cos((pi * n) * 2.4);
y = filter(b, a, xn, xi);

subplot(3, 2, 5)
stem(n, y, 'ms', 'MarkerFaceColor', 'm')
title('(e) High Frequency')
xlabel('n')
ylabel('Response to x[n] = $$cos \left( \frac{7}{10} \pi n \right)$$', 'interpreter', 'latex')
%Part (f)
n = 0:length(data)-1;
y = filter(b, a, data, xi);

subplot(3, 2, 6)
stem(n, y, 'ms', 'MarkerFaceColor', 'm')
title('(f) Real Data')
xlabel('n')
ylabel('Response to Intel Stock Prices')
%/\----------------------------------------/\



%Function for Problem 2.83
%Making function plot the convolution of two DTS
%f1 is the first DTS
%f2 is the second DTS
%n1 is the first DTS's n
%n2 is the second DTS's n
%p is the problem number
function plotconv(f1, f2, p)
	%Find function n names
	%For some reason, inputname() doesn't work inside the function with eval() inputs
	global nx ny nz nw nf ng a b x y z w f g;
	n1 = eval(strcat('n', a(p)));
	n2 = eval(strcat('n', b(p)));
	%Convolve functions
	m = conv(f1, f2);
	%Combine ns
	n = union(n1, n2);
	%Extend n to match length of convolution result
	n = [n, n(length(n)):(length(m) + n(1) - 1)];
	%Make sure no repeated ns
	n = unique(n);
	%Set subplot number
	subplot(4, 3, p)
	%Plot convolution with corrected n
	stem(n, m, 'ms', 'MarkerFaceColor', 'm')
	%Display plot with correct title
	ttl = ['(' char('a' - 1 + p) ') m[n] = ' a(p) '[n] ∗ ' b(p) '[n]'];
	title(ttl)
	xlabel('n')
	ylabel('m[n]')
end