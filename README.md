# RISC-V ALU Module

This project implements a 64-bit Arithmetic Logic Unit (ALU) compatible with the RISC-V architecture, using Verilog and simulated in Vivado.

##  Features

- Supports 10 operations:
  - ADD, SUB, AND, OR, XOR
  - SLL (Shift Left Logical)
  - SRL (Shift Right Logical)
  - SRA (Shift Right Arithmetic)
  - SLT (Set Less Than, signed)
  - SLTU (Set Less Than, unsigned)
- Outputs a `Zero` flag when the result is zero.

## Files Included

- `RISCVALU.v`: Verilog module implementing the ALU logic.
- `RISCVALU_tb.v`: Testbench verifying all ALU operations.
- `.gitignore`: Cleans the repo by ignoring Vivado-generated files and simulation artifacts.

## Simulation

The testbench runs all operations with sample inputs and prints the result and Zero flag.  
Simulation was verified using Vivado's behavioral simulation.

##  How to Run

1. Open the project in Vivado.
2. Add `RISCVALU.v` and `RISCVALU_tb.v` to your sources.
3. Run behavioral simulation on `RISCVALU_tb`.

## 📌 Notes

- Only essential source files are tracked in GitHub.
- All simulation logs, database files, and Vivado-generated folders are excluded via `.gitignore`.

---
