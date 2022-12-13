clc; % clear all; 
% test new_fft
Fc = 2000;
[x,Fs] = audioread('M0102012.wav');
N = length(x)-1;% length of signal
N=100;
x = x(10000:10000+N-1);
t=(1:N)./Fs; % time axis
f = Fs/2*linspace(0,1,max(t)*Fs/2); % frequency axis

%% calc. DFT
X = fft(x);
X = abs(X(1:N/2));
r=2;
% decimate
figure(1);
plot(0:N-1,x,'o'); hold on
y = decimate(x,r,'fir');
stem(0:r:N-1,y,'ro','filled','markersize',4)

legend('Original','Decimated','Location','south')
xlabel('Sample number')
ylabel('Signal')

%% calc. DFT
Y = fft(y);
Y = abs(Y(1:N/2));



%% plot spectrum
% figure(1);
% 
% plot(t,x,t,y); title('Signals'); grid on; legend x y;
figure(2);

plot(f,X); title('Spectrum x'); grid on; legend FFT(x) ;
figure(3);
plot(f,Y); title('Spectrum y'); grid on; legend FFT(y);

% player = audioplayer(x,Fs);
% play(player);