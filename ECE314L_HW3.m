% Sonny Ji
% ECE314L Lab
% Homework #3
% Problems: 3.103, 3.104


clear()
%----------------Problem 3.103
%\/----------------------------------------\/
figure('Name', 'Problem 3.103', 'NumberTitle', 'off')

%Making n vector
n = 0:1:201;
nn = length(n);

%Part (a)
x1a = cos((n * 6 * pi / 17) + (pi / 3));
%Part (b)
x1b = 2 * sin(n * 14 * pi / 19) + cos(n * 10 * pi /19) + 1;
%Part (c)
%x1c1 = symsum(((-1) ^ m) * (kroneckerDelta(n, sym(2 * m)) + kroneckerDelta(n, sym(3 * m))), m, -Inf, Inf);
%For loop signal creation, since symsum doesn't work
x1c = zeros(1, nn);
for i = 1:floor(nn / 2)
	x1c(2 * i) = x1c(2 * i) + (-1)^(i - 1);
end
for i = 1:floor(nn / 3)
	x1c(3 * i) = x1c(3 * i) + (-1)^(i - 1);
end
%Part (d)
x1d1 = [0 0 1 0 0 0 -1 0];
x1d = x1d1;
while length(x1d) < nn
	x1d = [x1d x1d1];
end
x1d = x1d(1:nn);
%Part (e)
x1e1 = [0 0 0 0 0 0 1/4 2/4 3/4 1];
x1e = x1e1;
while length(x1e) < nn
	x1e = [x1e x1e1];
end
x1e = x1e(1:nn);

%Adjusting fourier series frequency vector
ff = nn / 2;
f = (0:ff) / nn;

%Ploting all parts
for i = 1:5
	%Make in-loop function vector
	temp = eval(strcat('x1', char(i + 96)));
	%FFT
	X1 = fft(temp);
	%Get real values
	X1 = abs(X1);
	%Only taking the base frequency graph without repeats
	X1 = X1(1:(ff + 1));

	%Graph everything
	subplot(5, 2, ((i * 2) - 1))
	stem(n(1:51), temp(1:51), 'sm', 'MarkerFaceColor', 'm')
	title(['Part (' char(i + 96) ') Function Plot'])
	xlabel('n')
	ylabel('x[n]')

	subplot(5, 2, (i * 2))
	stem(f, X1, 'sr', 'MarkerFaceColor', 'r')
	title(['Part (' char(i + 96) ') Frequency Plot'])
	xlabel('k')
	ylabel('X[k]')
end
%/\----------------------------------------/\



%----------------Problem 3.104
%\/----------------------------------------\/
figure('Name', 'Problem 3.104', 'NumberTitle', 'off')

%Making k vector
k = 0:1:101;
kk = length(k);

%Part (a)
X2a = cos(k * 8 * pi / 21);
Na = 21;
%Part (b)
X2b = cos(k * 10 * pi / 19) + (1j * 2 * sin(k * 4 * pi / 19));
Nb = 19;
%Part (c)
X2c = zeros(1, kk);
for i = 1:floor(kk / 2)
	X2c(2 * i) = X2c(2 * i) + (-1)^(i - 1);
end
for i = (-floor(kk / 3)):(-1)
	X2c(-(3 * i)) = X2c(-(3 * i)) - (2 * (-1)^(i + 1));
end
%Graphically, N is 12
Nc = 12;
%Part (d)
X2d1 = [0 0 0 1 1 0 0];
X2d2 = [0 0 0 pi/2 -pi/2 0 0];
X2d1 = X2d1 .* exp(1j * X2d2 * 2 * pi / 3);
X2d = X2d1;
while length(X2d) < kk
	X2d = [X2d X2d1];
end
X2d = X2d(1:kk);
Nd = 7;
%Part (e)
X2e1 = [-1/2 1 0 0 0 0 1];
X2e = complex(X2e1, 0);
while length(X2e) < kk
	X2e = [X2e X2e1];
end
X2e = X2e(1:kk);
Ne = 7;
%Part (f)
X2f1 = [1 1 1 1 1 0 0 0 0 0 0 1 1 1 1];
X2f2 = [0 -1/4 -1/2 -3/4 -1 0 0 0 0 0 0 1 3/4 1/2 1/4];
X2f1 = X2f1 .* exp(1j * X2f2 * 2 * pi / 3);
X2f = X2f1;
while length(X2f) < kk
	X2f = [X2f X2f1];
end
X2f = X2f(1:kk);
Nf = 15;

for i = 1:6
	k = 0;
	kk = 0;
	temp1 = 0;
	temp2 = 0;
	x2 = 0;
	%Make in-loop function vector
	temp1 = eval(strcat('X2', char(i + 96)));
	temp2 = eval(strcat('N', char(i + 96)));

	%Resizing vectors
	k = 0:1:(temp2 - 1);
	kk = length(k);
	temp1 = temp1(1:length(k));

	%IFFT
	x2 = ifft(temp1);
	x2 = x2 * temp2;

	%Make things look nice
	k = [k kk:1:((2 * temp2) - 1)];
	temp1 = [temp1 temp1];
	x2 = [x2 x2];
	kk = 2 * kk;

	%Graph everything
	subplot(6, 4, ((i * 4) - 3))
	stem(k, abs(temp1(1:kk)), 'sr', 'MarkerFaceColor', 'r')
	title(['Part (' char(i + 96) ') Frequency Plot Magnitude'])
	xlabel('k')
	ylabel('|X[k]|')

	subplot(6, 4, ((i * 4) - 1))
	stem(k, abs(x2(1:kk)), 'sm', 'MarkerFaceColor', 'm')
	title(['Part (' char(i + 96) ') Function Plot Magnitude'])
	xlabel('n')
	ylabel('|x[n]|')

	subplot(6, 4, ((i * 4) - 2))
	stem(k, angle(temp1(1:kk)), 'sr', 'MarkerFaceColor', 'r')
	title(['Part (' char(i + 96) ') Frequency Plot Phase'])
	xlabel('k')
	ylabel('arg{X[k]}')

	subplot(6, 4, (i * 4))
	stem(k, angle(x2(1:kk)), 'sm', 'MarkerFaceColor', 'm')
	title(['Part (' char(i + 96) ') Function Plot Phase'])
	xlabel('n')
	ylabel('arg{x[n]}')
end
%/\----------------------------------------/\