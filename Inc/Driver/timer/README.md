# Timer Driver-STM32F103

Hardware timer control for PWM generation and periodic interrupts.

## API Reference

- `void Timer_Init(TIM_TypeDef *TIMx, uint16_t prescaler, uint16_t auto_reload)`: Configures the timer base frequency.
- `void Timer_Start(TIM_TypeDef *TIMx)`: Enables the counter.
- `void Timer_PWM_Init(TIM_TypeDef *TIMx, uint8_t channel)`: Configures a specific channel for PWM output.
- `void Timer_SetPWM(TIM_TypeDef *TIMx, uint8_t channel, uint16_t duty_cycle)`: Adjusts the CCR register for PWM duty cycle.

## Example

An example about setting PWM duty cycle

```c++
#include "stm32f103.h"
#include "timer.h"

int main(void)
{
    // Generate 1kHz PWM assuming 8MHz clock
    Timer_Init(TIM2, 8000 - 1, 1000 - 1);
    Timer_PWM_Init(TIM2, 1); // Channel 1
    Timer_SetPWM(TIM2, 1, 500); // 50% duty cycle
    Timer_Start(TIM2);

    while(1){}
}
```
