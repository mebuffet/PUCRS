A = [0 1 0; 0 0 1; -22 -27 -33]
B = [0;0;14]
C = [1 0 0]
D = 0
I = eye(3,3);
syms S;
G = C * inv(S*I - A)*B + D
pretty(G)

[NUM,DEM] = ss2tf(A,B,C,D)
[A2,B2,C2,D2] = tf2ss([2,8,1],[1,16,12,19,2])