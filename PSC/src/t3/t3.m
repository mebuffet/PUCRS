close all

G = (1/20) * tf([1 62 600], [1 15.8 68 44.8 0])

Kv = 0.7 % kv atual
Er = 0.01 % erro rampa
Kvd = 1/Er % kv desejado
Kkv = Kvd / Kv % ganho necessario para atingir kvd

% nova função de transferencia é G(S)*Kkv
G2 = Kkv * G

% margem fase g2 = -180-(-221) = 41 graus (aonde corta 0db, ver fase)
% margem ganho g2 = 0-22.6 = -22.6 dB (aonde corta 180 graus, ver magnitude, estável por > 0)

Mp = 0.05 % Máximo sobressinal desejado
E = 0.7 % Fator de amortecimento desejado
Omd = 65 % Margem de fase desejada

Omd = Omd + 5

Om = -180 + Omd % fase frequencia de cruzamento
Wc = 0.25 %freq cruzamento w0db

%testar sem paranteses
Gjw = (1/20) * Kkv * ((((Wc^2)+(12^2))^0.5)*(((Wc^2)+(50^2))^0.5))/(((Wc^2)^0.5)*(((Wc^2)+(0.8^2))^0.5)*(((Wc^2)+(7^2))^0.5)*(((Wc^2)+(8^2))^0.5))

Kmp = 1 / Gjw

G3 = Kmp * G2

Kv = 0.25
Alpha = Kvd / Kv
Zat = Wc / 10
Pat = Zat / Alpha

Kat = Pat / Zat

C = Kat * tf([1 Zat], [1 Pat])

G4 = C * G2

%bode(G,G2,G3,G4)
bode(G,G2)
grid on;
%legend('G(s)','Kkv*G(s)','Kkv*Kmp*G(s)','Kkv*C(s)*G(s)');
legend('G(s)','Kkv*G(s)');

figure
s=tf([1 0],[0 1]);
%Fecha a malha com realimentac~ao igual a 1
T = feedback(G,1)
% Testa o sistema com um sinal a Rampa do sistema original
step(T/s,100)
hold
Tc = feedback(G4,1);
step(Tc/s,100)
plot([0 100],[0 100],'--k')
legend('G(s)','Kkv*C(s)*G(s)')

figure
%Fecha a malha com realimentac~ao igual a 1
T = feedback(G,1);
step(T,100)
hold
Tc = feedback(G4,1);
step(Tc,100)
legend('G(s)','Kkv*C(s)*G(s)')