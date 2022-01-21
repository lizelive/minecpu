#!/bin/bash

INPUT=$1

LIBRARY="redstone.lib"
TOP=$(basename -s .sv $INPUT)

rm -rf out/
mkdir out

yosys -p "
read_verilog -sv $INPUT;
# select -module $TOP; #cant figure out select seems to break everything
show -format png -prefix out/block $TOP;

flatten;
# generic synthesis
synth -top $TOP -flatten;

dfflibmap -liberty mycells.lib
abc -liberty mycells.lib
clean

write_verilog synth.v;

show -format png -prefix out/gates $TOP;
ltp;
stat;
"
