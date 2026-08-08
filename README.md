# FIFO Verilog Project

## Overview

FIFO stands for First-In First-Out.

A FIFO is a memory structure in which the first data written into the FIFO is the first data read from it.

This project implements an 8-bit wide and 8-location synchronous FIFO using Verilog HDL.

## Features

- 8-bit data width
- 8 data locations
- Synchronous read and write operations
- Reset functionality
- Full flag
- Empty flag
- Verilog testbench
- Simulation using Icarus Verilog
- Waveform generation using GTKWave

## FIFO Operation

The FIFO follows the First-In First-Out principle.

For example:

Data written:

A1 → B2 → C3 → D4

Data read:

A1 → B2 → C3 → D4

Therefore, the first data entered is the first data removed.

## Block Diagram

```text
              +----------------------+
data_in ----->|                      |
              |        FIFO          |-----> data_out
wr_en ------->|                      |
rd_en ------->|                      |
clk --------->|                      |
rst --------->|                      |
              |                      |
              |   Full / Empty       |
              +----------------------+
                   |          |
                  full       empty