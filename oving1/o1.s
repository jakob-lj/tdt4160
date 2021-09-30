
.thumb
.syntax unified

.include "gpio_constants.s" // GPIO BASE

.text // text
	.global Start
	
Start: // func
	ldr p, =GPIO_BASE + (PORT_SIZE * LED_PORT)
	ldr pen, =GPIO_PORT_DOUTCLR
	add pen, p, pen
	ldr pto, =GPIO_PORT_DOUTSET
	add p, p, pto

	ldr pto, =GPIO_BASE + (PORT_SIZE * BUTTON_PORT) + GPIO_PORT_DIN

	ldr s, =1 << LED_PIN
	ldr sen, =1 << BUTTON_PIN

Loop: // loop as main
	ldr r6, [pto]
	and r6, r6, sen
	cmp r6, sen
	beq TurnOn
TurnOff:
	str s, [p]
	B Loop
TurnOn:
	str s, [pen]
	B Loop

NOP // Behold denne på bunnen av fila