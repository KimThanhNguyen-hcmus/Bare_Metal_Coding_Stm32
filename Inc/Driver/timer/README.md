# Timer Driver-STM32F103

Hardware timer control for PWM generation and periodic interrupts.

## API Reference

- `void TIM_Init(TIMER_TypeDef *TIMx, uint16_t psc, uint16_t arr)`: Configures the timer base frequency.
- `void TIM_Start(TIMER_TypeDef *TIMx)`: Enables the counter.
- `void TIM_Stop(TIMER_TypeDef *TIMx)` : Stop the counter.
- `uint16_t TIM_GetCounter(TIMER_TypeDef *TIMx)` : Get counter value.
- `void TIM_SetCounter(TIMER_TypeDef *TIMx, uint16_t value)` : Set counter value.
- `void TIM_DelayUs(TIMER_TypeDef *TIMx, uint16_t us)` : Delay in microsecond using TIMER
- `void TIM_DelayMs(TIMER_TypeDef *TIMx, uint16_t ms)` : Delay in milisecond using TIMER
- `void TIM_PWM_Init(TIMER_TypeDef *TIMx, uint8_t channel)`: Configures a specific channel for PWM output.
- `void TIM_PWM_SetDuty(TIMER_TypeDef *TIMx, uint8_t channel, uint16_t value)`: Adjusts the CCR register for PWM duty cycle.

## Example

An example about setting PWM duty cycle

```c++
#include "stm32f103.h"
#include "timer.h"

int main(void)
{
    // Generate 1kHz PWM assuming 8MHz clock
    TIM_Init(TIM2, 8000 - 1, 1000 - 1);
    TIM_PWM_Init(TIM2, 1); // Channel 1
    TIM_SetPWM(TIM2, 1, 500); // 50% duty cycle
    TIM_Start(TIM2);

    while(1){}
}
```
