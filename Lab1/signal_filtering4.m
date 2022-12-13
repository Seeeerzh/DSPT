clc; % clear all; 
% test new_fft
[x,Fs] = audioread('M0102012.wav');
N = length(x)-1;% length of signal
x = x(1:N);
t=(1:N)./Fs; % time axis
f = Fs/2*linspace(0,1,max(t)*Fs/2); % frequency axis

%% calc. DFT
X = fft(x);
X = abs(X(1:N/2));

%% Apply Low Pass FIR filter
y1 = filter(Hd_LPF,x);
y2 = filter(Hd_Band,x);
y = y1 + y2;

%% calc. DFT
Y = fft(y); Y = abs(Y(1:N/2));
Y1 = fft(y1); Y1 = abs(Y1(1:N/2));
Y2 = fft(y2); Y2 = abs(Y2(1:N/2));

%% plot spectrum
figure(1);
subplot(3,1,1);
plot(t,x,t,y); title('Signals'); grid on; legend x y;
subplot(3,1,2);
plot(f,X,f,Y); title('Spectrum'); grid on; legend FFT(x) FFT(y);
subplot(3,1,3);
plot(f,Y1,f,Y2); title('Spectrum'); grid on; legend LOW BAND;
% player = audioplayer(x,Fs);
% play(player);