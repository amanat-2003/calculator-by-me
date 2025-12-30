# Master Experience Document: Scientific Calculator Application

## Project Overview
Developed a feature-rich scientific calculator application using Flutter (cross-platform mobile & desktop) that goes beyond basic arithmetic to support advanced mathematical operations with a professional UI implementation.

## Core Architecture & Logic Built

### 1. Expression Evaluation Engine (Postfix Notation Converter & Evaluator)
- Implemented infix-to-postfix expression conversion algorithm using the Shunting Yard algorithm with precedence-based operator handling
- Built a custom stack-based postfix expression evaluator that processes converted expressions to compute results
- Implemented precedence rules distinguishing between operators: binary operators (`+`, `-`, `*`, `/`, `^`), unary operators (`sin`, `cos`, `tan`, `log`, `ln`, `sqrt`, `factorial`, `inverse`), and parentheses handling
- Handled both unary and binary operator logic within the evaluation pipeline

### 2. Mathematical Operations Support
- Implemented comprehensive trigonometric functions: `sin()`, `cos()`, `tan()` and their inverse variants (`asin()`, `acos()`, `atan()`)
- Integrated logarithmic operations: base-10 logarithm (`lg`) and natural logarithm (`ln`)
- Implemented power operations (`x^y`), square root, factorial, reciprocal (`1/x`), and percentage calculations
- Added mathematical constants: π (pi) and e (Euler's number)

### 3. Input Processing & Display Transformation
- Built a dual-representation system for user input: 
  - Internal representation using single-character codes for efficient parsing (e.g., `s` for `sin`, `c` for `cos`, `L` for `log`)
  - Display representation showing user-friendly mathematical notation (e.g., `sin`, `cos`, `log`)
- Implemented input string to base string converter that replaces symbolic constants with their actual mathematical values for computation

### 4. UI State Management & User Interaction
- Implemented stateful widget with multi-mode calculator:
  - **Standard mode**: Basic operations with 4-column grid layout
  - **Extended mode**: Scientific functions with 5-column grid layout
  - **2nd function mode**: Toggle between primary and secondary operations (e.g., `sin` ↔ `asin`)
- Built real-time expression display synchronization with user input
- Implemented responsive grid layout (`GridUnScrollable`) that dynamically adapts button distribution based on mode

### 5. Custom Data Structures
- Created `Operandor` class to represent both operands (doubles) and operators with metadata tracking (unary vs binary)
- Built `StringOfOperandors` class to manage expression as a list of operands/operators with parsing logic from user input strings

## Technical Highlights
- **Operator Precedence Handling**: Correctly implements precedence levels for reliable mathematical expression evaluation
- **Stack-based Processing**: Efficient use of stacks for both infix-to-postfix conversion and evaluation
- **Cross-platform UI**: Built responsive UI that works across Flutter-supported platforms (iOS, Android, Web, Desktop)
- **Code Modularity**: Separated concerns across files (`eval_postfix.dart` for math logic, `inptxt_to_display.dart` for I/O transformations, `extra_math.dart` for utilities)

## Key Features Implemented
- Multi-operator expression evaluation with correct precedence
- Extended function library with trigonometric, logarithmic, and algebraic operations
- Mode switching for basic and advanced calculations
- Clean mathematical notation in UI while maintaining efficient internal representation
- Error handling for various mathematical operations (division, domain-specific functions)

## Problem-Solving Demonstrated
- Designed a parser that handles complex mathematical expressions with varying operator types
- Solved the precedence and associativity problem for reliable expression evaluation
- Created an elegant mapping system between user input codes and display/computation representations
- Built a scalable UI component system (`FlatButton`, `GridUnScrollable`) for flexible layout management

## Technologies Used
- **Framework**: Flutter/Dart
- **Algorithms**: Shunting Yard algorithm, Stack-based evaluation
- **Architecture**: Stateful widget management, modular code design
- **Platforms**: Cross-platform (iOS, Android, Web, Windows, macOS, Linux)
