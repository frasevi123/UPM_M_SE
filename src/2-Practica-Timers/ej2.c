/*
 * File:   ejercicio_2_1.c
 * Author: ivan
 *
 * Created on 3 de noviembre de 2022, 10:13
 */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Practica 2: Timers                                                        *
 * Deben configurarse los timers 4 y 5 para que trabajen de forma conjunta,  *
 * debiendo generar una interrupción cada 5 s. Cada vez que se active la     *
 * interrupción debe cambiarse el estado del puerto 0 del puerto B.          *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */



// DSPIC33FJ128MC202 Configuration Bit Settings

// 'C' source line config statements

// FBS
#pragma config BWRP = WRPROTECT_OFF     // Boot Segment Write Protect (Boot Segment may be written)
#pragma config BSS = NO_FLASH           // Boot Segment Program Flash Code Protection (No Boot program Flash segment)
#pragma config RBS = NO_RAM             // Boot Segment RAM Protection (No Boot RAM)

// FSS
#pragma config SWRP = WRPROTECT_OFF     // Secure Segment Program Write Protect (Secure segment may be written)
#pragma config SSS = NO_FLASH           // Secure Segment Program Flash Code Protection (No Secure Segment)
#pragma config RSS = NO_RAM             // Secure Segment Data RAM Protection (No Secure RAM)

// FGS
#pragma config GWRP = OFF               // General Code Segment Write Protect (User program memory is not write-protected)
#pragma config GSS = OFF                // General Segment Code Protection (User program memory is not code-protected)

// FOSCSEL
#pragma config FNOSC = PRI              // Oscillator Mode (Primary Oscillator (XT, HS, EC))
#pragma config IESO = OFF               // Internal External Switch Over Mode (Start-up device with user-selected oscillator source)

// FOSC
#pragma config POSCMD = XT              // Primary Oscillator Source (XT Oscillator Mode)
#pragma config OSCIOFNC = OFF           // OSC2 Pin Function (OSC2 pin has clock out function)
#pragma config IOL1WAY = ON             // Peripheral Pin Select Configuration (Allow Only One Re-configuration)
#pragma config FCKSM = CSECMD           // Clock Switching and Monitor (Both Clock Switching and Fail-Safe Clock Monitor are disabled)

// FWDT
#pragma config WDTPOST = PS32768        // Watchdog Timer Postscaler (1:32,768)
#pragma config WDTPRE = PR128           // WDT Prescaler (1:128)
#pragma config WINDIS = OFF             // Watchdog Timer Window (Watchdog Timer in Non-Window mode)
#pragma config FWDTEN = OFF             // Watchdog Timer Enable (Watchdog timer enabled/disabled by user software)

// FPOR
#pragma config FPWRT = PWR128           // POR Timer Value (128ms)
#pragma config ALTI2C = OFF             // Alternate I2C  pins (I2C mapped to SDA1/SCL1 pins)
#pragma config LPOL = ON                // Motor Control PWM Low Side Polarity bit (PWM module low side output pins have active-high output polarity)
#pragma config HPOL = ON                // Motor Control PWM High Side Polarity bit (PWM module high side output pins have active-high output polarity)
#pragma config PWMPIN = OFF             // Motor Control PWM Module Pin Mode bit (PWM module pins controlled by PWM module at device Reset)

// FICD
#pragma config ICS = PGD1               // Comm Channel Select (Communicate on PGC1/EMUC1 and PGD1/EMUD1)
#pragma config JTAGEN = OFF             // JTAG Port Enable (JTAG is Disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include "xc.h"

void init_micro(void)
{
     RCONbits.SWDTEN = 0; // Disable Watchdog Timer

    // Configure Oscillator to operate the device at 40 Mhz
    // Fosc = Fin*M/(N1*N2), Fcy = Fosc/2
    // Fosc = 7.3728*XX/(X*X) = 79.2576 Mhz
    // Fcy = Fosc/2 = 39.6288 MHz

    // Configure PLL prescaler, PLL postscaler and PLL divisor

    PLLFBDbits.PLLDIV = 41; // M =  XX -> PLLDIV = XX - 2 = XX
    CLKDIVbits.PLLPOST = 0; // N2 = 2*(PLLPOST + 1) ? PLLPOST = (N2 / 2) - 1 (Output/N2)
    CLKDIVbits.PLLPRE = 0; // N1 = X + 2 (Input/N1)
    
    // clock switching to incorporate PLL
    __builtin_write_OSCCONH(0x03); // Initiate Clock Switch to Primary
    __builtin_write_OSCCONL(0x01); // Start clock switching

    while (OSCCONbits.COSC != 0b011); // Wait for Clock switch to occur
    while (OSCCONbits.LOCK != 1) {}; // Wait for PLL to lock (If LOCK = 1 -> PLL start-up timer is satisfied)

}

void init_ports(void)
{
    AD1PCFGL = 0XFFFF;
    TRISB = 0; 
}

void init_timer(void)
{
    TMR4 = 0;
    TMR5 = 0;
   
    PR4 = 0xCF70;
    PR5 = 0x000B;
    
    T4CONbits.TSIDL = 0;
    T4CONbits.TGATE = 0;
    T4CONbits.TCS = 0;
    T4CONbits.TCKPS = 0b11;
    T4CONbits.T32 = 1;
    
    T5CONbits.TSIDL = 0;
    
    IPC7bits.T5IP = 0b11;  /* Priority level */
    IFS1bits.T5IF = 0;  /* Clear interrupt flag */
    IEC1bits.T5IE = 1;  /* Enable T1 interrupts */
    
    T4CONbits.TON = 1;  /* Start timer */
}

void __attribute__((interrupt(no_auto_psv))) _TInterrupt(void)
{
    PORTBbits.RB1 = !LATBbits.LATB1;
    IFS1bits.T5IF = 0;
}

int main(void)
{
    init_micro();
    init_ports();
    init_timer();
    
    SRbits.IPL = 0;
    
    while(1);
    
    return 0;
}
