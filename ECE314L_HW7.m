% Sonny Ji
% ECE314L Lab
% Homework #7
% Problems: 7.55, 8.42, 8.46



%----------------Problem 7.55
%\/----------------------------------------\/
% 7.24 (d)-(g)
figure('Name', 'Problem 7.55', 'NumberTitle', 'off')
set(gca,'visible','off')


% (d)
% (1 - 3z^-1) z^2
% (1 + 3/2 z^-1 - z^-2) z^2
b = [1 -3];
a = [1 3/2 -1];
[r, p, k] = residuez(b, a);

% Formatting
out = "\left( d \right)";
for i = [1 length(r)]
	temp2 = "-" + p(i);
	if p(i) < 0
		temp2 = "+";
		p(i) = (-1) * p(i);
		temp2 = temp2 + p(i);
	end
	if p(i) == 1
		temp2 = "-";
	end
	temp = "\frac{" + r(i) + "}{1 " + temp2 + "z^{-1}}";
	out = out + "+" + temp;
end
if length(k) > 0
	out = out + "+" + k(1);
end
out = convertStringsToChars(out);
out(17) = '';
out = convertCharsToStrings(out);

% Printing
out = "$" + out + "$";
out = convertStringsToChars(out);
text(0.5, 0.9, out, 'Interpreter', 'latex', 'FontSize', 24, 'HorizontalAlignment', 'center')


% (e)
% (3 - 1/4 z^-1) z^2
% (1 - 16 z^-2) z^2
b = [3 -1/4];
a = [1 0 -16];
[r, p, k] = residuez(b, a);

% Formatting
out = "\left( e \right)";
for i = [1 length(r)]
	temp2 = "-" + p(i);
	if p(i) < 0
		temp2 = "+";
		p(i) = (-1) * p(i);
		temp2 = temp2 + p(i);
	end
	if p(i) == 1
		temp2 = "-";
	end
	temp = "\frac{" + r(i) + "}{1 " + temp2 + "z^{-1}}";
	out = out + "+" + temp;
end
if length(k) > 0
	out = out + "+" + k(1);
end
out = convertStringsToChars(out);
out(17) = '';
out = convertCharsToStrings(out);

% Printing
out = "$" + out + "$";
out = convertStringsToChars(out);
text(0.5, 0.7, out, 'Interpreter', 'latex', 'FontSize', 24, 'HorizontalAlignment', 'center')


% (f)
% (1 + z^-1 + 3/2 z^-2 + 1/2 z^-3) z^3
% (1 + 3/2 z^-1 + 1/2 z^-2) z^3
b = [1 1 3/2 1/2];
a = [1 3/2 1/2];
[r, p, k] = residuez(b, a);

% Formatting
out = "\left( f \right)";
for i = [1 length(r)]
	temp2 = "-" + p(i);
	if p(i) < 0
		temp2 = "+";
		p(i) = (-1) * p(i);
		temp2 = temp2 + p(i);
	end
	if p(i) == 1
		temp2 = "-";
	end
	temp = "\frac{" + r(i) + "}{1 " + temp2 + "z^{-1}}";
	out = out + "+" + temp;
end
if length(k) > 0
	for i = [1 length(k)]
		if k(i) ~= 0
			if k(i) == 1
				temp3 = "+";
			elseif k(i) == -1
				temp3 = "-";
			else
				temp3 = "+" + k(i) + "\cdot ";
			end
			out = out + temp3 + "z^{-" + (i - 1) + "}";
		end
	end
end
out = convertStringsToChars(out);
out(17) = '';
out = convertCharsToStrings(out);

% Printing
out = "$" + out + "$";
out = convertStringsToChars(out);
text(0.5, 0.5, out, 'Interpreter', 'latex', 'FontSize', 24, 'HorizontalAlignment', 'center')


% (g)
% (2 - 2 z^-1 - 2 z^-2) z^4
% (1 - z^-2) z^2
% z^-2 * (out)
b = [2 -2 -2 0 0];
a = [1 0 -1];
c = 2;
[r, p, k] = residuez(b, a);

% Formatting
out = "";
for i = [1 length(r)]
	temp2 = "-" + p(i);
	if p(i) < 0
		temp2 = "+";
		p(i) = (-1) * p(i);
		temp2 = temp2 + p(i);
	end
	if p(i) == 1
		temp2 = "-";
	end
	temp = "\frac{" + r(i) + "}{1 " + temp2 + "z^{-1}}";
	out = out + "+" + temp;
end
if length(k) > 0
	if k(1) ~= 0
		out = out + "+" + k(1);
	end
	if length(k) > 1
		for i = [2 length(k)]
			if k(i) ~= 0
				if k(i) == 1
					temp3 = "+";
				elseif k(i) == -1
					temp3 = "-";
				else
					temp3 = "+" + k(i) + "\cdot ";
				end
				out = out + temp3 + "z^{-" + (i - 1) + "}";
			end
		end
	end
end
out = convertStringsToChars(out);
out(1) = '';
out = convertCharsToStrings(out);

% Printing
out = "$\left( g \right) z^{-2} \cdot \left(" + out + "\right)$";
out = convertStringsToChars(out);
text(0.5, 0.3, out, 'Interpreter', 'latex', 'FontSize', 24, 'HorizontalAlignment', 'center')
%/\----------------------------------------/\

clear

%----------------Problem 8.42
%\/----------------------------------------\/
figure('Name', 'Problem 8.42', 'NumberTitle', 'off')
wc = pi / 3;
Ts = 15;
h = fir1(22, 1/3, 'low');


% (a)
subplot(2, 1, 1)
plot(h)
xlabel('Time (s)')
ylabel('Amplitude')
title('Impulse Response')


% (b)
subplot(2, 1, 2)
[H, w] = freqz(h, 1, 1000, (1 / Ts));
plot(w, abs(H))
xlabel('Frequency (rad)')
ylabel('Magnitude')
title('Magnitude Response')
%/\----------------------------------------/\

clear

%----------------Problem 8.46
%\/----------------------------------------\/
figure('Name', 'Problem 8.46', 'NumberTitle', 'off')
w = [0:0.001:pi];
H = 1 ./ (1 + j * w / pi) .^ 2;

subplot(2, 1, 1)
plot(w, abs(H))
xlabel('Frequency (rad)')
ylabel('Magnitude')
title('Butterworth Magnitude Response')

h = fir1(94, 1/3, 'low');
H = freqz(h, 1, w);

subplot(2, 1, 2)
plot(w, abs(H))
xlabel('Frequency (rad)')
ylabel('Magnitude')
title('FIR Filter Magnitude Response')
%/\----------------------------------------/\