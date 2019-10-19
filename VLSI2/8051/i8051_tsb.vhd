--
-- Copyright (c) 1999 Tony Givargis.  Permission to copy is granted
-- provided that this header remains intact.  This software is provided
-- with no warranties.
--
-- Version : 2.4
--

-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

-------------------------------------------------------------------------------

entity I8051_TSB is
end I8051_TSB;

-------------------------------------------------------------------------------

architecture BHV of I8051_TSB is

    component I8051_ALL
        port(rst    : in  STD_LOGIC;
             clk    : in  STD_LOGIC;
             p0_in  : in  UNSIGNED (7 downto 0);
             p0_out : out UNSIGNED (7 downto 0);
             p1_in  : in  UNSIGNED (7 downto 0);
             p1_out : out UNSIGNED (7 downto 0);
             p2_in  : in  UNSIGNED (7 downto 0);
             p2_out : out UNSIGNED (7 downto 0);
             p3_in  : in  UNSIGNED (7 downto 0);
             p3_out : out UNSIGNED (7 downto 0));
    end component;

    signal rst    : STD_LOGIC := '1';
    signal clk    : STD_LOGIC := '0';
    signal p0_in  : UNSIGNED (7 downto 0);
    signal p0_out : UNSIGNED (7 downto 0);
    signal p1_in  : UNSIGNED (7 downto 0);
    signal p1_out : UNSIGNED (7 downto 0);
    signal p2_in  : UNSIGNED (7 downto 0);
    signal p2_out : UNSIGNED (7 downto 0);
    signal p3_in  : UNSIGNED (7 downto 0);
    signal p3_out : UNSIGNED (7 downto 0);
begin

    rst <= '0' after 50 ns;
    clk <= not clk after 25 ns;
    
    U_ALL : I8051_ALL port map (rst, clk,
                                p0_in, p0_out, p1_in, p1_out,
                                p2_in, p2_out, p3_in, p3_out);
end BHV;

-------------------------------------------------------------------------------

configuration CFG_I8051_TSB of I8051_TSB is
    for BHV
    end for;
end CFG_I8051_TSB;

-------------------------------------------------------------------------------

-- end of file --
