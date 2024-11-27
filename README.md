# ICS3203-CAT2-Assembly-ValentineWanjiku_151775
Assembly language project for ICS3203 CAT2
# Assembly Tasks

This repository contains three assembly programs written in x86-64 NASM, demonstrating basic input handling, number classification, and array manipulation with reversal.

---

## Task 1: Number Classification
### Purpose
Classifies user input as:
- `ZERO` if the input is zero
- `POSITIVE` for positive numbers
- `NEGATIVE` for negative numbers
- `INVALID INPUT` for invalid cases (non-numeric or empty input)

### Instructions
1. Compile the code using NASM:
   ```bash
   nasm -f elf64 control_flow.asm -o control_flow.o
   ld control_flow.o -o control_flow
2. Run the program:
   ```bash
   ./control_flow

## Insights and Challenges
### Challenge: 
Handling invalid inputs such as empty strings or non-numeric characters.
### Insight: 
Incremental validation ensures robust input handling, and leveraging ASCII checks ('0'-'9') simplifies digit verification.

## Task 2: Array Manipulation and Reversal
### Purpose
Accepts five single-digit integers from the user, stores them in an array, reverses the array, and outputs the reversed order.

### Instructions
1. Compile the code using NASM:
   ```bash
   nasm -f elf64 array_reverse.asm -o array_reverse.o
   ld array_reverse.o -o array_reverse

2. Run the program:

   ```bash
   ./array_reverse

## Insights and Challenges

### Challenge:
Parsing the input correctly to extract digits and handle spaces or invalid characters.
### Insight:
 The use of a two-pointer approach for reversal (swapping elements from start and end) makes the implementation efficient.

### Task 3: Modular Program with Subroutines for Factorial Calculation

## Purpose
This program calculates the factorial of a number entered by the user, using a modular approach with subroutines. The program demonstrates stack usage for register preservation and restores the values after the calculation.

## Instructions
1. Compile the code using NASM:
   ```bash
   nasm -f elf64 factorial.asm -o factorial.o
   ld factorial.o -o factorial

2. Run the program:
   ```bash 
   ./factorial
   
## Insights and Challenges
 ### Challenge: 
 The challenge was managing the stack to preserve the values of registers 
 across subroutine calls.
 Ensuring that the appropriate registers (RAX, RBX, etc.) are preserved and 
 restored correctly was a key challenge to maintain program stability.

### Insight:
 
 Modular design helps isolate parsing, reversal, and 
 output logic for better maintainability.
   
### Task 4:  Data Monitoring and Control Using Port-Based Simulation

## Purpose
This program simulates a control system based on sensor input. The sensor value is read, and based on the level, the program performs different actions such as turning a motor on/off and triggering an alarm.

## Instructions
1. Compile the code using NASM:
   ```bash
   nasm -f elf64 port_control.asm -o port_control.o
   ld port_control.o -o port_control

2. Run the program:
   ```bash 
   ./port_control
   
## Insights and Challenges
 ### Challenge: 
 The challenge was ensuring the correct motor and alarm actions were 
 triggered based on the sensor value, which involved direct manipulation of 
 memory locations.

### Insight:
 
 Handling simulated input for the sensor and performing conditional checks 
 for high, moderate, and low levels required careful structuring.

 Simulating ports and memory addresses in assembly language can be tricky 
 since no physical hardware is involved, so proper abstraction and careful 
 coding were crucial.

   

 



 


