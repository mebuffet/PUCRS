library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity TF is
	port (
		A : in STD_LOGIC;
		B : in STD_LOGIC;
		C : in STD_LOGIC;
		D : in STD_LOGIC;
		F : out STD_LOGIC
	);
end;

architecture TF of TF is

--Declarando o inversor
component inv
	port (
		A : in STD_LOGIC;
		Z : out STD_LOGIC
	);
end component;

--Declarando a nand da biblioteca
component Complex_f2
	port (
		A : in STD_LOGIC;
		B : in STD_LOGIC;
		C : in STD_LOGIC;
		D : in STD_LOGIC;
		S : out STD_LOGIC
	);
end component;

signal not_a : STD_LOGIC;
signal not_b : STD_LOGIC;
signal not_c : STD_LOGIC;
signal not_d : STD_LOGIC;
signal not_f : STD_LOGIC;

begin

	inv1 : inv port map(A, not_a);
	inv2 : inv port map(B, not_b);
	inv3 : inv port map(C, not_c);
	inv4 : inv port map(D, not_d);
	inv5 : inv port map(not_f, F);
	mx : Complex_f2 port map(not_a, not_b, not_c, not_d, not_f);

end; 
