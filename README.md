# Kit de Desarrollo WeActStudio - STM32F103RCT6

## Descripción
La idea del repositorio es llevar un logbook con los retos que nos ponga este kit de desarrollo de WeActStudio.

## Hardware
* Procesador ARM Cortex-M3 que opera a una frecuencia de hasta 72 MHz
* 256 KB de memoria Flash
* 48 KB de memoria SRAM
* 8 MHz de reloj externo
* Multiples interfaces USART, SPI, I2C, CAN, USB
* Modos de bajo consumo
* Timers de proposito general
* Canales ADC/DCA

## Requisitos previos

### Hardware adicional
- Interfaz de comunicaciones USB-UART. Podemos comprar uno en Aliexpress

### Software necesario

1. Entorno de desarrollo STM32CubeIDE: IDE completo que incluye herramientas de configuración y depuración
2. stm32flash: Herramienta de línea de comandos para programar microcontroladores STM32 a través de UART

## Programación del Kit

### Software necesario

Como hemos nombrado anteriormente este Kit lo vamos a programar usando stm32flash. Para Ubuntu tenermos esta aplicación en los repositorios oficiales.

```bash
sudo apt-get install stm32flash
```

### Flaseo

En nuesto caso vamos a utilizar el interfaz USB-UART. Lo primero es hacer las conexiones correctas con la placa:
1. Conexionado con el interfaz
* TX del adaptador a RX de la placa
* RX del adaptador a TX de la placa
* GND del adaptador a GND de la placa
2. Entrar en modo programacion:
* Mantener presionado el botón BOOT0
* Presionar y soltar el botón RESET mientras se mantiene BOOT0
* Soltar el botón BOOT0

#### Comandos básicos de stm32flash

Leer informacion del microcontrolador:
```bash
stm32flash -r /dev/ttyUSB0
```
Escribir binario en memoria
```bash
stm32flash -w firmware.bin -v /dev/ttyUSB0
```
Opciones comunes
```
-w: Escribir archivo
-r: Leer archivo
-v: Verificar después de escribir
```
## Recursos Adicionales



