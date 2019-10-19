A1 = [-4 8; 3 5]
B1 = [1; 0]
C1 = [1 2]
D1 = 0;
A2 = [0 0 0 1; 0 0 4 2; 4 3 0 0; 6 0 0 12]
B2 = [0; 2; 0; 0]
C2 = [3 3 5 6]
D2 = 0;

ob1 = obsv(A1,C1)
ct1 = ctrb(A1,B1)

ob2 = obsv(A2,C2)
ct2 = ctrb(A2,B2)

rank_ob1 = rank(ob1)
rank_ct1 = rank(ct1)

rank_ob2 = rank(ob2)
rank_ct2 = rank(ct2)

%K = place(A1,B1,[-6;-5])
