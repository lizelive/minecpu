FROM ghcr.io/lizelive/yosys:cli-devenv
USER root
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends iverilog clang build-essential \
    python3-pip libpng-dev libyaml-dev libgd-dev universal-ctags \
    build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev sudo verilator

RUN pip install myhdl
USER yosys