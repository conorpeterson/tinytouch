#TinyTouch
**Simple and reliable finger-to-PCB touch sensing**
By Conor Peterson - conor.p.peterson@gmail.com
CC BY-SA 4.0

##Project Description
This project demonstrates simple and reliable on/off capacitive touch sensing. It is designed for use in interactive artworks or museum displays but would be well-suited for any hardwired application that requires oversized, physically accessible buttons located a distance from the controlling hardware.

The project is built around an ATtiny microcontroller so is compatible with 5v and 3.3v systems. The output of the detection unit is a high/low signal that does not require debouncing. Presses of variable duration are detected within reasonable limits.

The sensing element is built into the PCB itself and is designed to be directly touched by the user for maximum reliability. Material may be placed over the sensing element but should be kept thin, no thicker than typing paper (~.003" / .08mm). Certain materials may require adjustment of sensitivity threshold, or more substantial adaptations including the sensing element resistors (R3 and R4), the sampling interval or possibly the clock speed of the microcontroller.

One of the challenges in capacitive touch sensing is that the measurements tend to drift according to changes in temperature and humidity. This design attempts to address this by calibrating the detection floor at startup and at regular intervals thereafter. Consequently the sensor is best suited for momentary presses only - continuous contact for more than several seconds is to be avoided.

##Contents
###Firmware:
This folder contains the source code for the ATtiny25/45/85 microcontroller. It has been tested to compile within a Linux environment using avr-gcc 4.9.2 and avr-libc 1.8.0. The bin subfolder contains pre-compiled hex files suitable for flashing with avrdude. NOTE: you must alter the fuse bits so that the chip runs at 8 MHz; this can be done by invoking the "fuses" target in the supplied makefile.

###Schematic:
Contains a Kicad 4.x schematic for the project, plus a the reference PCB layout and fabrication-ready gerbers. The artwork in the TT_SMT_GRAPHICS subfolder can be modified and passed through Kicad's bitmap-to-component converter to create the custom touch sensor soldermask.

##License
The contents of this project are provided under a Creative Commons Attribution-ShareAlike 4.0 license.
(https://creativecommons.org/licenses/by-sa/4.0/legalcode)

You are free to:
Share — copy and redistribute the material in any medium or format
Adapt — remix, transform, and build upon the material for any purpose, even commercially.
Under the following terms:
Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
