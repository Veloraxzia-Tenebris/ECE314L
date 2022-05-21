% Sonny Ji
% ECE314L
% Homework #1
% Problems: 1.93, 1.94


%Making first plot window
figure('Name', 'Problem 1.93', 'NumberTitle', 'off')



%----------------Problem 1.93
%\/----------------------------------------\/
%Make default t variable
t1 = 0:0.01:5;
%1.93 functions for parts (a) and (b)
xt1a = 10*exp(-t1) - 5*exp(-0.5*t1);
xt1b = 10*exp(-t1) + 5*exp(-0.5*t1);
%Sectioning out and plotting subplot for (a)
subplot(2, 1, 1)
plot(t1, xt1a, "m")
xlabel('t')
ylabel('x(t)')
title('Part (a)')
%Sectioning out and plotting subplot for (b)
subplot(2, 1, 2)
plot(t1, xt1b, "m")
xlabel('t')
ylabel('x(t)')
title('Part (b)')
%/\----------------------------------------/\



%Making second plot window
figure('Name', 'Problem 1.94', 'NumberTitle', 'off')



%----------------Problem 1.94
%\/----------------------------------------\/
%Make default t variable
t2 = -2:0.001:2;
%Make and set first a variable
a = [500, 750, 1000];
%Sectioning out and plotting subplot for different a
for i = 1:length(a)
    %x(t) from 1.94
    xt2 = 20*sin(((2*pi) * (1000*t2)) - (pi/3)).*exp(-a(i)*t2);
    subplot(3, 1, i)
    plot(t2, xt2, "m")
    %Zoom in to interesting part of plot
    xlim([0, 0.03])
    ylim([-0.05, 0.05])
    xlabel('t (sec)')
    ylabel('x(t)')
    title(sprintf('a = %d ', a(i)))
end
%Print investigation of affect
sprintf('The plots are zoomed in because it would be difficut to see the changes otherwise')
sprintf('As \''a\'' increases, x(t) gets steeper and approaches x(t)=0 faster.')
sprintf('Since x(t) is sampled per millisecond, the plot also loses the oscillatory motion.')
%/\----------------------------------------/\