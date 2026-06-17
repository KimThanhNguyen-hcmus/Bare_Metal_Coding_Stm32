# GPIO Driver-STM32F103

Lightweight, register-level GPIO driver.

## Configuration Modes (`GPIO_MODE_Typedef`)

- `0x00`: Analog Input (ADC)
- `0x04`: Floating Input (UART RX, General reading)
- `0x08`: Pull-Up / Pull-Down Input (Buttons)
- `0x01` / `0x03` / `0x07`: Output Push-Pull (10MHz / 2MHz / 50MHz)
- `0x09` / `0x0A` / `0x0B`: Alternate Function Push-Pull
- `0x0F`: Alternate Function Open-Drain (50MHz)

## API Reference

- `void GPIO_EnableClock(GPIOx)`: Enable APB2 clock for the target port.
- `void GPIO_SetPin(GPIOx, pin, mode)`: Configure pin mode and speed.
- `void GPIO_WritePin(GPIOx, pin, state)`: Set pin HIGH (`1`) or LOW (`0`).
- `uint8_t GPIO_ReadPin(GPIOx, pin)`: Returns current input state (`1` or `0`).
- `void GPIO_Toggle(GPIOx, pin)`: Reverses current output state.

## Example

An example about blinking LED PC13

```c++
#include "stm32f103.h"
#include "gpio.h"
#include "delay.h"

int main(void)
{
     GPIO_EnableClock(GPIOC);
     GPIO_SetPin(GPIOC, 13, GPIO_MODE_OUTPUT_PULL_2MHZ);
    while(1){
        GPIO_Toggle(GPIOC, 13);
        delay_ms(1000);
    }
}
```
