# OS Scheduler-STM32F103

Lightweight bare-metal task scheduler for multi-threading simulation.
Readmore in [RTOS from scratch](https://www.notion.so/RTOS-from-scratch-English-ver-33b984656d2c806c9579eb40ed18872a?source=copy_link)

## Data Structures

- `TCB_t`: Task Control Block structure containing stack pointer and next task pointer.

## API Reference

- `void OS_TaskCreate(TCB_t *tcb, void (*task_func)(void *), void *arg, uint32_t *stack_base, uint32_t stack_size)`: Initializes a task's stack and metadata.
- `void OS_AddThread(TCB_t *task)`: Adds a created task to the circular linked list (Ready Queue).
- `void OS_Start(void)`: Configures PendSV/SysTick and starts the first task.
- `void OS_Delay(uint32_t ticks)`: Blocks the current task and yields the CPU.

## Example

An example about creating and running a task

```c++
#include "stm32f103.h"
#include "os.h"

TCB_t task1;
uint32_t stack1[128];

void Task1_Func(void *arg) {
    while(1) {
        // Task logic
        OS_Delay(1000);
    }
}

int main(void)
{
    OS_TaskCreate(&task1, Task1_Func, NULL, stack1, 128);
    OS_AddThread(&task1);
    OS_Start();

    while(1){} // Should never reach here
}
```

An example about creating and running more than 2 task

```c++
#include <stdint.h>
#include "stm32f103.h"
#include "os.h"
#include "gpio.h"

#define STACK_SIZE 100
uint32_t idle_stack[STACK_SIZE];
uint32_t task1_stack[STACK_SIZE];
uint32_t task2_stack[STACK_SIZE];
uint32_t task3_stack[STACK_SIZE];
TCB_t tcbidle, tcb1, tcb2, tcb3;
extern TCB_t volatile *current_task;
extern TCB_t volatile *next_task;
/* The reason why we need this function due to CPU always need Program Counter
if the system don't have this, it may crash  */
void Idle_Task(void)
{
    while (1)
    {
        __asm volatile("WFI \n");
    }
}

void Generic_Blink_Task(void *arg)
{
    int pin_number = (int)arg;
    while (1)
    {
        GPIO_Toggle(GPIOA, pin_number);
        OS_Delay(1000);
    }
}

int main(void)
{
    GPIO_EnableClock(GPIOA);
    GPIO_EnableClock(GPIOC);
    GPIO_SetPin(GPIOA, 1, GPIO_MODE_OUTPUT_PULL_2MHZ);
    GPIO_SetPin(GPIOA, 2, GPIO_MODE_OUTPUT_PULL_2MHZ);
    GPIO_SetPin(GPIOC, 13, GPIO_MODE_OUTPUT_PULL_2MHZ);
    OS_TaskCreate(&tcbidle, Idle_Task, NULL, idle_stack, STACK_SIZE);
    OS_AddThread(&tcbidle);
    OS_TaskCreate(&tcb1, Generic_Blink_Task, (void *)1, task1_stack, STACK_SIZE);
    OS_AddThread(&tcb1);
    OS_TaskCreate(&tcb2, Generic_Blink_Task, (void *)2, task2_stack, STACK_SIZE);
    OS_AddThread(&tcb2);
    OS_Start();
    return 0;
}
```
