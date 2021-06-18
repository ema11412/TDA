clear
clc
pkg load signal

% Frecuencia de la señal de información.
f1  = 20;
f2  = 60;
% Frecuencia de la portadora o carrier
fc  = 5e3;
% Frecuencia de muestreo
fs  = fc * 20;
fs2 = fs / 2;

% Modula la señal con seno (señal 1) y coseno (señal 2) de la portadora
data_mod = sinetone(f1,fs,1,1).*sinetone(fc,fs,1,1) + ...
            sinetone(f2,fs,1,1).*cos(asin(sinetone(fc,fs,1,1)));

clf
figure(1)
plot(data_mod(:))
axis([0 fs/f1])

% Demodulación de la señal 1
demod_1 = data_mod.*sinetone(fc,fs,1,1);
% Demodulación de la señal 2
demod_2 = data_mod.*cos(asin(sinetone(fc,fs,1,1)));

% Filtro digital de 100 Hz
[b_1,a_1] = butter (1, 100 / fs2);
filtered1 = filter (b_1,a_1,demod_1);
filtered2 = filter (b_1,a_1,demod_2);

figure(2)
subplot(3,1,1)
plot(filtered1,";Mensaje 1;");
axis([0 2*fs/f1])
subplot(3,1,2)
plot(filtered2,";Mensaje 2;");
subplot(3,1,3)
plot(filtered2,";Mensaje 2 zoom;");
axis([0 2*fs/f2])