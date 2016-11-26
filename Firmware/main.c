/*
 * TinyTouch - main.c
 * (C) 2016 Conor Peterson
 * conor.p.peterson@gmail.com
 * http://www.conorpeterson.org
 * 
 * This software is licensed to you under the terms of the 
 * Creative Commons Attribution ShareAlike 4.0 International license
 * (CC BY-SA 4.0). See also https://creativecommons.org/licenses/by-sa/4.0/
 * 
 * You are free to share and adapt this software for any purpose, even commercially,
 * so long as you attribute the original author, and distribute your modifications
 * under the same license as the original.
 * 
 * 
 * This firmware runs on the TinyTouch, monitoring a capacitive touch sensor and
 * relaying the status via the DETECT line. The threshold is set via potentiometer
 * connected to ADC3 (PB4). Status of the sensor and detection is output on PB3
 * via PWM. Noise floor is adjusted automatically.
 * 
 * This firmware will run on any from the ATtiny25/45/85 line.
 * 
 */

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

//Major adjustments
#define WINDOW_LEN 8 //Store the last x readings for calculating touches. Power of 2.
#define NF_PERIOD 16 //Every NF_PERIOD samples, adjust the noise floor.

//Pin definitions - ATtiny25/45/85.
#define B_CAP_RECV	PB2
#define B_CAP_SEND	PB1
#define B_DETECT	PB4 //Externally pulled high, but driven normally
#define B_THRESH	PB3 //Set thresh via ADC3
#define B_MONITOR	PB0 //PWM visualizing via OC0A. Inverted logic.

//Port manipulation macros
#define SBI(port, pin) (port) |=  (1 << (pin))
#define CBI(port, pin) (port) &= ~(1 << (pin))

//Function definitions
void loop(void);
int main(void);
void adjust_threshold(void);
uint16_t sample(void);
int16_t sum_samples(void);
uint16_t sense(void);
ISR(TIMER1_COMPA_vect);
uint8_t analog_read(void);

//Global variables
int16_t noisefloor = 0;
uint8_t noisefloor_counter = NF_PERIOD;
int16_t samples[WINDOW_LEN];
uint8_t sample_cursor = 0;
uint8_t threshold = 3 * WINDOW_LEN;
volatile uint8_t event = 0;

//Interrupt on Timer1 OCIE1A controls the frequency of the sampling routine.
ISR(TIMER1_COMPA_vect)
{
	event = 1;
}

int main(void)
{
	cli(); //Disable interrupts
	
	//Timer1 is used for setting the sampling period.
	TCCR1 = _BV(CS13) | _BV(CS11) | _BV(CS10); //Prescale = /1024
	TCCR1 |= _BV(CTC1); //Clear timer on compare match C (freq. adj. via OCR1C)
	TIMSK = _BV(OCIE1A); //Interrupt on compare match A
	OCR1A = 0; //Request interrupt when TNCT1 rolls over to zero
	OCR1C = 161; //OCR1C adjusts of Timer1 -- NOTE approximately what frequency is this, 50Hz?
	
	//Timer0 is used for visualizing the state of the sensor via PWM-faded LED
	TCCR0A = _BV(WGM01) | _BV(WGM00); //Fast PWM mode with TOP as 0xFF (adjustable duty cycle mode)
	TCCR0A |= _BV(COM0A1) | _BV(COM0A0); //Set OC0A at compare match, clear OC0A at bottom (inverting mode)
	TCCR0B = _BV(CS01) | _BV(CS00); //Prescale /64
	OCR0A = 128; //Almost immediately overridden, but can help catch early hangs
	SBI(DDRB, B_MONITOR); //B_MONITOR as an output
	
	//ADC3 is used to adjust the sensitivity
	ADMUX = _BV(MUX1) | _BV(MUX0); //ADC3 (PB3 or pin 2)
	ADMUX |= _BV(ADLAR); //Left-adjusted results (8-bit mode)
	ADCSRA = _BV(ADEN); //Enable ADC
	ADCSRA |= _BV(ADPS1) | _BV(ADPS0); //ADC clock prescaled by /8
	DIDR0 = _BV(ADC3D); //Disable digital IO on ADC3 to save power
	
	//Pin configuration
	SBI(DDRB, B_DETECT); //B_DETECT as output
	CBI(PORTB, B_DETECT); //B_DETECT driven low
	
	//Establish baselines for the noisefloor and trigger threshold
	noisefloor = sample();
	adjust_threshold();
	
	sei();	//Enable interrupts
	
	for(;;) {
		loop();
	}

	return 0; //Never reached
}

void loop(void)
{
	int16_t reading;
	int16_t area;

	while( !event ) {};
	event = 0;
	
	reading = sample();
	
	if( ++noisefloor_counter >= NF_PERIOD ) {
		noisefloor_counter = 0;
		if( reading != noisefloor ) {
			noisefloor += (reading > noisefloor) ? 1 : -1;
		}
		
		//Occasionally sample ADC3 and adjust the threshold
		adjust_threshold();
	}
	
	reading -= noisefloor;
	
	samples[sample_cursor++] = reading;
	sample_cursor &= WINDOW_LEN;

	area = sum_samples();

	if( area > 0 ) {
		if( area > 255 || area > threshold ) {
			OCR0A = 255;
		} else {
			OCR0A = area; //Update monitor
		}
	} else {
		OCR0A = 0;
	}

    if( area > threshold ) {
		SBI(PORTB, B_DETECT); //B_DETECT driven HIGH
	} else {
		CBI(PORTB, B_DETECT); //B_DETECT driven LOW
	}
}

uint8_t analog_read(void)
{
	SBI(ADCSRA, ADSC); //Start conversion
	while( ADCSRA & _BV(ADSC) ) {}; //Wait for conversion to end
	return ADCH;
}

//Whenever a new sample is logged, it and several preceeding samples are summed and
//compared to threshold. I ran several experiments and found a useful range between 
//8 (WINDOW_LEN * 1) and 64 (WINDOW_LEN * 8), with a good compromise at 24 (WINDOW_LEN * 3).
//The threshold is adjusted by setting an analog pot, which is sampled and remapped every
//few sensing intervals.
void adjust_threshold(void)
{
	uint8_t value;
	value = analog_read();
	threshold = value;
}

//4X oversampling to reduce noise
uint16_t sample(void)
{
	uint32_t accum = 0;
	accum = sense();
	accum += sense();
	accum += sense();
	accum += sense();
	accum >>= 2;
	return (uint16_t)accum;
}

int16_t sum_samples(void)
{
	uint8_t i;
	int16_t accum = 0;
	for(i = 0; i < WINDOW_LEN; i++) {
		accum += samples[i];
	}
	return accum;
}

uint16_t sense(void)
{
	uint16_t counter = 0;
	
	//Totally discharge the sensor
	SBI(DDRB, B_CAP_SEND);  //Send as output
	SBI(DDRB, B_CAP_RECV);  //Receive as output

	CBI(PORTB, B_CAP_SEND); //Drive send LOW
	CBI(PORTB, B_CAP_RECV); //Drive receive LOW
	_delay_us(50); //wait...

	//Charge the sensor and watch the rise time.
	CBI(DDRB, B_CAP_RECV); //Recv now an input
	cli(); //Disable interrupts
	SBI(PORTB, B_CAP_SEND); //Drive send HIGH
	while( (PINB & _BV(B_CAP_RECV)) == 0  ) {
		counter++;
		//Catch timeouts - testing against zero appears free in assembled output.
		if( counter == 0 ) {
			break;
		}
	}
	sei(); //Re-enable interrupts
	//Finish the charge to VCC
	SBI(PORTB, B_CAP_RECV); //Recv pull-up on
	SBI(DDRB, B_CAP_RECV); //Recv as output
	_delay_us(50);
	CBI(DDRB, B_CAP_RECV); //Recv as input
	CBI(PORTB, B_CAP_RECV); //Recv floating
	cli(); //Disable interrupts
	CBI(PORTB, B_CAP_SEND); //Drive send LOW
	while( (PINB & _BV(B_CAP_RECV)) != 0 ) {
		counter++;
		if( counter == 0 ) {
			break;
		}
	}
	sei(); //Re-enable interrupts
	return counter;
}
