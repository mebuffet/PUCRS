*
simulator lang=spectre insensitive=no
include "st65.scs"
simulator lang=spice
*
.include "../pexRunDir/Complex_f2.pex.spi"
*
X1 A B C D S vdd 0 Complex_f2
C3 S 0 25fF
*
vdd vdd 0 dc 1.0
v1 D 0 pulse (1 0 0 0.02N 0.02N 1N 2N)
v2 C 0 pulse (1 0 0 0.02N 0.02N 2N 4N)
v3 B 0 pulse (1 0 0 0.02N 0.02N 4N 8N)
v4 A 0 pulse (1 0 0 0.02N 0.02N 8N 16N)
*
.tran 0.001N 25N
*
.END
