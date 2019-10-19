clear all;
close all;
clc;

%Valores Medidos no Lab1
Frequencia=[0.6 1.3 1.9 2.5 3.1 3.8 4.4 5 5.7 6.3 6.9 7.5 8.2 8.8 9.4 10.1 10.7 11.3 11.9 12.6 13.2 13.8 14.5 15.1]; %rad/s
phase = [-7 -14 -24 -30 -40 -52 -63 -75 -80 -92 -100 -112 -121 -127 -133 -135 -140 -142 -142 -145 -147 -149 -150 -150]; %graus
Magnitude = [-8.13 -8.13 -7.96 -7.62 -7.3 -6.99 -6.99 -7.3 -7.96 -8.67 -10.07 -11.23 -12.57 -13.48 -14.88 -16.09 -17.5 -18.03 -19.19 -19.83 -21.28 -22.11 -23.03 -24.05]; %dB

%Funcao de tranferencia encontrada no Lab2
k = 0.35;
xi = 0.54;
wn = 6.2;
G = k*(tf(wn^2,[1 2*xi*wn wn^2]));

%roots(G);
pole(G)
zero(G)
%rlocus(G)
 
%Plot Diagrama de Bode 
subplot(2,1,1);
semilogx(Frequencia,Magnitude,'o');
hold on
bodemag(G);
ylabel('Magnitude (dB)');
title('Diagrama Bode');
grid on;

h=bodeoptions;
h.Magvisible = 'off';
subplot(2,1,2);
bode(G,h);
grid on;
hold on
semilogx(Frequencia,phase,'o');
ylabel('Fase (deg)');
xlabel('Frequencia (Hz)');


%sisotool(G)