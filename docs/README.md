## Official Documentation & Reference Manuals

### STMicroelectronics (Hardware & Cortex-M Core)

- **[RM0008 Reference Manual](https://www.st.com/resource/en/reference_manual/rm0008-stm32f101xx-stm32f102xx-stm32f103xx-stm32f105xx-and-stm32f107xx-advanced-armbased-32bit-mcus-stmicroelectronics.pdf):** The ultimate bare-metal guide. Contains register maps, clock tree details, and operational logic for all peripherals (GPIO, I2C, USART, Timers, etc.).
- **[PM0214 Programming Manual](https://www.st.com/resource/en/programming_manual/pm0214-stm32-cortexm4-mcus-and-mpus-programming-manual-stmicroelectronics.pdf):** Covers the Cortex-M core architecture, SysTick timer, NVIC (Nested Vectored Interrupt Controller), and Assembly instruction sets.
- **[STM32F103c8 Datasheet](https://www.st.com/resource/en/datasheet/stm32f103c8.pdf):** Electrical characteristics, voltage ratings, physical pinouts, and Alternate Function mappings.

### GNU Toolchain & Build System

- **[GNU Make Manual](https://www.gnu.org/software/make/manual/make.pdf):** Detailed guide on Makefile structure, recursive wildcard functions, `vpath`, and build rules.
- **[GCC Compiler Manual](https://gcc.gnu.org/onlinedocs/gcc.pdf):** Documentation for compiler flags used in the project (`-O0`, `-Wall`, `-mcpu=cortex-m3`, `-mthumb`).
- **[GNU C Reference Manual](https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.pdf):** Core concepts and standard structure of the C language.
- **[GNU Linker (ld) Manual](https://sourceware.org/binutils/docs-2.38/ld.pdf):** Explains how object files (`.o`) are linked into executable files (`.elf`), and how the linker script manipulates memory regions.
- **[Custom Linker Script (stm32f103.ld)](https://drive.google.com/file/d/1aHSg8Lb-FJaNtquKMhnjYdsba5w-g9Iu/view?usp=sharing):** Project-specific configuration mapping out the FLASH and SRAM memory boundaries for the STM32F103 MCU.
