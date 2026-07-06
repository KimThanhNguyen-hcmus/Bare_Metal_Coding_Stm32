# Peripheral access

This `README` will illustrate how can we access peripheral such as `GPIO`, `UART`, `SPI` through their memory addresses in `STM32` memory map.

## Accessiblity

First, we need to locate and `define` the base address of all peripherals which calls `PERIPH_BASE`.

```c
#define PERIPH_BASE 0x40000000UL
```

Once we located it, we need to locate the `AHB` and the 2 `APB` buses, which are `APB1` and `APB2`. Cause the address mapping of the peripherals connected to each bridge and the two `AHB/APB` bridges provide full synchronous connections between the `AHB` and the 2 `APB` buses.

```c
#define APB2PERIPH_BASE (PERIPH_BASE + 0x10000UL)
#define APB1PERIPH_BASE (PERIPH_BASE)
#define AHBPERIPH_BASE (PERIPH_BASE + 0x20000UL)
```

Through here, others peripherals addresses can be access. For instance, if we want to use `GPIOA`, so we need to find it `offset` value in Memory Map in `STM32 Reference Manual`, in this case it should be `0800` and `GPIOA` is in `APB2`. So we just need to add that `offset` value to `APB2` addresses.

```c
#define GPIOA_PERIPH_BASE (APB2PERIPH_BASE + 0x0800UL)
```

This work for others peripheral addresses.

Once we locate all peripheral addresses, we need to make `typedef struct` contain all peripheral's function registers. Keep in mind, every register's `offset` value is `0x004` so when writing `struct` for peripheral we need to follow their order.

```c
typedef struct
{
    volatile uint32_t CRL;
    volatile uint32_t CRH;
    volatile uint32_t IDR;
    volatile uint32_t ODR;
    volatile uint32_t BSRR;
    volatile uint32_t BRR;
    volatile uint32_t LCKR;
} GPIO_TypeDef;

#define GPIOA ((GPIO_TypeDef *)GPIOA_PERIPH_BASE)
```

- After writing `struct`, we will `define` the value so that all registers in peripheral can be in the right memory address.
- In each registers contain 32 bit, each bit has it own function. Meaning if we want to use register's function, we need looking it up in `STM32 Reference Manual`. For example, enable `GPIOA` pin 5.
- And we want it to be `output` or `input`, it will depend on enable value in `Port bit configuration table` in `STM32 Reference Manual`.

**Access** -> flat name -> arrow through the struct:

```c
GPIOA->CRL |= (1 << 20); /*This is general purpose output push-pull*/
```

This work for others peripheral addresses.

## How it work

The compiler will computes each field `offset` from the struct. As long as the field order and types match the memory map and register map, `GPIOA->CRL` compile to `*(uint32 *)0x40010800 + 0x00` - the exact same address as the `#define` version.

Build/Flash

```bash
ming32w-make
ming32w-make flash
```

## Meaning

Moving from raw addresses to a peripheral block. Why bother:

- **Scales**: `GPIOA` through `GPIOG` each have around 7 registers. One `GPIO_Typedef` handles them all instead of hundred lines of `#define`.
- **Offsets stay in sync**: If memory address or peripheral change, we just need to fix one struct instead of hunting down individual `#define`s.
- **Same style as CMSIS**: This pattern is same `STM32F101xx` CMSIS style, so it can be easily to follow.
