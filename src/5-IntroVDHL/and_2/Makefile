GHDL   = ghdl

TRGT = wave.ghw

SRC = and_2
TST = test_and_2

.PHONY: all clean re

all: $(TRGT)

$(TRGT):
	$(GHDL) -a $(SRC).vhdl
	$(GHDL) -e $(SRC)
	$(GHDL) -a $(TST).vhdl
	$(GHDL) -e $(TST)
	$(GHDL) -r $(TST) --wave=$(TRGT) --stop-time=50ns

clean:
	@rm -f *.cf $(TRGT)
	@echo "clean"

re: clean all
