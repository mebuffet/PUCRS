%METODO 1
K = 0.2743 %valor final da onda
L = 0.85
T = 6.1 - L

%Controlador P
Kkp = T / L

%Controlador PID
Kkp = 1.2 * Kkp
Ti = 2 * L
Td = 0.5 * L

%METODO 2

G = tf([0.2],[1 2.7 2.43 0.729])
bode(G);
margin(G);

W0db = inf
W180 = 1.55
Om = inf
Gm = 0-(-29.3)

Kcrit = 10^(Gm/20)

Pcrit = (2*pi())/(W180)

Kp = 0.45 * Kcrit
Ti = (1/1.2) * Pcrit
Td = 0
