SHELL                   := $(shell which bash) -o pipefail
ABS_TOP                 := $(shell pwd)

SIM_RTL                 := $(shell find $(ABS_TOP)/sim -type f -name "*.sv")
SIM_TARGETS             := $(shell realpath --relative-to $(ABS_TOP) $(SIM_RTL))

VCS                     := /home/ff/eecs151/hammer-tools/synopsys/vcs/P-2019.06/bin/vcs -full64
VCS_OPTS                := -notice -line +lint=all,noVCDE,noNS,noSVA-UA -sverilog -timescale=1ns/1ps -debug
VCS_TARGETS             := $(SIM_TARGETS:%.sv=%.vpd)
IVERILOG                := iverilog
IVERILOG_OPTS           := -D IVERILOG=1 -g2019 -gassertions -Wall -Wno-timescale
IVERILOG_TARGETS        := $(SIM_TARGETS:%.sv=%.fst)
VVP                     := vvp
RTL						:= $(ABS_TOP)/src/d_flip_flop.sv

sim/%.tb: sim/%.sv
	cd sim && $(VCS) $(VCS_OPTS) -o $*.tb $*.sv $(RTL) ../src/$(patsubst %_tb.sv,%.sv,$(notdir $<))

# special case where one tb depends on two sources
sim/decoder_4_to_16_tb.tb: sim/decoder_4_to_16_tb.sv
	cd sim && $(VCS) $(VCS_OPTS) -o decoder_4_to_16_tb.tb decoder_4_to_16_tb.sv $(RTL) ../src/line_decoder.sv ../src/$(patsubst %_tb.sv,%.sv,$(notdir $<))

$(VCS_TARGETS): sim/%.vpd: sim/%.tb
	cd sim && ./$*.tb +verbose=1 +vpdfile+$*.vpd

clean:
	rm -rf ./build $(junk) *.daidir sim/output.txt \
	sim/*.tb sim/*.daidir sim/csrc \
	sim/ucli.key sim/*.vpd sim/*.vcd \
	sim/*.tbi sim/*.fst sim/*.jou sim/*.log sim/*.out
	