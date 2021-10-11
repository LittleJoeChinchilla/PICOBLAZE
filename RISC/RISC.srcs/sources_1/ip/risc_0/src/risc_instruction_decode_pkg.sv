package risc_instruction_decode_pkg;
	
	typedef enum logic [6:0] {
		RISC_INSTRUCTION_FUNC7_ARITHMETIC 		= 7'd0,
		RISC_INSTRUCTION_FUNC7_LOGIC			= 7'd1,
		RISC_INSTRUCTION_FUNC7_SHIFT_ARITHMETIC	= 7'd2,
		RISC_INSTRUCTION_FUNC7_SHIFT_LOGIC 		= 7'd3,
		RISC_INSTRUCTION_FUNC7_COMPARE			= 7'd4,
		RISC_INSTRUCTION_FUNC7_UNDEFINED		= 7'h7F
	} risc_instruction_func7_t;
	
	typedef enum logic [2:0] {
		RISC_INSTRUCTION_FUNC3_0 = 3'd0,
		RISC_INSTRUCTION_FUNC3_1 = 3'd1,
		RISC_INSTRUCTION_FUNC3_2 = 3'd2,
		RISC_INSTRUCTION_FUNC3_3 = 3'd3,
		RISC_INSTRUCTION_FUNC3_4 = 3'd4,
		RISC_INSTRUCTION_FUNC3_5 = 3'd5,
		RISC_INSTRUCTION_FUNC3_6 = 3'd6,
		RISC_INSTRUCTION_FUNC3_7 = 3'd7
	} risc_instruction_func3_t;
	
	typedef enum logic [6:0] {
		RISC_INSTRUCTION_OPCODE_R 			= 7'd0,
		RISC_INSTRUCTION_OPCODE_I 			= 7'd1,
		RISC_INSTRUCTION_OPCODE_S 			= 7'd2,
		RISC_INSTRUCTION_OPCODE_L 			= 7'd3,
		RISC_INSTRUCTION_OPCODE_B 			= 7'd4,
		RISC_INSTRUCTION_OPCODE_J 			= 7'd5,
		RISC_INSTRUCTION_OPCODE_RAS 		= 7'd6,
		RISC_INSTRUCTION_OPCODE_UNDEFINED 	= 7'h7F
	} risc_instruction_opcode_t;
	
	typedef struct {
		// synthesis translate_off
		string mnemotype;
		// synthesis translate_on
		risc_instruction_opcode_t 	opcode;
		risc_instruction_func7_t	func7;
		risc_instruction_func3_t 	func3;
		logic [ 4:0] 				rd;
		logic [ 4:0] 				rs1;
		logic [ 4:0] 				rs2;
		logic signed [20:0]			arg;
	} risc_instruction_t;
	
	function risc_instruction_opcode_t get_risc_instruction_type (input logic [31:0] data);
		case (data[6:0])
			7'd0:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_R;
			7'd1:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_I;
			7'd2:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_S;
			7'd3:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_L;
			7'd4:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_B;
			7'd5:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_J;
			7'd6:		get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_RAS;
			default:	get_risc_instruction_type = RISC_INSTRUCTION_OPCODE_UNDEFINED;
		endcase
	endfunction

	function risc_instruction_func7_t get_risc_instruction_func7 (input logic [31:0] data);
		case (data[31:25])		
			7'd0:		get_risc_instruction_func7 = RISC_INSTRUCTION_FUNC7_ARITHMETIC;
			7'd1:		get_risc_instruction_func7 = RISC_INSTRUCTION_FUNC7_LOGIC;
			7'd2:		get_risc_instruction_func7 = RISC_INSTRUCTION_FUNC7_SHIFT_ARITHMETIC;
			7'd3:		get_risc_instruction_func7 = RISC_INSTRUCTION_FUNC7_SHIFT_LOGIC;
			7'd4:		get_risc_instruction_func7 = RISC_INSTRUCTION_FUNC7_COMPARE;
			default:	get_risc_instruction_func7 = RISC_INSTRUCTION_FUNC7_UNDEFINED;
		endcase
	endfunction

	// synthesis translate_off
	function string get_risc_mnemotype(logic [31:0] data);
		int int_arg;
		if 		(data[31: 0] === 32'bx)					     		$sformat(get_risc_mnemotype, "xxxx");
		else if (data[31: 0] == 32'b0)							 	$sformat(get_risc_mnemotype, "NOP");
		else if (data[ 6: 0] == 7'd0) begin
			if 		(data[31:25] == 7'd0 && data[14:12] == 3'd0) 	$sformat(get_risc_mnemotype, "ADD, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd0 && data[14:12] == 3'd1) 	$sformat(get_risc_mnemotype, "SUB, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd0 && data[14:12] == 3'd2) 	$sformat(get_risc_mnemotype, "MUL, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd0 && data[14:12] == 3'd3) 	$sformat(get_risc_mnemotype, "DIV, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd1 && data[14:12] == 3'd0) 	$sformat(get_risc_mnemotype, "AND, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd1 && data[14:12] == 3'd1) 	$sformat(get_risc_mnemotype, "OR, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd1 && data[14:12] == 3'd2) 	$sformat(get_risc_mnemotype, "XOR, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd2 && data[14:12] == 3'd0) 	$sformat(get_risc_mnemotype, "SLA, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd2 && data[14:12] == 3'd1) 	$sformat(get_risc_mnemotype, "SRA, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd3 && data[14:12] == 3'd0) 	$sformat(get_risc_mnemotype, "SLL, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd3 && data[14:12] == 3'd1) 	$sformat(get_risc_mnemotype, "SRL, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd4 && data[14:12] == 3'd0) 	$sformat(get_risc_mnemotype, "SLT, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd4 && data[14:12] == 3'd1) 	$sformat(get_risc_mnemotype, "SLTU, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd4 && data[14:12] == 3'd2) 	$sformat(get_risc_mnemotype, "SGT, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd4 && data[14:12] == 3'd3) 	$sformat(get_risc_mnemotype, "SGTU, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd4 && data[14:12] == 3'd4) 	$sformat(get_risc_mnemotype, "SEQ, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
			else if (data[31:25] == 7'd4 && data[14:12] == 3'd5) 	$sformat(get_risc_mnemotype, "SNE, R%0d, R%0d, R%0d", data[11:7], data[19:15], data[24:20]);
		end
		else if (data[ 6: 0] == 7'd1) begin
			if 		(data[14:12] == 3'd0) 							$sformat(get_risc_mnemotype, "ADDI, R%0d, R%0d, %0d", data[11:7], data[19:15], data[31:20]);
			else if (data[14:12] == 3'd1) 							$sformat(get_risc_mnemotype, "SLTI, R%0d, %0d", data[11:7], data[31:20]);
			else if (data[14:12] == 3'd2) 							$sformat(get_risc_mnemotype, "SLTIU, R%0d, %0d", data[11:7], data[31:20]);
			else if (data[14:12] == 3'd3 && data[31:25] == 7'd0) 	$sformat(get_risc_mnemotype, "SLLI, R%0d, %0d", data[11:7], data[24:20]);
			else if (data[14:12] == 3'd3 && data[31:25] == 7'd1) 	$sformat(get_risc_mnemotype, "SRLI, R%0d, %0d", data[11:7], data[24:20]);
			else if (data[14:12] == 3'd3 && data[31:25] == 7'd2) 	$sformat(get_risc_mnemotype, "SLAI, R%0d, %0d", data[11:7], data[24:20]);
			else if (data[14:12] == 3'd3 && data[31:25] == 7'd3) 	$sformat(get_risc_mnemotype, "SRAI, R%0d, %0d", data[11:7], data[24:20]);
			else if (data[14:12] == 3'd4) 							$sformat(get_risc_mnemotype, "ANDI, R%0d, R%0d, %0d", data[11:7], data[19:15], data[31:20]);
			else if (data[14:12] == 3'd5) 							$sformat(get_risc_mnemotype, "ORI, R%0d, R%0d, %0d", data[11:7], data[19:15], data[31:20]);
			else if (data[14:12] == 3'd6) 							$sformat(get_risc_mnemotype, "XORI, R%0d, R%0d, %0d", data[11:7], data[19:15], data[31:20]);
		end
		else if (data[ 6: 0] == 7'd2)								$sformat(get_risc_mnemotype, "STORE, R%0d, R%0d, %0d, %0d", data[19:15], data[24:20], {data[31:25], data[11:7]}, data[14:12]);
		else if (data[ 6: 0] == 7'd3)								$sformat(get_risc_mnemotype, "LOAD, R%0d, R%0d, %0d, %0d", data[11: 7], data[19:15], data[31:20], data[14:12]);
		else if (data[ 6: 0] == 7'd4) begin
			int_arg = $signed({data[31:25], data[11:8], 1'b0});
			if 		(data[14:12] == 3'd0)							$sformat(get_risc_mnemotype, "BEQ, R%0d, R%0d, %0d", data[19:15], data[24:20], int_arg);
			else if (data[14:12] == 3'd1) 							$sformat(get_risc_mnemotype, "BNE, R%0d, R%0d, %0d", data[19:15], data[24:20], int_arg);
			else if (data[14:12] == 3'd2) 							$sformat(get_risc_mnemotype, "BLT, R%0d, R%0d, %0d", data[19:15], data[24:20], int_arg); 
			else if (data[14:12] == 3'd3) 							$sformat(get_risc_mnemotype, "BLTU, R%0d, R%0d, %0d", data[19:15], data[24:20], int_arg); 
			else if (data[14:12] == 3'd4) 							$sformat(get_risc_mnemotype, "BGE, R%0d, R%0d, %0d", data[19:15], data[24:20], int_arg); 
			else if (data[14:12] == 3'd5) 							$sformat(get_risc_mnemotype, "BGEU, R%0d, R%0d, %0d", data[19:15], data[24:20], int_arg); 
		end 
		else if (data[ 6:0] == 7'd5) begin
			int_arg = $signed({data[31], data[19:12], data[20], data[30:21], 1'b0});
			$sformat(get_risc_mnemotype, "JAL R%0d, %0d", data[11:7], int_arg);
		end
		else if (data[ 6:0] == 7'd6) begin
			int_arg = $signed(data[31:20]);
			$sformat(get_risc_mnemotype, "JALR R%0d, R%0d, %0d", data[11:7], data[19:15], int_arg);
		end		
	endfunction
	// synthesis translate_on
	
	task get_risc_instruction (input logic [31:0] data, output risc_instruction_t instr);
		// synthesis translate_off
		instr.mnemotype = get_risc_mnemotype(data);
		// synthesis translate_on
		case (data[6:0])
			RISC_INSTRUCTION_OPCODE_R: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_R;
				instr.func7 	= (risc_instruction_func7_t)'(data[31:25]);
				instr.func3 	= (risc_instruction_func3_t)'(data[14:12]);
				instr.rd		= data[11: 7];
				instr.rs1		= data[19:15];
				instr.rs2		= data[24:20];
				instr.arg		= '0;
			end
			RISC_INSTRUCTION_OPCODE_I: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_I;
				instr.func7 	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3 	= (risc_instruction_func3_t)'(data[14:12]);
				instr.rd		= data[11: 7];
				instr.rs1		= data[19:15];
				instr.rs2 		= '0;
				instr.arg		= { { (9) { data[31] } }, data[31:20]};
			end
			RISC_INSTRUCTION_OPCODE_S: begin
				instr.opcode 	= RISC_INSTRUCTION_OPCODE_S;
				instr.func7  	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3 	= (risc_instruction_func3_t)'(data[14:12]);
				instr.rd		= '0;
				instr.rs1		= data[19:15];
				instr.rs2 		= data[24:20];
				instr.arg 		= { { (9) { data[31] } }, data[31:25], data[11:7]};
			end
			RISC_INSTRUCTION_OPCODE_L: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_L;
				instr.func7 	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3 	= (risc_instruction_func3_t)'(data[14:12]);
				instr.rd		= data[11: 7];
				instr.rs1		= data[19:15];
				instr.rs2 		= '0;
				instr.arg		= { { (9) { data[31] } }, data[31:20]};
			end
			RISC_INSTRUCTION_OPCODE_B: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_B;
				instr.func7 	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3 	= (risc_instruction_func3_t)'(data[14:12]);
				instr.rd		= '0;
				instr.rs1		= data[19:15];
				instr.rs2 		= data[24:20];
				instr.arg		= { { (9) { data[31] } }, data[7], data[30:25], data[11:8], 1'b0};
			end
			RISC_INSTRUCTION_OPCODE_J: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_J;
				instr.func7 	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3		= RISC_INSTRUCTION_FUNC3_0;
				instr.rd		= data[11 :7];
				instr.rs1		= '0;
				instr.rs2		= '0;
				instr.arg		= {data[31], data[19:12], data[20], data[30:21], 1'b0};
			end
			RISC_INSTRUCTION_OPCODE_RAS: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_RAS;
				instr.func7 	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3		= RISC_INSTRUCTION_FUNC3_0;
				instr.rd		= data[11: 7];
				instr.rs1		= data[19:15];
				instr.rs2		= '0;
				instr.arg		= data[31:20];		
			end
			default: begin
				instr.opcode	= RISC_INSTRUCTION_OPCODE_UNDEFINED;
				instr.func7 	= RISC_INSTRUCTION_FUNC7_UNDEFINED;
				instr.func3 	= RISC_INSTRUCTION_FUNC3_0;
				instr.rd		= '0;
				instr.rs1		= '0;
				instr.rs2 		= '0;
				instr.arg		= '0;
			end
		endcase
	endtask
	
	function logic [4:0] get_risc_instruction_rd(input logic [31:0] data);
		case (risc_instruction_opcode_t'(data[6:0]))
			RISC_INSTRUCTION_OPCODE_R: get_risc_instruction_rd = data[11: 7];
			RISC_INSTRUCTION_OPCODE_I: get_risc_instruction_rd = data[11: 7];
			RISC_INSTRUCTION_OPCODE_S: get_risc_instruction_rd = '0;
			RISC_INSTRUCTION_OPCODE_L: get_risc_instruction_rd = data[11: 7];
			RISC_INSTRUCTION_OPCODE_B: get_risc_instruction_rd = '0;
			RISC_INSTRUCTION_OPCODE_J: get_risc_instruction_rd = data[11: 7];
			RISC_INSTRUCTION_OPCODE_RAS: get_risc_instruction_rd = data[11: 7];
			default: get_risc_instruction_rd = '0;
		endcase
	endfunction
	
	function logic [4:0] get_risc_instruction_rs1(input logic [31:0] data);
		case (risc_instruction_opcode_t'(data[6:0]))
			RISC_INSTRUCTION_OPCODE_R: get_risc_instruction_rs1 = data[19:15];
			RISC_INSTRUCTION_OPCODE_I: get_risc_instruction_rs1 = data[19:15];
			RISC_INSTRUCTION_OPCODE_S: get_risc_instruction_rs1 = data[19:15];
			RISC_INSTRUCTION_OPCODE_L: get_risc_instruction_rs1 = data[19:15];
			RISC_INSTRUCTION_OPCODE_B: get_risc_instruction_rs1 = data[19:15];
			RISC_INSTRUCTION_OPCODE_J: get_risc_instruction_rs1 = '0;
			RISC_INSTRUCTION_OPCODE_RAS: get_risc_instruction_rs1 = data[19:15];
			default: get_risc_instruction_rs1 = '0;
		endcase
	endfunction

	function logic [4:0] get_risc_instruction_rs2(input logic [31:0] data);
		case (risc_instruction_opcode_t'(data[6:0]))
			RISC_INSTRUCTION_OPCODE_R: get_risc_instruction_rs2 = data[24:20];
			RISC_INSTRUCTION_OPCODE_I: get_risc_instruction_rs2 = '0;
			RISC_INSTRUCTION_OPCODE_S: get_risc_instruction_rs2 = data[24:20];
			RISC_INSTRUCTION_OPCODE_L: get_risc_instruction_rs2 = '0;
			RISC_INSTRUCTION_OPCODE_B: get_risc_instruction_rs2 = data[24:20];
			default: get_risc_instruction_rs2 = '0;
		endcase
	endfunction
	
// synthesis translate_off	
	typedef logic signed [12:0] arg_t;
	typedef logic signed [20:0] jal_arg_t;
	function logic [31:0] set_risc_instruction(string instruction);
		int rs1, rs2, rd, arg, w;
    	int code;
    	string op,tmp;
		arg_t bit_arg;
		jal_arg_t jal_bit_arg;
		code = $sscanf(instruction, "%s %s", op, tmp);
		if (op == "NOP") set_risc_instruction = '0;
		// J type
		else if (op == "JAL") begin
			$sscanf(instruction, "%s R%0d, %0d", op, rd, arg);
			jal_bit_arg = jal_arg_t'(arg);
			set_risc_instruction[31   ] = jal_bit_arg[20   ];
			set_risc_instruction[30:21] = jal_bit_arg[10: 1];
			set_risc_instruction[20   ] = jal_bit_arg[11   ];
			set_risc_instruction[19:12] = jal_bit_arg[19:12];
			set_risc_instruction[11: 7] = rd;
			set_risc_instruction[ 6: 0] = 7'd5;					
		end
		else if (op == "JALR") begin
			$sscanf(instruction, "%s R%0d, R%0d, %0d", op, rd, rs1, arg);
			jal_bit_arg = jal_arg_t'(arg);
			set_risc_instruction[31:20] = jal_bit_arg[11:0];
			set_risc_instruction[19:15] = rs1;
			set_risc_instruction[14:12] = 0;
			set_risc_instruction[11: 7] = rd;
			set_risc_instruction[ 6: 0] = 7'd6;					
		end
		// S type
		else if (op == "STORE") begin
			code = $sscanf(instruction, "%s R%0d, R%0d, %0d, %0d", op, rs1, rs2, arg, w);
			if (code == 5 && op == "STORE") begin
				bit_arg = arg_t'(arg);
				set_risc_instruction[14:12] = w; 				// width / slave select
				set_risc_instruction[19:15] = rs1;				// base address
				set_risc_instruction[24:20] = rs2;				// source
				set_risc_instruction[31:25] = bit_arg[11:5];	// offset H
				set_risc_instruction[11: 7] = bit_arg[ 4:0];	// offset L
				set_risc_instruction[ 6: 0] = 7'd2;
			end
		end
		// L type
		else if (op == "LOAD") begin
			code = $sscanf(instruction, "%s R%0d, R%0d, %0d, %0d", op, rd, rs1, arg, w);
			if (code == 5 && op == "LOAD") begin
				bit_arg = arg_t'(arg);
				set_risc_instruction[31:20] = bit_arg;			// offset
				set_risc_instruction[19:15] = rs1;				// base address
				set_risc_instruction[14:12] = w; 				// width / slave select
				set_risc_instruction[11: 7] = rd;				// destination
				set_risc_instruction[ 6: 0] = 7'd3;
			end
		end
		// B type
		else if (op[0] == "B") begin
			code = $sscanf(instruction, "%s R%0d, R%0d, %0d", op, rs1, rs2, arg);
			if (code == 4) begin
				bit_arg = arg_t'(arg);
				set_risc_instruction[31] 	= bit_arg[12];			
				set_risc_instruction[30:25] = bit_arg[10:5];		
				set_risc_instruction[24:20] = rs2;	
				set_risc_instruction[19:15] = rs1;	
				set_risc_instruction[11: 8] = bit_arg[4:1];	
				set_risc_instruction[7] 	= bit_arg[11];	
				set_risc_instruction[ 6: 0] = 7'd4;
				if 		(op == "BEQ" ) 		set_risc_instruction[14:12] = 3'd0; 
				else if (op == "BNE" ) 		set_risc_instruction[14:12] = 3'd1; 
				else if (op == "BLT" ) 		set_risc_instruction[14:12] = 3'd2; 
				else if (op == "BLTU") 		set_risc_instruction[14:12] = 3'd3; 
				else if (op == "BGE" ) 		set_risc_instruction[14:12] = 3'd4; 
				else if (op == "BGEU") 		set_risc_instruction[14:12] = 3'd5; 
			end
		end
		// I type
		else if (op[op.len-1] == "I" || op == "SLTIU") begin
			code = $sscanf(instruction, "%s R%0d, R%0d, %0d", op, rd, rs1, arg);
			if (code == 4) begin
				set_risc_instruction = '0;
				if (op == "ADDI") begin
					set_risc_instruction[14:12] = 3'd0; //func3
				end
				else if (op == "SLTI") begin
					set_risc_instruction[14:12] = 3'd1; //func3
				end
				else if (op == "SLTIU") begin
					set_risc_instruction[14:12] = 3'd2; //func3
				end
				else if (op == "SLLI") begin
					set_risc_instruction[14:12] = 3'd3; //func3
					arg = arg + 0;
				end
				else if (op == "SRLI") begin
					set_risc_instruction[14:12] = 3'd3; //func3
					arg = arg + 32;
				end
				else if (op == "SLAI") begin
					set_risc_instruction[14:12] = 3'd3; //func3
					arg = arg + 64;
				end
				else if (op == "SRAI") begin
					set_risc_instruction[14:12] = 3'd3; //func3
					arg = arg + 96;
				end
				else if (op == "ANDI") begin
					set_risc_instruction[14:12] = 3'd4; //func3
				end
				else if (op == "ORI") begin
					set_risc_instruction[14:12] = 3'd5; //func3
				end
				else if (op == "XORI") begin
					set_risc_instruction[14:12] = 3'd6; //func3
				end
				set_risc_instruction[19:15] = rs1;
				set_risc_instruction[31:20] = arg;
				set_risc_instruction[11: 7] = rd;
				set_risc_instruction[ 6: 0] = 7'd1;
			end
		end
		// R type
		else begin
	 		code = $sscanf(instruction, "%s R%0d, R%0d, R%0d", op, rd, rs1, rs2);
			if (code == 4) begin	//R type
				set_risc_instruction = '0;
				set_risc_instruction[19:15] = rs1;
				set_risc_instruction[24:20] = rs2;
				set_risc_instruction[11: 7] = rd;
				if 		(op == "ADD") begin
					set_risc_instruction[31:25] = 7'd0; //func7
					set_risc_instruction[14:12] = 3'd0; //func3
				end
				else if (op == "SUB") begin
					set_risc_instruction[31:25] = 7'd0; //func7
					set_risc_instruction[14:12] = 3'd1; //func3
				end
				else if (op == "MUL") begin
					set_risc_instruction[31:25] = 7'd0; //func7
					set_risc_instruction[14:12] = 3'd2; //func3
				end
				else if (op == "DIV") begin
					set_risc_instruction[31:25] = 7'd0; //func7
					set_risc_instruction[14:12] = 3'd3; //func3
				end
				else if (op == "AND") begin
					set_risc_instruction[31:25] = 7'd1; //func7
					set_risc_instruction[14:12] = 3'd0; //func3
				end
				else if (op == "OR") begin
					set_risc_instruction[31:25] = 7'd1; //func7
					set_risc_instruction[14:12] = 3'd1; //func3
				end
				else if (op == "XOR") begin
					set_risc_instruction[31:25] = 7'd1; //func7
					set_risc_instruction[14:12] = 3'd2; //func3
				end
				else if (op == "SLA") begin
					set_risc_instruction[31:25] = 7'd2; //func7
					set_risc_instruction[14:12] = 3'd0; //func3
				end
				else if (op == "SRA") begin
					set_risc_instruction[31:25] = 7'd2; //func7
					set_risc_instruction[14:12] = 3'd1; //func3
				end
				else if (op == "SLL") begin
					set_risc_instruction[31:25] = 7'd3; //func7
					set_risc_instruction[14:12] = 3'd0; //func3
				end
				else if (op == "SRL") begin
					set_risc_instruction[31:25] = 7'd3; //func7
					set_risc_instruction[14:12] = 3'd1; //func3
				end
				else if (op == "SLT") begin
					set_risc_instruction[31:25] = 7'd4; //func7
					set_risc_instruction[14:12] = 3'd0; //func3
				end
				else if (op == "SLTU") begin
					set_risc_instruction[31:25] = 7'd4; //func7
					set_risc_instruction[14:12] = 3'd1; //func3
				end
				else if (op == "SGT") begin
					set_risc_instruction[31:25] = 7'd4; //func7
					set_risc_instruction[14:12] = 3'd2; //func3
				end
				else if (op == "SGTU") begin
					set_risc_instruction[31:25] = 7'd4; //func7
					set_risc_instruction[14:12] = 3'd3; //func3
				end
				else if (op == "SEQ") begin
					set_risc_instruction[31:25] = 7'd4; //func7
					set_risc_instruction[14:12] = 3'd4; //func3
				end
				else if (op == "SNE") begin
					set_risc_instruction[31:25] = 7'd4; //func7
					set_risc_instruction[14:12] = 3'd5; //func3
				end
				set_risc_instruction[6:0] = 7'd0;
			end
		end
	endfunction		
// synthesis translate_on
endpackage
