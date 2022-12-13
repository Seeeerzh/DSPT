[z,p,k] = buttap(9);  
[b,a]=zp2tf(z, p, k);
figure(1);
freqs(b, a)
fs = 11025;

w= 500*2*pi;
[bt, at] = lp2lp(b,a,w);
[bz, az] = impinvar(bt,at,fs);

figure(2);
freqz(bz,az,1000,'whole',fs);
title('Magnitude');

figure(3);
impz(bz,az);
title('impulse response');
