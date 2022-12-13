clc;
%% part A -> design a filter, export to workspace "Hd" object or "b" coefficients
Fs = 11024; % set this frequency in filter designer
%% part C -> 
y = impz(b,1); % Impulse response of digital filter
figure(1); plot(y); title('Impulse response');

% x = abs(freqz(Hd)); % Frequency response of digital filter
[h,w] = freqz(b,1,'whole',Fs);
h = abs(h(1:Fs/2));
f = (w(1:Fs/2)./pi)*Fs/2; % norm frequency axis to Fs
figure(2); plot(f,h); grid on; title('Frequency response');

x = abs(fft(b));
x = x(1:length(b)/2);
figure(3); plot(x); title('fft(b)');