# UPM_M_SE

## Información sobre el proyecto:
Microcontrolador: `dsPIC33FJ64MC802`
Frecuencia del cristal (Fosc): 7.3728 MHz



## Instalación de las herramientas
1. Primero hay que instalar el compilador correspondiente. Es el `xc-16`, y se descarga en la [página de Microchip](https://www.microchip.com/en-us/tools-resources/develop/mplab-xc-compilers).

2. Luego habrá que instalar el IDE, `MPLAB X IDE`, que detectará el compilador automáticamente. También se descarga de la [misma página](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide).


## Creación del proyecto en MPLAB X IDE
1. Se irá a *File > New Project*.
    - *Microchip Embedded -- Standalone Project*. Next.
2. Se seleccionará lo siguiente:
    - Family: `16-bit DSCs (dsPIC33)`
    - Device: `dsPIC33FJ128MC802`
    - Tool  : `Simulator`
3. Se seleccionará el compilador `xc-16`.
4. Se pondrá nombre al proyecto.
    - Codificación: `ISO 8859-1`

## Configuración del proyecto
1. Poner la frecuencia del simulador a 3.6864 MHz:
    - *Production > Set Project Conf. > Customize > Simulador > Oscillator Options > Instruction frequency*
2. Abrir la ventana de cronómetro:
    - *Window > Debugging > Stopwatch*

## Importar los ficheros de cada práctica
Ahora tenemos

## Consideraciones
Por motivos desconocidos, sólo un fichero fuente puede estar presente en el proyecto. Para no tener que repetir todo este proceso de creación de proyecto para cada ejercicio de cada práctica, lo suyo es crear un nuevo fichero y quitar el anterior haciendo doble click y pulsando la opción *remove from project*. Eso elimina el fichero del listado, pero no del sistema de ficheros, es decir, no aparecerá en el IDE pero si vamos al directorio del proyecto, el fichero seguirá ahí sano y salvo.