% Sonny Ji
% ECE314L Lab
% Homework #5
% Problems: Handout 1, 2



clear()
%----------------Problem 1
%\/----------------------------------------\/
figure('Name', 'Problem 1', 'NumberTitle', 'off')

% Make triangle function
Fs = 10000;
T_p = 1/Fs;
t = 0:T_p:0.25;
x = zeros(1, length(t));
x(1:1000) = transpose(triang(1000));

% Plot triangle function
subplot(3, 2, 1)
area(t, x, 'FaceColor', 'm')
title('Triangle Function')
xlabel('t')
ylabel('x(t)')

% Make backward difference
diff = x(2:end) - x(1:end-1);

% Plot backward difference
subplot(3, 2, 2)
area(t(1:end-1), diff, 'FaceColor', 'm')
title('Triangle Function Backward Difference')
xlabel('t')
ylabel('diff(x(t))')

% DFT of triangular function
X = fft(x);
X = abs(X);
X = fftshift(X);
% Period, k, and Omega_o
N = length(t);
k = 0:N-1;
Oo = 2*pi/N;
X = X(ceil(length(X)/2):end);

% Plot of DFT
subplot(3, 2, 3)
stem(k(1:1000), X(1:1000), 'm', 'MarkerSize', 1)
xlim([0 100])
title('Triangle Function DFT')
xlabel('k')
ylabel('X[k]')

% Create DTF{x(t)} * (1 - e^(-jo))
shift = 1 - exp(-1j*k*Oo);
X1 = shift .* fft(x);

% Plot shifted DFT
subplot(3, 2, 4)
stem(k, abs(X1), 'm', 'MarkerSize', 1)
xlim([0 100])
title('Triangle Function Backward Difference DFT')
xlabel('k')
ylabel('DFT{diff(x(t))}')

% Create backward difference of DFT
Diff = X(2:end) - X(1:end-1);

% Plot backward difference of DFT
subplot(3, 2, 6)
stem(k(1:floor((end-1)/2)), abs(Diff), 'm', 'MarkerSize', 1)
xlim([0 100])
title('Triangle Function DFT Backward Difference')
xlabel('k')
ylabel('diff(DFT{x(t)})')
%/\----------------------------------------/\



clear()
%----------------Problem 2
%\/----------------------------------------\/
figure('Name', 'Problem 2', 'NumberTitle', 'off')

% Set function parameters
Fs = 10000;
T_p = 1/Fs;
t = -10:T_p:10;

% Make signals
x = sinc(100 * t);
y = sin(100 * t);
z = x .* y;

% Plot functions
subplot(3, 3, 1)
area(t, x, 'FaceColor', 'm')
title('sinc Function')
xlim([-0.25 0.25])
xlabel('t')
ylabel('x(t)')
subplot(3, 3, 2)
area(t, y, 'FaceColor', 'm')
title('sin Function')
xlim([-0.25 0.25])
xlabel('t')
ylabel('y(t)')
subplot(3, 3, 3)
area(t, z, 'FaceColor', 'm')
title('sinc * sin Function')
xlim([-0.25 0.25])
xlabel('t')
ylabel('z(t)')

% Make a linear frequence space for o = omega
L = length(t);
o = linspace(-1, 1, L) * Fs / 2;

% Take FT of signals
X = fftshift(fft(x ,L));
Y = fftshift(fft(y ,L));
Z = conv(X ,Y, 'same');
X = abs(X);
Y = abs(Y);

% Plot FTs
subplot(3, 3, 4)
plot(o, X, 'm')
title('sinc Function FT')
xlim([-500 500])
xlabel('\omega')
ylabel('X(j\omega)')
subplot(3, 3, 5)
plot(o, Y, 'm')
title('sin Function FT')
xlim([-500 500])
xlabel('\omega')
ylabel('Y(j\omega)')
subplot(3, 3, 6)
plot(o, abs(Z), 'm')
title('sinc * sin Function FT')
xlim([-500 500])
xlabel('\omega')
ylabel('Z(j\omega)')

% Take inverse FT of Z
z1 = ifft(ifftshift(Z / L), L, 'symmetric');

% Plot z
subplot(3, 1, 3)
plot(t, z1, 'm')
title('sinc * sin Function Reconstructed From X and Y')
xlim([-0.25 0.25])
xlabel('t')
ylabel('z(t)')
%/\----------------------------------------/\