--
-- Fri Nov 26 17:32:55 1999
-- (matrix.hex)
--
-- THIS FILE IS AUTOMATICALLY GENERATED -- DO NOT MODIFY
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use WORK.I8051_LIB.all;

entity I8051_ROM is
    port(rst      : in  STD_LOGIC;
         clk      : in  STD_LOGIC;
         addr     : in  UNSIGNED (11 downto 0);
         data     : out UNSIGNED (7 downto 0);
         rd       : in  STD_LOGIC);
end I8051_ROM;

architecture BHV of I8051_ROM is

    type ROM_TYPE is array (0 to 408) of UNSIGNED (7 downto 0);

    signal PROGRAM : ROM_TYPE := (

	"00000010",	-- LJMP   
	"00000000",
	"00000011",
	"01111000",	-- MOV_7  
	"01111111",
	"11100100",	-- CLR_1  
	"11110110",	-- MOV_13 
	"11011000",	-- DJNZ_1 
	"11111101",
	"01110101",	-- MOV_12 
	"10000001",
	"01101101",
	"00000010",	-- LJMP   
	"00000000",
	"01001010",
	"00000010",	-- LJMP   
	"00000000",
	"10001111",
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"11111000",	-- MOV_5  
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"01000000",	-- JC     
	"00000011",
	"11110110",	-- MOV_13 
	"10000000",	-- SJMP   
	"00000001",
	"11110010",	-- MOVX_3 
	"00001000",	-- INC_2  
	"11011111",	-- DJNZ_1 
	"11110100",
	"10000000",	-- SJMP   
	"00101001",
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"11111000",	-- MOV_5  
	"01010100",	-- ANL_4  
	"00000111",
	"00100100",	-- ADD_4  
	"00001100",
	"11001000",	-- XCH_1  
	"11000011",	-- CLR_2  
	"00110011",	-- RLC    
	"11000100",	-- SWAP   
	"01010100",	-- ANL_4  
	"00001111",
	"01000100",	-- ORL_4  
	"00100000",
	"11001000",	-- XCH_1  
	"10000011",	-- MOVC_2 
	"01000000",	-- JC     
	"00000100",
	"11110100",	-- CPL_1  
	"01010110",	-- ANL_3  
	"10000000",	-- SJMP   
	"00000001",
	"01000110",	-- ORL_3  
	"11110110",	-- MOV_13 
	"11011111",	-- DJNZ_1 
	"11100100",
	"10000000",	-- SJMP   
	"00001011",
	"00000001",	-- AJMP   
	"00000010",
	"00000100",	-- INC_1  
	"00001000",	-- INC_2  
	"00010000",	-- JBC    
	"00100000",
	"01000000",
	"10000000",	-- SJMP   
	"10010000",
	"00000001",	-- AJMP   
	"00011001",
	"11100100",	-- CLR_1  
	"01111110",	-- MOV_7  
	"00000001",
	"10010011",	-- MOVC_1 
	"01100000",	-- JZ     
	"10111100",
	"10100011",	-- INC_5  
	"11111111",	-- MOV_5  
	"01010100",	-- ANL_4  
	"00111111",
	"00110000",	-- JNB    
	"11100101",
	"00001001",
	"01010100",	-- ANL_4  
	"00011111",
	"11111110",	-- MOV_5  
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"01100000",	-- JZ     
	"00000001",
	"00001110",	-- INC_2  
	"11001111",	-- XCH_1  
	"01010100",	-- ANL_4  
	"11000000",
	"00100101",	-- ADD_2  
	"11100000",
	"01100000",	-- JZ     
	"10101000",
	"01000000",	-- JC     
	"10111000",
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"11111010",	-- MOV_5  
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"11111000",	-- MOV_5  
	"11100100",	-- CLR_1  
	"10010011",	-- MOVC_1 
	"10100011",	-- INC_5  
	"11001000",	-- XCH_1  
	"11000101",	-- XCH_2  
	"10000010",
	"11001000",	-- XCH_1  
	"11001010",	-- XCH_1  
	"11000101",	-- XCH_2  
	"10000011",
	"11001010",	-- XCH_1  
	"11110000",	-- MOVX_4 
	"10100011",	-- INC_5  
	"11001000",	-- XCH_1  
	"11000101",	-- XCH_2  
	"10000010",
	"11001000",	-- XCH_1  
	"11001010",	-- XCH_1  
	"11000101",	-- XCH_2  
	"10000011",
	"11001010",	-- XCH_1  
	"11011111",	-- DJNZ_1 
	"11101001",
	"11011110",	-- DJNZ_1 
	"11100111",
	"10000000",	-- SJMP   
	"10111110",
	"11100100",	-- CLR_1  
	"11110101",	-- MOV_8  
	"01101000",
	"11110101",	-- MOV_8  
	"01101001",
	"11100100",	-- CLR_1  
	"11110101",	-- MOV_8  
	"01101010",
	"11110101",	-- MOV_8  
	"01101011",
	"11100100",	-- CLR_1  
	"11110101",	-- MOV_8  
	"01101100",
	"11110101",	-- MOV_8  
	"01101101",
	"10101111",	-- MOV_6  
	"01101101",
	"11101111",	-- MOV_1  
	"01110101",	-- MOV_12 
	"11110000",
	"00001000",
	"10100100",	-- MUL    
	"00100100",	-- ADD_4  
	"00101000",
	"11111000",	-- MOV_5  
	"11100101",	-- MOV_2  
	"01101011",
	"00100101",	-- ADD_2  
	"11100000",
	"00101000",	-- ADD_1  
	"11111000",	-- MOV_5  
	"11100110",	-- MOV_3  
	"11111100",	-- MOV_5  
	"00001000",	-- INC_2  
	"11100110",	-- MOV_3  
	"11111101",	-- MOV_5  
	"11100101",	-- MOV_2  
	"01101001",
	"01110101",	-- MOV_12 
	"11110000",
	"00001000",
	"10100100",	-- MUL    
	"00100100",	-- ADD_4  
	"00001000",
	"11111000",	-- MOV_5  
	"11101111",	-- MOV_1  
	"00100101",	-- ADD_2  
	"11100000",
	"00101000",	-- ADD_1  
	"11111000",	-- MOV_5  
	"11100110",	-- MOV_3  
	"11111110",	-- MOV_5  
	"00001000",	-- INC_2  
	"11100110",	-- MOV_3  
	"11111111",	-- MOV_5  
	"00010010",	-- LCALL  
	"00000001",
	"10000011",
	"11100101",	-- MOV_2  
	"01101001",
	"01110101",	-- MOV_12 
	"11110000",
	"00001000",
	"10100100",	-- MUL    
	"00100100",	-- ADD_4  
	"01001000",
	"11111000",	-- MOV_5  
	"11100101",	-- MOV_2  
	"01101011",
	"00100101",	-- ADD_2  
	"11100000",
	"00101000",	-- ADD_1  
	"11111000",	-- MOV_5  
	"00001000",	-- INC_2  
	"11101111",	-- MOV_1  
	"00100110",	-- ADD_3  
	"11110110",	-- MOV_13 
	"00011000",	-- DEC_2  
	"11101110",	-- MOV_1  
	"00110110",	-- ADDC_3 
	"11110110",	-- MOV_13 
	"00000101",	-- INC_3  
	"01101101",
	"11100101",	-- MOV_2  
	"01101101",
	"01110000",	-- JNZ    
	"00000010",
	"00000101",	-- INC_3  
	"01101100",
	"11100101",	-- MOV_2  
	"01101101",
	"01100100",	-- XRL_4  
	"00000100",
	"01000101",	-- ORL_2  
	"01101100",
	"01110000",	-- JNZ    
	"10101110",
	"00000101",	-- INC_3  
	"01101011",
	"11100101",	-- MOV_2  
	"01101011",
	"01110000",	-- JNZ    
	"00000010",
	"00000101",	-- INC_3  
	"01101010",
	"11100101",	-- MOV_2  
	"01101011",
	"01100100",	-- XRL_4  
	"00000100",
	"01000101",	-- ORL_2  
	"01101010",
	"01110000",	-- JNZ    
	"10011001",
	"00000101",	-- INC_3  
	"01101001",
	"11100101",	-- MOV_2  
	"01101001",
	"01110000",	-- JNZ    
	"00000010",
	"00000101",	-- INC_3  
	"01101000",
	"11100101",	-- MOV_2  
	"01101001",
	"01100100",	-- XRL_4  
	"00000100",
	"01000101",	-- ORL_2  
	"01101000",
	"01110000",	-- JNZ    
	"10000100",
	"01110101",	-- MOV_12 
	"10000000",
	"00001111",
	"01110101",	-- MOV_12 
	"10000000",
	"11110000",
	"10000000",	-- SJMP   
	"11111110",
	"00100010",	-- RET    
	"00100000",	-- JB     
	"00100000",
	"00001000",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00100000",	-- JB     
	"00100000",
	"00101000",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00000000",	-- NOP    
	"00000010",	-- LJMP   
	"00000000",
	"00000010",
	"00100000",	-- JB     
	"00100000",
	"01001000",
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"00000000",	-- NOP    
	"11101111",	-- MOV_1  
	"11111000",	-- MOV_5  
	"10001101",	-- MOV_9  
	"11110000",
	"10100100",	-- MUL    
	"11111111",	-- MOV_5  
	"11101101",	-- MOV_1  
	"11000101",	-- XCH_2  
	"11110000",
	"11001110",	-- XCH_1  
	"10100100",	-- MUL    
	"00101110",	-- ADD_1  
	"11111110",	-- MOV_5  
	"11101100",	-- MOV_1  
	"10001000",	-- MOV_9  
	"11110000",
	"10100100",	-- MUL    
	"00101110",	-- ADD_1  
	"11111110",	-- MOV_5  
	"00100010",	-- RET    
	"00000000",	-- NOP    
	"00000000"	-- NOP    
    );
begin

    process(rst, clk)
    begin
        if( rst = '1' ) then

            data <= CD_8;
        elsif( clk'event and clk = '1' ) then

            if( rd = '1' ) then

                data <= PROGRAM(conv_integer(addr) mod 409);
            else

                data <= CD_8;
            end if;
        end if;
    end process;
end BHV;