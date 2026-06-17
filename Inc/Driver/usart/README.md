# USART Driver-STM32F103

Polling-based serial communication driver for debugging and Bluetooth (HC-06).

## Hardware Configuration

- TX Pin: MUST be `GPIO_MODE_AF_PUSH_PULL_50MHZ` (0x0B).
- RX Pin: MUST be `GPIO_MODE_INPUT_FLOATING` (0x04).

## API Reference

- `void USART_Init(USART_TypeDef *USARTx, uint32_t pclk, uint32_t baudrate)`: Configures UART baudrate and enables TX/RX.
- `void USART_SendChar(USART_TypeDef *USARTx, char ch)`: Transmits a single character.
- `void USART_SendString(USART_TypeDef *USARTx, char *str)`: Transmits a null-terminated string.
- `void USART_SendHex(USART_TypeDef *USARTx, uint8_t data)`: Transmits an 8-bit value in hexadecimal format.

## Example

An example about sending data to HC-06

```c++
#include "stm32f103.h"
#include "usart.h"
#include "delay.h"

int main(void)
{
    USART_Init(USART1, 8000000, 115200);

    while(1){
        USART_SendString(USART1, "Hello from STM32\r\n");
        delay_ms(1000);
    }
}
```
