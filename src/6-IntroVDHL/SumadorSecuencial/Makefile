GHDL   = ghdl

TRGT = wave.ghw

SRC = SumSec
TST = test_SumSec

st  = ST
dff = D_FlipFlop
sr  = shift_register

.PHONY: all clean re

all: $(ST) $(DFF) $(SR) $(TRGT) 

$(TRGT): $(ST) $(DFF) $(SR)
	$(GHDL) -a $(SRC).vhdl
	$(GHDL) -e $(SRC)
	$(GHDL) -a $(TST).vhdl
	$(GHDL) -e $(TST)
	$(GHDL) -r $(TST) --wave=$(TRGT) --stop-time=50ns

$(ST): $(st)
	$(GHDL) -a $(sr).vhdl
	$(GHDL) -e $(sr)

$(DFF): $(dff)
	$(GHDL) -a $(dff).vhdl
	$(GHDL) -e $(dff)

$(SR): $(sr)
	$(GHDL) -a $(sr).vhdl
	$(GHDL) -e $(sr)


clean:
	@rm -f *.cf $(TRGT)
	@echo "clean"

re: clean all
