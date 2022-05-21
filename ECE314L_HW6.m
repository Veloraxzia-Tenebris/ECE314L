% Sonny Ji
% ECE314L Lab
% Homework #6
% Problems: 5.52, 5.53



%----------------Problem 5.52
%\/----------------------------------------\/
figure('Name', 'Problem 5.52', 'NumberTitle', 'off')

% Constants
f = 1000;
fc = 20000;
mu = 0.75;

% Sampling
Ts = 0.0001 / 100;
os = (2 * pi) / Ts;

% Period and omega
T = 1 / f;
Tc = 1 / fc;
o = (2 * pi) / T;
oc = (2 * pi) / Tc;

% Time
t = [0:Ts:(Ts * 10000)];

% AM Signal
y = (1 + mu * cos(o * t)) .* cos(oc * t);

% FFT
Y = abs(fftshift(fft(y, ceil(os))));
O = [-(length(Y) / 2):(length(Y) / 2)-1];

% Plotting
subplot(2, 1, 1)
plot(t, y, 'm')
title('AM wave')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 0.003])
subplot(2, 1, 2)
plot(O, Y, 'r')
title('Frequency')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
xlim([100000 150000])
%/\----------------------------------------/\

clear

%----------------Problem 5.53
%\/----------------------------------------\/
figure('Name', 'Problem 5.53', 'NumberTitle', 'off')
% (a)
f = 1;
T = 1 / f;
o = (2 * pi) / T;

% Sampling and time
Ts = 0.0001;
t = [0:Ts:1000-Ts];

% Signal for placement of triangles
x1 = zeros(1, length(t));
for i = [0:1:999]
	x1(((i) / Ts) + 1) = 1;
	x1(((i + 0.5) / Ts) + 1) = -1;
end

% Single triangle pulse signal
x2 = tripuls([-1:Ts:1]);

% Convolution of signals
x = conv(x1, x2);

% Adjustment of convolved signal
x = x([(2 + 2 / Ts):(997 / Ts)]);
t = t([1:1:length(x)]);

% (b)
% Constants
fc = 25;
mu = 0.80;

% Sampling
os = (2 * pi) / Ts;

% Period and omega
Tc = 1 / fc;
o = (2 * pi) / T;
oc = (2 * pi) / Tc;

% AM Signal
y = (1 + mu .* x) .* cos(oc * t);

% FFT
Y = abs(fftshift(fft(y, ceil(os))));
O = [-(length(Y) / 2):(length(Y) / 2)-1];

% Plotting
subplot(2, 1, 1)
plot(t, y, 'm')
title('AM wave')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 3])
subplot(2, 1, 2)
plot(O, Y, 'r')
title('Frequency')
xlabel('Frequency (rad/s)')
ylabel('Magnitude')
xlim([0 300])
%/\----------------------------------------/\