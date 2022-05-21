% Sonny Ji
% ECE314L Lab
% Homework #4
% Problems: 4.57, 4.64



clear()
%----------------Problem 4.57
%\/----------------------------------------\/
figure('Name', 'Problem 4.57', 'NumberTitle', 'off')

% Define n
n = -100:1:100;

% Define the function
x = zeros(1, length(n));
% n = 0 position
n0 = ceil(length(n) / 2);
x((n0 - 50):(n0 + 50)) = exp(-((0.1 .* n((n0 - 50):(n0 + 50))) .^ 2) ./ 2);

% Define Omega
O = linspace(-pi, pi, 500);

% Part (a)
% Calculate the DTFT of x
X = fft((2 * x), 500);

% Use fftshift to swap left and right halves of X
X = fftshift(X);

% Set tick label and text interpreter to LaTeX
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');

subplot(2, 3, 1)
stem(n, (2 * x), 'sr', 'MarkerFaceColor', 'r')
title(['Part (a) Signal Magnitude Plot'])
xlabel('$n$')
ylabel('$2 \cdot x \left( n \right)$')

subplot(2, 3, 2)
stem(O, abs(X), 'sm', 'MarkerFaceColor', 'm')
title('Part (a) Frequency Magnitude Plot')
xlabel('$\Omega$')
ylabel('$\left| X \left( e^{j \Omega} \right) \right|$')
xlim([-pi pi])
xticks(-pi:pi/2:pi)
xticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'})

subplot(2, 3, 3)
stem(O, angle(X), 'sm', 'MarkerFaceColor', 'm')
title('Part (a) Frequency Phase Plot')
xlabel('$\Omega$')
ylabel('$\angle X \left( e^{j \Omega} \right)$')
xlim([-pi pi])
xticks(-pi:pi/2:pi)
xticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'})

% Part (b)
% Calculate the DTFT of x
X = fft((4 * x), 500);

% Use fftshift to swap left and right halves of X
X = fftshift(X);

subplot(2, 3, 4)
stem(n, (4 * x), 'sr', 'MarkerFaceColor', 'r')
title(['Part (b) Signal Magnitude Plot'])
xlabel('$n$')
ylabel('$4 \cdot x \left( n \right)$')

subplot(2, 3, 5)
stem(O, abs(X), 'sm', 'MarkerFaceColor', 'm')
title('Part (b) Frequency Magnitude Plot')
xlabel('$\Omega$')
ylabel('$\left| X \left( e^{j \Omega} \right) \right|$')
xlim([-pi pi])
xticks(-pi:pi/2:pi)
xticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'})

subplot(2, 3, 6)
stem(O, angle(X), 'sm', 'MarkerFaceColor', 'm')
title('Part (b) Frequency Phase Plot')
xlabel('$\Omega$')
ylabel('$\angle X \left( e^{j \Omega} \right)$')
xlim([-pi pi])
xticks(-pi:pi/2:pi)
xticklabels({'$-\pi$', '$-\frac{\pi}{2}$', '$0$', '$\frac{\pi}{2}$', '$\pi$'})

% Unset tick label and text interpreter from LaTeX
set(groot, 'defaultAxesTickLabelInterpreter', 'none');
set(groot, 'defaultTextInterpreter', 'none');
%/\----------------------------------------/\



clear()
%----------------Problem 4.64
%\/----------------------------------------\/
figure('Name', 'Problem 4.64', 'NumberTitle', 'off')

% Set tick label and text interpreter to LaTeX
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');

% Define variables
% delta time
tt = 0;
% delta omega for FT
ot = 0;
% time
t = 0:tt:1;
% omega a
oa = 0;
% omega r
or = 0;
% Delta omega
do = 0;
% omega
o = -oa:do:oa;
% omega for FT
o0 = -oa:ot:oa;

% Part (a)
% The FT of a rectangular pulse function is sinc(o / 2)
tt = 0.01;
ot = 0.05;
t = -2:tt:2;
oa = 3 * pi / 2;
or = 3 * pi / 4;
do = pi / 8;
o = -oa:do:oa;
o0 = -oa:ot:oa;

% The actual function
x = zeros(1, length(t));
t0 = ceil(length(t) / 2);
x((t0 - (1 / tt)):(t0 + (1 / tt))) = 1;

% The FT
X = fft(x);
X = fftshift(X);
X = X((ceil(length(X) / 2) - (oa / ot)):(ceil(length(X) / 2) + (oa / ot)));

% The DTFS approximation
% Upper bound
ub = floor(oa / do) * do;
% Shaved min adding do till "zero" of X
% "Zero" of X adding do till shaved max
X1 = [X((ceil(length(X) / 2) - ceil(ub / ot) + 1):(ceil(do / ot) + 1):((ceil(length(X) / 2) + 1))) X((ceil(length(X) / 2) + 1):floor(do / ot):(ceil(length(X) / 2) + floor(ub / ot)))];
X1 = fix(X1 ./ or) .* or;

% Print outputs
sprintf('For part (a), the sampling interval T_s is %.2f.', (1 / do))
sprintf('For part (a), the number of samples M is  %.2f.', (length(X1)))
sprintf('For part (a), the DTFS length N is  %.2f.', (ub + ub))

subplot(4, 5, 1)
plot(t, x, 'r')
title(['Part (a) Signal Magnitude Plot'])
xlabel('$t$')
ylabel('rect$\left( t \right)$')

subplot(4, 5, 2)
plot(o0, abs(X), 'm')
title(['Part (a) FT Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|$' 'sinc' '$\left( \frac{\omega}{2} \right) | $'])

subplot(4, 5, 3)
plot(o0, angle(X), 'm')
title(['Part (a) FT Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle$sinc$\left( \frac{\omega}{2} \right)$')

subplot(4, 5, 4)
stem(o, abs(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (a) DTFS Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|$' 'sinc' '$\left( \frac{\omega}{2} \right) | $'])

subplot(4, 5, 5)
stem(o, angle(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (a) DTFS Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle$sinc$\left( \frac{\omega}{2} \right)$')

% Part (b)
% The FT of the function is \frac{\sqrt{2 \pi}}{2 \pi} e^{-\frac{\omega^2}{2}}
tt = 0.001;
ot = 0.002;
t = -2:tt:2;
oa = 3;
or = 1 / 2;
do = 1 / 8;
o = -oa:do:oa;
o0 = -oa:ot:oa;

% The actual function
x = (1 / (2 * pi)) * exp(-(t.^2) ./ 2);

% The FT
X = fft(x);
X = fftshift(X);
X = X((ceil(length(X) / 2) - (oa / ot)):(ceil(length(X) / 2) + (oa / ot)));

% The DTFS approximation
% Upper bound
ub = floor(oa / do) * do;
% Shaved min adding do till "zero" of X
% "Zero" of X adding do till shaved max
X1 = [X((ceil(length(X) / 2) - ceil(ub / ot) + 1):(ceil(do / ot) + 1):((ceil(length(X) / 2) + 1))) X((ceil(length(X) / 2) + 1):floor(do / ot):(ceil(length(X) / 2) + floor(ub / ot)))];
X1 = fix(X1 ./ or) .* or;

% Print outputs
sprintf('For part (b), the sampling interval T_s is %.2f.', (1 / do))
sprintf('For part (b), the number of samples M is  %.2f.', (length(X1)))
sprintf('For part (b), the DTFS length N is  %.2f.', (ub + ub))

subplot(4, 5, 6)
plot(t, x, 'r')
title(['Part (b) Signal Magnitude Plot'])
xlabel('$t$')
ylabel('$\frac{1}{2 \pi} e^{-\frac{t^2}{2}}$')

subplot(4, 5, 7)
plot(o0, abs(X), 'm')
title(['Part (b) FT Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|\frac{\sqrt{2 \pi}}{2 \pi} e^{-\frac{\omega^2}{2}}|$'])

subplot(4, 5, 8)
plot(o0, angle(X), 'm')
title(['Part (b) FT Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle\frac{\sqrt{2 \pi}}{2 \pi} e^{-\frac{\omega^2}{2}}$')

subplot(4, 5, 9)
stem(o, abs(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (b) DTFS Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|\frac{\sqrt{2 \pi}}{2 \pi} e^{-\frac{\omega^2}{2}}|$'])

subplot(4, 5, 10)
stem(o, angle(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (b) DTFS Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle\frac{\sqrt{2 \pi}}{2 \pi} e^{-\frac{\omega^2}{2}}$')

% Part (c)
% The FT of the function is \pi(\delta(\omega \pm 20) + \delta(\omega \pm 21)))
tt = 0.00001;
ot = 0.0002;
t = -100:tt:100;
oa = 40 * pi;
or = pi / 3;
do = pi / 10;
o = -oa:do:oa;
o0 = -oa:ot:oa;

% The actual function
x = cos(20 * pi * t) + cos(21 * pi * t);

% The FT
X = fft(x);
X = fftshift(X);
X = X((ceil(length(X) / 2) - (oa / ot)):(ceil(length(X) / 2) + (oa / ot)));

% The DTFS approximation
% Upper bound
ub = floor(oa / do) * do;
% Shaved min adding do till "zero" of X
% "Zero" of X adding do till shaved max
X1 = [X((ceil(length(X) / 2) - ceil(ub / ot) + 1):(ceil(do / ot) + 1):((ceil(length(X) / 2) + 1))) X((ceil(length(X) / 2) + 1):floor(do / ot):(ceil(length(X) / 2) + floor(ub / ot)))];
X1 = fix(X1 ./ or) .* or;

% Print outputs
sprintf('For part (c), the sampling interval T_s is %.2f.', (1 / do))
sprintf('For part (c), the number of samples M is  %.2f.', (length(X1)))
sprintf('For part (c), the DTFS length N is  %.2f.', (ub + ub))

subplot(4, 5, 11)
plot(t, x, 'r')
title(['Part (c) Signal Magnitude Plot'])
xlabel('$t$')
ylabel('$\cos ( 20 \pi t ) + \cos ( 21 \pi t )$')
xlim([-pi pi])

subplot(4, 5, 12)
plot(o0, abs(X), 'm')
title(['Part (c) FT Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))|$'])

subplot(4, 5, 13)
plot(o0, angle(X), 'm')
title(['Part (c) FT Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))$')

subplot(4, 5, 14)
stem(o, abs(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (c) DTFS Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))|$'])

subplot(4, 5, 15)
stem(o, angle(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (c) DTFS Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))$')

% Part (d)
% The FT of the function is the same as part (c)
tt = 0.00001;
ot = 0.0002;
t = -100:tt:100;
oa = 40 * pi;
or = pi / 10;
do = pi / 10;
o = -oa:do:oa;
o0 = -oa:ot:oa;

% The actual function
x = cos(20 * pi * t) + cos(21 * pi * t);

% The FT
X = fft(x);
X = fftshift(X);
X = X((ceil(length(X) / 2) - (oa / ot)):(ceil(length(X) / 2) + (oa / ot)));

% The DTFS approximation
% Upper bound
ub = floor(oa / do) * do;
% Shaved min adding do till "zero" of X
% "Zero" of X adding do till shaved max
X1 = [X((ceil(length(X) / 2) - ceil(ub / ot) + 1):(ceil(do / ot) + 1):((ceil(length(X) / 2) + 1))) X((ceil(length(X) / 2) + 1):floor(do / ot):(ceil(length(X) / 2) + floor(ub / ot)))];
X1 = fix(X1 ./ or) .* or;

% Print outputs
sprintf('For part (d), the sampling interval T_s is %.2f.', (1 / do))
sprintf('For part (d), the number of samples M is  %.2f.', (length(X1)))
sprintf('For part (d), the DTFS length N is  %.2f.', (ub + ub))

subplot(4, 5, 16)
plot(t, x, 'r')
title(['Part (d) Signal Magnitude Plot'])
xlabel('$t$')
ylabel('$\cos ( 20 \pi t ) + \cos ( 21 \pi t )$')
xlim([-pi pi])

subplot(4, 5, 17)
plot(o0, abs(X), 'm')
title(['Part (d) FT Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))|$'])

subplot(4, 5, 18)
plot(o0, angle(X), 'm')
title(['Part (d) FT Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))$')

subplot(4, 5, 19)
stem(o, abs(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (d) DTFS Magnitude Plot'])
xlabel('$\omega$')
ylabel(['$|\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))|$'])

subplot(4, 5, 20)
stem(o, angle(X1), 'sm', 'MarkerFaceColor', 'm')
title(['Part (d) DTFS Phase Plot'])
xlabel('$\omega$')
ylabel('$\angle\pi(\delta(\omega \pm 20) + \delta(\omega \pm 21))$')

% Unset tick label and text interpreter from LaTeX
set(groot, 'defaultAxesTickLabelInterpreter', 'none');
set(groot, 'defaultTextInterpreter', 'none');
%/\----------------------------------------/\