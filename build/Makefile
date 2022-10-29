TOP_PATH = ..
CSRC_PATH = $(TOP_PATH)/platform/src
ASRC_PATH = $(TOP_PATH)/platform/src
INC_PATH = $(TOP_PATH)/platform/inc

INC = -I$(INC_PATH)
CSRC = $(wildcard $(CSRC_PATH)/*.c)
ASRC = $(wildcard $(ASRC_PATH)/*.S)

OBJSC = $(patsubst $(CSRC_PATH)/%.c, %.o, $(CSRC))
OBJSA = $(patsubst $(ASRC_PATH)/%.S, %.o, $(ASRC))
OBJS = $(OBJSC) $(OBJSA)
MARCH = rv32imac
MABI = ilp32

RISCV_TOOL_PATH = /home/dhoon/bin/riscv/bin/riscv32-unknown-elf-
CC = $(RISCV_TOOL_PATH)gcc
AS = $(RISCV_TOOL_PATH)as
LD = $(RISCV_TOOL_PATH)ld
DUMP = $(RISCV_TOOL_PATH)objdump -S

CCFLAGS = -Wall -c -g -I$(INC) -march=$(MARCH) -mabi=$(MABI)
ASFLAGS = -Wall -c -g -I$(INC) -march=$(MARCH) -mabi=$(MABI)
LDFLAGS = -g
LDFLAGS += -Wall
LDFLAGS += -nostdlib -nodefaultlibs -nostartfiles
LDFLAGS += -march=$(MARCH) -mabi=$(MABI)
LDFLAGS += -T linker.ld

TARGET = hos.elf

all: $(TARGET)

$(TARGET): $(OBJS)
	@echo "----All Object Linking----"
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

$(OBJSC): $(CSRC)
	@echo "----C Source Compiling----"
	$(CC) $(CCFLAGS) $^ -o $@

$(OBJSA): $(ASRC)
	@echo "----ASM Source Compiling----"
	$(AS) $(ASFLAGS) $^ -o $@

dump: $(OBJSC) $(OBJSA)
	$(DUMP) $(OBJSC) $(OBJSA) > objs.dump

clean:
	rm -f *.o $(TARGET) *.dump