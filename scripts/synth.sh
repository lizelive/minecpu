#!/bin/bash

INPUT=$1
TOP=${2:-$(basename -s .sv $INPUT)}
LIBRARY=${3:-"gates/redstone_raw.lib"}


rm -rf out/
mkdir out

yosys -p "
read_verilog -sv $INPUT;
# select -module $TOP; #cant figure out select seems to break everything
show -format png -prefix out/block $TOP;

flatten;
# generic synthesis
synth -top $TOP -flatten;

dfflibmap -liberty $LIBRARY;
abc -liberty $LIBRARY;
clean;

write_verilog synth.v;

show -format png -prefix out/gates $TOP;
ltp;
stat;
"
