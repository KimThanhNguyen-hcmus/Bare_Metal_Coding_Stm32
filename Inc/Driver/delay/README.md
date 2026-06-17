# Delay Driver-STM32F103

Bare-metal SysTick timer driver for blocking delays.

## Configuration Macros

- `CPU_FREQ_MHZ`: Defines the system clock frequency (default: 8 for 8MHz). Adjust if using PLL.
- `SYSTICK_BASE`: Physical address of the SysTick hardware registers.

## API Reference

- `void delay_us(uint32_t us)`: Microsecond blocking delay.
- `void delay_ms(uint32_t ms)`: Millisecond blocking delay.

## Example

An example about 500ms delay loop

```c++
#include "stm32f103.h"
#include "delay.h"

int main(void)
{
    while(1){
        // Do something
        delay_ms(500);
    }
}
```
