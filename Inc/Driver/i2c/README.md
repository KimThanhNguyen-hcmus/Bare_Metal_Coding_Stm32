# I2C Driver-STM32F103

Hardware I2C driver optimized for OLED (SSD1306) and sensors.

## Hardware Requirements

- SCL and SDA pins MUST be configured as `GPIO_MODE_AF_OPEN_DRAIN_50MHZ` (0x0F).
- External pull-up resistors (4.7k - 10k) are required on the I2C bus.
- Default OLED addresses are usually `0x78` or `0x7A`.

## API Reference

- `void I2C_Init(I2C_TypeDef *I2Cx)`: Initializes I2C peripheral (100kHz standard mode) and performs software reset to clear bus lock-ups.
- `void I2C_WriteByte(I2C_TypeDef *I2Cx, uint8_t slave_addr, uint8_t reg_addr, uint8_t data)`: Sends a single byte to a specific register of a slave device.

## Example

An example about waking up OLED display

```c++
#include "stm32f103.h"
#include "i2c.h"
#include "delay.h"

int main(void)
{
    I2C_Init(I2C1);
    delay_ms(100);

    // Wake up OLED at address 0x78
    I2C_WriteByte(I2C1, 0x78, 0x00, 0xAF);

    while(1){}
}
```
