%Este script se ejecuta para mostrar los conceptos de muestreo en una señal.
%Se muestra una señal seno simulada despuí©s de haber sido muestreada.
%Se puede desfasar la señal, cambiar muestreo, desfase, ciclos a muestrear y
%la cantidad de bits de resolución

%La señal seno tiene un valor mí­nimo de 0 y un valor máximo de 2.

%Autor: Luis Alberto Chavarrí­a Zamora
%íšltima modificación: 28 de septiembre 2020

%Limpia la memoria, la consola y gráficos
clear
clc
close all

%Variables
%Muestreo n veces más rápido que la frecuencia de muestreo
n      = 8;
%Desfase en grados
phi    = 90;
%Níºmero de bits de resolución
bits   = 64;
%Ciclos
ciclos = 2;


%Simulación de señal analógica, en realidad es muestreada mil veces más rápido
%para emular como se visualiza una señal analógica traslapada.
muestras_seno  = linspace(phi*pi/180,2*pi*ciclos + phi*pi/180,n*ciclos*1000);
seno_analogico = sin(muestras_seno) + 1;

%Generación de señal "analógica" muestreada a n muestras por segundo
%Entrada de n muestras, se suma una y elimina para cumplir con muestreo
muestras           = linspace(phi*pi/180,2*pi*ciclos + phi*pi/180,n*ciclos + 1);
tamano             = size(muestras,2);
muestras([tamano]) = [];
tamano             = size(muestras,2);
%Salida de la operación seno
seno               = sin(muestras) + 1;

%Digitalización de la señal
%Máximo de la señal seno es 2 y mí­nimo es cero, cuando se suma uno
maximo       = 2;
minimo       = 0;
seno_digital = round(seno * 2 ^ bits / (maximo - minimo))-1;

%Graficación
subplot(2,1,1);
plot(muestras_seno,seno_analogico,'k');
hold on;
for i = 1:tamano
  muestra_actual = muestras(i);
  plot([muestra_actual],seno(i),'r*');
  plot([muestra_actual,muestra_actual],[seno(i),1],'b-');
endfor
plot([phi*pi/180 - 1 2*pi*ciclos + phi*pi/180 + 1],[1 1],'k');
axis([phi*pi/180 - 1 2*pi*ciclos + phi*pi/180 + 1]);
xlabel("Muestra en el tiempo");
ylabel("Valor continuo");
title("Muestreo de señal analógica");
grid minor;
hold off;
subplot(2,1,2);
hold on;
for i = 1:tamano
  muestra_actual = i - 1;
  if(seno_digital(i) == -1)
    seno_digital(i) = 0;
  endif
  plot([muestra_actual],seno_digital(i),'r*');
endfor
axis([-1 i -1 2^bits]);
xlabel("Muestra");
ylabel("Valor digital");
title("Señal en el entorno digital");
grid minor;