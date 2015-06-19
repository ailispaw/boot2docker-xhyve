ifeq ($V, 1)
	VERBOSE =
else
	VERBOSE = @
endif

include config.mk

SRC := main.c

OBJ := $(SRC:%.c=build/%.o)
DEP := $(OBJ:%.o=%.d)
INC :=

TARGET = build/uuid2mac

all: $(TARGET) | build

.PHONY: clean all
.SUFFIXES:

-include $(DEP)

build:
	@mkdir -p build

build/%.o: %.c
	@echo cc $<
	@mkdir -p $(dir $@)
	$(VERBOSE) $(ENV) $(CC) $(CFLAGS) $(INC) $(DEF) -MMD -MT $@ -MF build/$*.d -o $@ -c $<

$(TARGET).sym: $(OBJ)
	@echo ld $(notdir $@)
	$(VERBOSE) $(ENV) $(LD) $(LDFLAGS) -Xlinker $(TARGET).lto.o -o $@ $(OBJ)
	@echo dsym $(notdir $(TARGET).dSYM)
	$(VERBOSE) $(ENV) $(DSYM) $@ -o $(TARGET).dSYM

$(TARGET): $(TARGET).sym
	@echo strip $(notdir $@)
	$(VERBOSE) $(ENV) $(STRIP) $(TARGET).sym -o $@

clean:
	@rm -rf build
