GHDL   = ghdl

TRGT = wave.ghw

SRC = SumSec
TST = test_SumSec

.PHONY: all clean re open

all: ST D_FlipFlop SR $(TRGT)

$(TRGT): $(st) $(DFF) $(SR)
	$(GHDL) -a $(SRC).vhdl
	$(GHDL) -a $(TST).vhdl
	$(GHDL) -e $(TST)
	$(GHDL) -r $(TST) --wave=$(TRGT) --stop-time=400ns

ST: ST.vhdl
	$(GHDL) -a $^

D_FlipFlop: D_FlipFlop.vhdl
	$(GHDL) -a $^

SR: shift_register.vhdl
	$(GHDL) -a $^


clean:
	@rm -f *.cf $(TRGT)
	@echo "clean"

re: clean all

open: clean all
	gtkwave $(TRGT) &
