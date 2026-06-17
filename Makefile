# ==============================================================================
# PROJECT & BUILD SETTINGS
# ==============================================================================
TARGET = project
BUILD_DIR = Build

# ==============================================================================
# TOOLCHAIN CONFIGURATION
# ==============================================================================
CC = arm-none-eabi-gcc 
OBJCOPY = arm-none-eabi-objcopy 
SZ = arm-none-eabi-size

# ==============================================================================
# MCU & COMPILER FLAGS
# ==============================================================================
CPU = -mcpu=cortex-m3
MCU = $(CPU) -mthumb
OPT = -O0

# Show folder path
C_INCLUDES = $(addprefix -I,$(sort $(dir $(call rwildcard, Inc, *.h))))

# Include all compile flags
CFLAGS = $(MCU) $(OPT) -Wall -g $(C_INCLUDES)

# ==============================================================================
# LINKER SCRIPT & FLAGS
# ==============================================================================
LDSCRIPT = stm32f103.ld
LDFLAGS = $(MCU) -T$(LDSCRIPT) -nostdlib -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# ==============================================================================
# AUTOMATIC FILE SEARCHING 
# ==============================================================================
# Recursive function to find all files and folders
rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

# Collect all files .c and .s in Src folder
C_SOURCES = $(call rwildcard, Src, *.c)
C_SOURCES += $(call rwildcard, Inc, *.c)
ASM_SOURCES = $(call rwildcard, Src, *.s)

# Move all files .o built into folder Build
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))

# Add Assembly files into Build folder
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

# ==============================================================================
# BUILD RULES 
# ==============================================================================
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

# Link file .o to file .elf
$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) | $(BUILD_DIR)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

# Make file .hex from file .elf
$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(OBJCOPY) -O ihex $< $@

# Make file .bin from file .elf
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(OBJCOPY) -O binary -S $< $@

# Compile file .c to file .o
$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) $< -o $@

# Compile file Assembly (.s) to file .o
$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(CC) -x assembler-with-cpp -c $(CFLAGS) $< -o $@

# Create Build folder if not existed yet
$(BUILD_DIR):
	if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)

# ==============================================================================
# FLASH & CLEAN
# ==============================================================================
.PHONY: clean flash

flash: $(BUILD_DIR)/$(TARGET).elf
	openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program $< verify reset exit"

clean:
	-rmdir /s /q $(BUILD_DIR)