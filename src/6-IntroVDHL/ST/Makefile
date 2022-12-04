GHDL   = ghdl

TRGT = wave.ghw

SRC = ST
TST = test_ST

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
