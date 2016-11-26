EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:TinyTouch-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "TinyTouch"
Date "2016-07-07"
Rev "1.0"
Comp "Conor Peterson"
Comment1 "conor.p.peterson@gmail.com"
Comment2 "CC BY-SA 4.0"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X03 P1
U 1 1 577EA5D0
P 2860 3650
F 0 "P1" H 2860 3850 50  0000 C CNN
F 1 "CONN_01X03" V 2960 3650 50  0001 C CNN
F 2 "TT_PCBParts:CONN_1x3_DIRECTSOLDER" H 2860 3650 50  0001 C CNN
F 3 "" H 2860 3650 50  0000 C CNN
	1    2860 3650
	-1   0    0    1   
$EndComp
$Comp
L R R1
U 1 1 577EA607
P 3560 3400
F 0 "R1" H 3460 3470 50  0000 C CNN
F 1 "10k" H 3440 3390 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 3490 3400 50  0001 C CNN
F 3 "" H 3560 3400 50  0000 C CNN
	1    3560 3400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 577EA62C
P 3810 3400
F 0 "R2" H 3920 3470 50  0000 C CNN
F 1 "2.2k" H 3950 3390 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 3740 3400 50  0001 C CNN
F 3 "" H 3810 3400 50  0000 C CNN
	1    3810 3400
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 577EA657
P 8450 2900
F 0 "R3" H 8330 2950 50  0000 C CNN
F 1 "1M" H 8330 2860 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 8380 2900 50  0001 C CNN
F 3 "" H 8450 2900 50  0000 C CNN
	1    8450 2900
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 577EA6A6
P 8600 2900
F 0 "R4" H 8710 2950 50  0000 C CNN
F 1 "1M" H 8710 2860 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 8530 2900 50  0001 C CNN
F 3 "" H 8600 2900 50  0000 C CNN
	1    8600 2900
	1    0    0    -1  
$EndComp
$Comp
L POT RV1
U 1 1 577EA6B1
P 8350 3800
F 0 "RV1" H 8350 3720 50  0000 C CNN
F 1 "10k" H 8350 3800 50  0000 C CNN
F 2 "TT_PCBParts:Bourns_SMD_Trimmer" H 8350 3800 50  0001 C CNN
F 3 "" H 8350 3800 50  0000 C CNN
	1    8350 3800
	0    -1   1    0   
$EndComp
$Comp
L ATTINY45-S IC1
U 1 1 577EA79B
P 6200 3650
F 0 "IC1" H 7320 4050 50  0000 C CNN
F 1 "ATTINY45-S" H 6940 4050 50  0000 C CNN
F 2 "Housings_SOIC:SOIJ-8_5.3x5.3mm_Pitch1.27mm" H 6450 4050 50  0001 C CIN
F 3 "" H 6200 3650 50  0000 C CNN
	1    6200 3650
	-1   0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 577EA85B
P 4780 3650
F 0 "C3" H 4805 3750 50  0000 L CNN
F 1 ".1uF" H 4805 3550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4818 3500 50  0001 C CNN
F 3 "" H 4780 3650 50  0000 C CNN
	1    4780 3650
	1    0    0    -1  
$EndComp
$Comp
L Led_Small D1
U 1 1 577EA987
P 3810 3750
F 0 "D1" V 3870 3590 50  0000 L CNN
F 1 "LED" V 3790 3550 50  0000 L CNN
F 2 "TT_PCBParts:LED_0805_HandSoldering" V 3810 3750 50  0001 C CNN
F 3 "" V 3810 3750 50  0000 C CNN
	1    3810 3750
	0    -1   -1   0   
$EndComp
Text Label 7550 3400 0    60   ~ 0
MONITOR
Text Label 7550 3500 0    60   ~ 0
CAP_SEND
Text Label 7550 3600 0    60   ~ 0
CAP_RECV
Text Label 7550 3700 0    60   ~ 0
THRESH_ADJ
Text Label 7550 3800 0    60   ~ 0
DETECT
NoConn ~ 7550 3900
Text Label 8350 2450 0    60   ~ 0
SENSOR
$Comp
L GND #PWR01
U 1 1 577F06F6
P 3060 4150
F 0 "#PWR01" H 3060 3900 50  0001 C CNN
F 1 "GND" H 3060 4000 50  0000 C CNN
F 2 "" H 3060 4150 50  0000 C CNN
F 3 "" H 3060 4150 50  0000 C CNN
	1    3060 4150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 577F09C6
P 3060 3150
F 0 "#PWR02" H 3060 3000 50  0001 C CNN
F 1 "+5V" H 3060 3290 50  0000 C CNN
F 2 "" H 3060 3150 50  0000 C CNN
F 3 "" H 3060 3150 50  0000 C CNN
	1    3060 3150
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 577F09EE
P 3060 3150
F 0 "#FLG03" H 3060 3245 50  0001 C CNN
F 1 "PWR_FLAG" V 3060 3500 50  0000 C CNN
F 2 "" H 3060 3150 50  0000 C CNN
F 3 "" H 3060 3150 50  0000 C CNN
	1    3060 3150
	0    -1   -1   0   
$EndComp
$Comp
L PWR_FLAG #FLG04
U 1 1 577F0B99
P 3060 4150
F 0 "#FLG04" H 3060 4245 50  0001 C CNN
F 1 "PWR_FLAG" V 3060 4500 50  0000 C CNN
F 2 "" H 3060 4150 50  0000 C CNN
F 3 "" H 3060 4150 50  0000 C CNN
	1    3060 4150
	0    -1   -1   0   
$EndComp
$Comp
L C C1
U 1 1 57812F35
P 4160 3650
F 0 "C1" H 4185 3750 50  0000 L CNN
F 1 "22uF" H 4185 3550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4198 3500 50  0001 C CNN
F 3 "" H 4160 3650 50  0000 C CNN
	1    4160 3650
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 57813C43
P 4470 3650
F 0 "C2" H 4495 3750 50  0000 L CNN
F 1 "22uF" H 4495 3550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4508 3500 50  0001 C CNN
F 3 "" H 4470 3650 50  0000 C CNN
	1    4470 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 2750 8300 2750
Wire Wire Line
	8300 2750 8300 2450
Wire Wire Line
	8300 2450 8350 2450
Wire Wire Line
	8350 2450 8350 2700
Wire Wire Line
	8350 2700 8400 2700
Wire Wire Line
	8400 2700 8400 2450
Wire Wire Line
	8400 2450 8450 2450
Wire Wire Line
	8450 2450 8450 2700
Wire Wire Line
	8450 2700 8500 2700
Wire Wire Line
	8500 2700 8500 2450
Wire Wire Line
	8500 2450 8550 2450
Wire Wire Line
	8550 2450 8550 2700
Wire Wire Line
	8550 2700 8600 2700
Wire Wire Line
	8600 2700 8600 2450
Wire Wire Line
	8600 2450 8650 2450
Wire Wire Line
	8650 2450 8650 2700
Wire Wire Line
	8650 2700 8700 2700
Wire Wire Line
	8700 2700 8700 2450
Wire Wire Line
	8700 2450 8750 2450
Wire Wire Line
	8750 2450 8750 2750
Wire Wire Line
	8750 2750 8600 2750
Wire Wire Line
	3060 3550 3060 3150
Wire Wire Line
	3060 3150 8350 3150
Wire Wire Line
	3560 3250 3560 3150
Connection ~ 3560 3150
Wire Wire Line
	3810 3250 3810 3150
Connection ~ 3810 3150
Wire Wire Line
	3060 3650 3560 3650
Wire Wire Line
	3560 3550 3560 4350
Wire Wire Line
	3810 3550 3810 3650
Wire Wire Line
	4160 3500 4160 3150
Connection ~ 4160 3150
Wire Wire Line
	3060 3750 3060 4150
Wire Wire Line
	3060 4150 8350 4150
Wire Wire Line
	4160 3800 4160 4150
Connection ~ 4160 4150
Wire Wire Line
	8350 3150 8350 3650
Wire Wire Line
	7550 3700 8200 3700
Wire Wire Line
	8200 3700 8200 3800
Wire Wire Line
	8350 4150 8350 3950
Wire Wire Line
	7550 3400 8150 3400
Wire Wire Line
	8150 3400 8150 4250
Wire Wire Line
	8150 4250 3810 4250
Wire Wire Line
	3810 4250 3810 3850
Wire Wire Line
	7550 3800 7650 3800
Wire Wire Line
	7650 3800 7650 4350
Wire Wire Line
	7650 4350 3560 4350
Connection ~ 3560 3650
Wire Wire Line
	7550 3500 8450 3500
Wire Wire Line
	8450 3500 8450 3050
Wire Wire Line
	7550 3600 8600 3600
Wire Wire Line
	8600 3600 8600 3050
Wire Wire Line
	4470 3800 4470 4150
Connection ~ 4470 4150
Wire Wire Line
	4470 3500 4470 3150
Connection ~ 4470 3150
Text Notes 3550 4870 0    60   ~ 0
Notes:\nR1: optional\nC1, C2: merge as appropriate\nR3, R4: substitute 330k - 3.3M to accommodate PCB layout variations
Wire Wire Line
	4780 3500 4780 3150
Connection ~ 4780 3150
Wire Wire Line
	4780 3800 4780 4150
Connection ~ 4780 4150
Wire Wire Line
	4850 3900 4780 3900
Connection ~ 4780 3900
Wire Wire Line
	4850 3400 4780 3400
Connection ~ 4780 3400
$EndSCHEMATC