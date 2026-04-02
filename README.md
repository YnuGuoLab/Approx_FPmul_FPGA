# Approx_FPmul_FPGA

## Overview

This repository provides the Verilog source code and simulation files for the approximate floating-point multipliers proposed in the paper **"FPGA-Based Hardware Efficient Approximate Floating-Point Multiplier With LUT-Oriented Unit"**.
It includes:
- Proposed LUT-Oriented fix-point multipliers **LEIM** and **LEIM_6x6**
- Proposed hardware-efficient floating-point multipliers with various mantissa bits (5 bits and 8 bits).
  
All approximate floating-point multipliers are designed using LUT-oriented fixed-point multipliers as their basic unit. Designed for FPGA platforms, the approximate floating-point multipliers enable trade-offs between precision and power consumption while supporting flexible configurations.

---

## 📁Repository Structure

<pre>
├── Fix-point designs/                         # Contains 3×3 and 6×6 accurate fix-point multipliers        
│   ├── fix-point 3x3 multiplication/  
│   │   └── LEIM(3x3).v
│   └── fix-point 6x6 multiplication/
│   │   └── LEIM(6x6).v

  
├── Foating-point designs（5bit-mantissa）/    # Contains approximate floating-point multiplier with 5-bit mantissa
│   ├── mantissa central multiplication（LEIM）.v/                                   
│   └── mantissa peripheral summation（using carrychains）.v/
│   └── exponent summation.v/
│   └── whole FPmul structure（S、E、M）.v/

  
├── Foating-point designs（8bit-mantissa）/    # Contains approximate floating-point multiplier with 8-bit mantissa
│   ├── mantissa central multiplication（LEIM6x6）.v/                                   
│   └── mantissa peripheral summation（using carrychains）.v/
│   └── exponent summation.v/
│   └── whole FPmul structure（S、E、M）.v/
</pre>


---



## 🧪 Simulation & Synthesis

- **Simulation Tool:** Vivado Simulator  
- **Version:** Vivado 2018.3  
- **Target FPGA:** Xilinx 7-Series `xc7vx330tffg1157-2`

Before synthesizing, you need to set the synthesis mode of the designs to "full" in the settings.

---


## 💡 How to Use

1. Open Vivado and create a new project.
2. Import files from the directories.
3. Set `whole FPmul structure（S、E、M）.v` as the top module.
4. Modify parameters in `mantissa central multiplication （LEIM）.v`, `mantissa central multiplication （LEIM6x6）.v`, and `mantissa peripheral summation（using carry chains）.v` to explore different configurations.
5. **Synthesize the design**, then run simulation using `whole FPmul structure（S、E、M）.v`.
---
