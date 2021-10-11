/* Copyright 2020 Gniewko Kuraczyk
 * MSc thesis - Implementation of DSP co-processor in Xilinx Zynq Soc - Politechnika Gdanska
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Package: risc_alu_pkg
 *
 * ALU package.
 */
package risc_alu_pkg;
    /* Enum: alu_opcodes_t
     * Opcodes definition for ALU module.
     * [5:4]  - type
     * [3]    - subtype
     * [2:1]  - operation
     * [0]  - signed
     */
    typedef enum logic [5:0] {
	OP_ADD    	    = 6'b000001,
	OP_SUB    	    = 6'b000011,
	OP_MUL    	    = 6'b000101,
	OP_DIV    	    = 6'b000111,

	OP_AND    	    = 6'b010000,
	OP_OR     	    = 6'b010010,
	OP_XOR    	    = 6'b010100,

	OP_SLA    	    = 6'b100000,
	OP_SRA    	    = 6'b100010,
	OP_SLL    	    = 6'b101100,
	OP_SRL    	    = 6'b101110,

	OP_SLT    	    = 6'b110001,
	OP_SLTU   	    = 6'b110000,
	OP_SGT    	    = 6'b110011,
	OP_SGTU   	    = 6'b110010,
	OP_SEQ    	    = 6'b110100,
	OP_SNE    	    = 6'b110110
    } risc_alu_opcodes_t;

    /* Enum: alu_optypes_t
     * Operation types definition for ALU module.
     */
    typedef enum logic [1:0] {
	OP_TYPE_ARITHMETIC  = 2'b00,
    OP_TYPE_LOGIC       = 2'b01,
    OP_TYPE_SHIFT       = 2'b10,
    OP_TYPE_COMPARE     = 2'b11
    } risc_alu_optypes_t;

    /* Enum: alu_shift_subtypes_t
     * Operation types definition for ALU module.
     */
    typedef enum logic [1:0] {
	SHIFT_SUBTYPE_ARITHMETIC    = 2'b0,
    SHIFT_SUBTYPE_LOGIC         = 2'b1
    } risc_alu_shift_subtypes_t;
  

    /* Enum: alu_flags_t
     * Flag numbers for ALU module. 
     */
    typedef enum logic [2:0] {
	F_ZERO        	    = 0,
	F_SIGN        	    = 1,
	F_OVERFLOW    	    = 2,
	F_UNDERFLOW   	    = 3,
	F_ZERO_DIV    	    = 4
    } risc_alu_flags_t;
endpackage
