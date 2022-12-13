fs = 10000;
t = 0:1/fs:0.1;
x = sin(2*pi*50*t);
y = modulate(x,2000,fs,'am');
y = y + randn(size(y))/10;

% pwelch([x;y]',hamming(100),80,1024,fs,'centered');
figure(1);
plot(x);
figure(2);
plot(y);
y1 = demod(y,2000,fs,'am');
figure(3);
plot(y1);