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
use WORK.I8051_LIB.all;

-------------------------------------------------------------------------------

entity I8051_ALL is
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
end I8051_ALL;

-------------------------------------------------------------------------------

architecture STR of I8051_ALL is

    component I8051_ALU
        port(rst     : in  STD_LOGIC;
             op_code : in  UNSIGNED (3 downto 0);
             src_1   : in  UNSIGNED (7 downto 0);
             src_2   : in  UNSIGNED (7 downto 0);
             src_3   : in  UNSIGNED (7 downto 0);
             src_cy  : in  STD_LOGIC;
             src_ac  : in  STD_LOGIC;
             des_1   : out UNSIGNED (7 downto 0);
             des_2   : out UNSIGNED (7 downto 0);
             des_cy  : out STD_LOGIC;
             des_ac  : out STD_LOGIC;
             des_ov  : out STD_LOGIC);
    end component;

    component I8051_DEC
        port(rst     : in  STD_LOGIC;
             op_in   : in  UNSIGNED (7 downto 0);
             op_out  : out UNSIGNED (8 downto 0));
    end component;
    
    component I8051_RAM
        port(rst          : in  STD_LOGIC;
             clk          : in  STD_LOGIC;
             addr         : in  UNSIGNED (7 downto 0);
             in_data      : in  UNSIGNED (7 downto 0);
             out_data     : out UNSIGNED (7 downto 0);
             in_bit_data  : in  STD_LOGIC;
             out_bit_data : out STD_LOGIC;
             rd           : in  STD_LOGIC;
             wr           : in  STD_LOGIC;
             is_bit_addr  : in  STD_LOGIC;
             p0_in        : in  UNSIGNED (7 downto 0);
             p0_out       : out UNSIGNED (7 downto 0);
             p1_in        : in  UNSIGNED (7 downto 0);
             p1_out       : out UNSIGNED (7 downto 0);
             p2_in        : in  UNSIGNED (7 downto 0);
             p2_out       : out UNSIGNED (7 downto 0);
             p3_in        : in  UNSIGNED (7 downto 0);
             p3_out       : out UNSIGNED (7 downto 0));
    end component;

    component I8051_ROM
        port(rst      : in  STD_LOGIC;
             clk      : in  STD_LOGIC;
             addr     : in  UNSIGNED (11 downto 0);
             data     : out UNSIGNED (7 downto 0);
             rd       : in  STD_LOGIC);
    end component;

    component I8051_CTR
        port(rst              : in  STD_LOGIC;
             clk              : in  STD_LOGIC;
             rom_addr         : out UNSIGNED (11 downto 0);
             rom_data         : in  UNSIGNED (7 downto 0);
             rom_rd           : out STD_LOGIC;
             ram_addr         : out UNSIGNED (7 downto 0);
             ram_out_data     : out UNSIGNED (7 downto 0);
             ram_in_data      : in  UNSIGNED (7 downto 0);
             ram_out_bit_data : out STD_LOGIC;
             ram_in_bit_data  : in  STD_LOGIC;
             ram_rd           : out STD_LOGIC;
             ram_wr           : out STD_LOGIC;
             ram_is_bit_addr  : out STD_LOGIC;
             dec_op_out       : out UNSIGNED (7 downto 0);
             dec_op_in        : in  UNSIGNED (8 downto 0);
             alu_op_code      : out UNSIGNED (3 downto 0);
             alu_src_1        : out UNSIGNED (7 downto 0);
             alu_src_2        : out UNSIGNED (7 downto 0);
             alu_src_3        : out UNSIGNED (7 downto 0);
             alu_src_cy       : out STD_LOGIC;
             alu_src_ac       : out STD_LOGIC;
             alu_des_1        : in  UNSIGNED (7 downto 0);
             alu_des_2        : in  UNSIGNED (7 downto 0);
             alu_des_cy       : in  STD_LOGIC;
             alu_des_ac       : in  STD_LOGIC;
             alu_des_ov       : in  STD_LOGIC);
    end component;
    
    -- synopsys_synthesis off
    component I8051_DBG
        port(
		rom_addr	: in UNSIGNED (11 downto 0);
		op_in		: in  UNSIGNED (8 downto 0)
	);
    end component;

    component I8051_DBG_RAM
    port(
	    clk          : in  STD_LOGIC;
	    addr         : in  UNSIGNED (7 downto 0);
	    rd           : in  STD_LOGIC;
	    wr           : in  STD_LOGIC
    );
    end component;

    component I8051_DBG_ROM
    port(
	    clk          : in  STD_LOGIC;
	    addr         : in  UNSIGNED (11 downto 0);
	    rd           : in  STD_LOGIC
    );
    end component;
    -- synopsys_synthesis on
    
    signal rom_addr         : UNSIGNED (11 downto 0);
    signal rom_data         : UNSIGNED (7 downto 0);
    signal rom_rd           : STD_LOGIC;
    signal ram_addr         : UNSIGNED (7 downto 0);
    signal ram_out_data     : UNSIGNED (7 downto 0);
    signal ram_in_data      : UNSIGNED (7 downto 0);
    signal ram_out_bit_data : STD_LOGIC;
    signal ram_in_bit_data  : STD_LOGIC;
    signal ram_rd           : STD_LOGIC;
    signal ram_wr           : STD_LOGIC;
    signal ram_is_bit_addr  : STD_LOGIC;
    signal dec_op_out       : UNSIGNED (7 downto 0);
    signal dec_op_in        : UNSIGNED (8 downto 0);
    signal alu_op_code      : UNSIGNED (3 downto 0);
    signal alu_src_1        : UNSIGNED (7 downto 0);
    signal alu_src_2        : UNSIGNED (7 downto 0);
    signal alu_src_3        : UNSIGNED (7 downto 0);
    signal alu_src_cy       : STD_LOGIC;
    signal alu_src_ac       : STD_LOGIC;
    signal alu_des_1        : UNSIGNED (7 downto 0);
    signal alu_des_2        : UNSIGNED (7 downto 0);
    signal alu_des_cy       : STD_LOGIC;
    signal alu_des_ac       : STD_LOGIC;
    signal alu_des_ov       : STD_LOGIC;
begin
    
    U_ALU : I8051_ALU port map(rst,
                               alu_op_code,
                               alu_src_1,
                               alu_src_2,
                               alu_src_3,
                               alu_src_cy,
                               alu_src_ac,
                               alu_des_1,
                               alu_des_2,
                               alu_des_cy,
                               alu_des_ac,
                               alu_des_ov);

    U_DEC : I8051_DEC port map(rst,
                               dec_op_out,
                               dec_op_in);

    U_RAM : I8051_RAM port map(rst,
                               clk,
                               ram_addr,
                               ram_in_data,
                               ram_out_data,
                               ram_in_bit_data,
                               ram_out_bit_data,
                               ram_rd,
                               ram_wr,
                               ram_is_bit_addr,
                               p0_in,
                               p0_out,
                               p1_in,
                               p1_out,
                               p2_in,
                               p2_out,
                               p3_in,
                               p3_out);

    U_ROM : I8051_ROM port map(rst,
                               clk,
                               rom_addr,
                               rom_data,
                               rom_rd);

    U_CTR : I8051_CTR port map(rst,
                               clk,
                               rom_addr,
                               rom_data,
                               rom_rd,
                               ram_addr,
                               ram_in_data,
                               ram_out_data,
                               ram_in_bit_data,
                               ram_out_bit_data,
                               ram_rd,
                               ram_wr,
                               ram_is_bit_addr,
                               dec_op_out,
                               dec_op_in,
                               alu_op_code,
                               alu_src_1,
                               alu_src_2,
                               alu_src_3,
                               alu_src_cy,
                               alu_src_ac,
                               alu_des_1,
                               alu_des_2,
                               alu_des_cy,
                               alu_des_ac,
                               alu_des_ov);

    -- synopsys_synthesis off
    U_DBG : I8051_DBG port map(rom_addr, dec_op_in);
    U_DBG_RAM : I8051_DBG_RAM port map(clk, ram_addr, ram_rd, ram_wr);
    U_DBG_ROM : I8051_DBG_ROM port map(clk, rom_addr, rom_rd );
    -- synopsys_synthesis on
end STR;

-------------------------------------------------------------------------------

-- end of file --
