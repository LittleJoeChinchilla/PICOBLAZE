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

/* Package: logic_axi4_lite_pkg
 *
 * Logic AXI4-Lite package.
 */
package logic_axi4_lite_pkg;
	/* Enum: size_t
	 * Transaction data size in bits (width). 
	 */
	typedef enum logic [2:0] {
		SIZE_8                              = 3'b000,
		SIZE_16                             = 3'b001,
		SIZE_32                             = 3'b010,
		SIZE_64                             = 3'b011,
		SIZE_128                            = 3'b100,
		SIZE_256                            = 3'b101,
		SIZE_512                            = 3'b110,
		SIZE_1024                           = 3'b111
	} size_t;

	/* Function : default_size
	 * Returns size_t enum value according to AXI data width (bytes input).
	 * Input    : bytes - axi data size in bytes.
	 * Output   : size_t enum value.
	 */
	function size_t default_size(int bytes);
		if      (bytes >= 128)  default_size = SIZE_1024;
		else if (bytes >=  64)  default_size = SIZE_512;
		else if (bytes >=  32)  default_size = SIZE_256;
		else if (bytes >=  16)  default_size = SIZE_128;
		else if (bytes >=   8)  default_size = SIZE_64;
		else if (bytes >=   4)  default_size = SIZE_32;
		else if (bytes >=   2)  default_size = SIZE_16;
		else                    default_size = SIZE_8;
	endfunction

	/* Enum : bufferable_transaction_t
	 * Bufferable transaction.
	 * BUFFERABLE_TRANSACTION_UNBUFFERABLE  - Transaction can't be buffered.
	 * BUFFERABLE_TRANSACTION_BUFFERABLE    - Transaction can be buffered.
	 */
	typedef enum logic [0:0] {
		BUFFERABLE_TRANSACTION_UNBUFFERABLE = 1'b0,
		BUFFERABLE_TRANSACTION_BUFFERABLE   = 1'b1
	} bufferable_transaction_t;

	/* Enum : modifiable_transaction_t
	 * Modifiable transaction.
	 * MODIFIABLE_TRANSACTION_UNMODIFIABLE  - Transaction can't be modified.
	 * MODIFIABLE_TRANSACTION_MODIFIABLE    - Transaction can be modified.
	 */
	typedef enum logic [0:0] {
		MODIFIABLE_TRANSACTION_UNMODIFIABLE = 1'b0,
		MODIFIABLE_TRANSACTION_MODIFIABLE   = 1'b1
	} modifiable_transaction_t;

	/* Enum: write_allocate_t
	 * Write allocate.
	 * WRITE_ALLOCATE_SET                   - Set write allocate bit.
	 * WRITE_ALLOCATE_CLEAR                 - Clear write allocate bit.
	 */
	typedef enum logic [0:0] {
		WRITE_ALLOCATE_SET                  = 1'b1,
		WRITE_ALLOCATE_CLEAR                = 1'b0
	} write_allocate_t;

	/* Enum: read_allocate_t
	 * Read allocate.
	 * READ_ALLOCATE_SET                    - Set read allocate bit.
	 * READ_ALLOCATE_CLEAR                  - Clear read allocate bit.
	 */
	typedef enum logic [0:0] {
		READ_ALLOCATE_SET                   = 1'b1,
		READ_ALLOCATE_CLEAR                 = 1'b0
	} read_allocate_t;

	/* Enum: privilege_access_t
	 *
	 * Privilege access.
	 *
	 * PRIVILEGE_ACCESS_UNPRIVILEGED        - Unprivileged access.
	 * PRIVILEGE_ACCESS_PRIVILEGED          - Privileged access.
	 */
	typedef enum logic [0:0] {
		PRIVILEGE_ACCESS_UNPRIVILEGED       = 1'b0,
		PRIVILEGE_ACCESS_PRIVILEGED         = 1'b1
	} privilege_access_t;

	/* Enum: security_access_t
	 *
	 * Security access.
	 *
	 * SECURITY_ACCESS_SECURE               - Secure access.
	 * SECURITY_ACCESS_NON_SECURE           - Non-secure access.
	 */
	typedef enum logic [0:0] {
		SECURITY_ACCESS_SECURE              = 1'b0,
		SECURITY_ACCESS_NON_SECURE          = 1'b1
	} security_access_t;

	/* Enum: type_access_t
	 *
	 * Type access.
	 *
	 * TYPE_ACCESS_DATA                     - Data access.
	 * TYPE_ACCESS_INSTRUCTION              - Instruction access.
	 */
	typedef enum logic [0:0] {
		TYPE_ACCESS_DATA                    = 1'b0,
		TYPE_ACCESS_INSTRUCTION             = 1'b1
	} type_access_t;

	/* Enum: access_t
	 *
	 * Access.
	 *
	 * type_access                          - Type access.
	 * security_access                      - Security access.
	 * privilege_access                     - Privilege access.
	 */
	typedef struct packed {
		type_access_t                       type_access;
		security_access_t                   security_access;
		privilege_access_t                  privilege_access;
	} access_t;

	/* Const: DEFAULT_DATA_ACCESS
	 *
	 * Default data access permission.
	 */
	localparam access_t DEFAULT_DATA_ACCESS = '{
			type_access                         : TYPE_ACCESS_DATA,
			security_access                     : SECURITY_ACCESS_SECURE,
			privilege_access                    : PRIVILEGE_ACCESS_UNPRIVILEGED
		};

	/* Const: DEFAULT_INSTRUCTION_ACCESS
	 *
	 * Default data access permission.
	 */
	localparam access_t DEFAULT_INSTRUCTION_ACCESS = '{
			type_access                         : TYPE_ACCESS_INSTRUCTION,
			security_access                     : SECURITY_ACCESS_SECURE,
			privilege_access                    : PRIVILEGE_ACCESS_UNPRIVILEGED
		};

	/* Enum: response_t
	 *
	 * Write/read response.
	 *
	 * RESPONSE_OKAY                        - Normal access success.
	 * RESPONSE_EXOKAY                      - Exclusive access okay.
	 * RESPONSE_SLVERR                      - Slave error.
	 * RESPONSE_DECERR                      - Decode error.
	 */
	typedef enum logic [1:0] {
		RESPONSE_OKAY                       = 2'b00,
		RESPONSE_EXOKAY                     = 2'b01,
		RESPONSE_SLVERR                     = 2'b10,
		RESPONSE_DECERR                     = 2'b11
	} response_t;
    
	/* Class: request_t
	 * Object contains data and functions related to AW/AR channel transactions.
	 */
	class request_t #(
			int ADDRESS_WIDTH   = 32
			);
		/* Packed data types with parametrized widths */
		typedef bit   [ADDRESS_WIDTH-1:0]   address_type;

		/* Logic data types with parametrized widths for driving AW/AR channel */
		typedef logic [ADDRESS_WIDTH-1:0]   address_logic_type;
        
		/* Local variables containing data about transaction */
		local address_type                  address;

		/* Function: new
		 * Constructor. Initializes object local variables.
		 * Inputs: id, address, length, size, burst - AW/AR transactions parameters.
		 */
		function new(address_type address = '0);
			this.address    = address;
		endfunction

		/* Function: set_address
		 * Set object local variable : address.
		 */
		function void set_address(address_type address = '0);
			this.address    = address;
		endfunction

		/* Function: get_address
		 * Returns object local variable : address.
		 */
		function address_type get_address;
			get_address     = this.address;
		endfunction
        
		/* Function: show
		 * Displays AW/AR transaction data in simulator.
		 */
		function void show;
			$display("AXI transaction request:");
			$display("ADDRESS = %h", this.address);
		endfunction
        
		/* Function: assign_channel
		 * Assigns data to AW/AR channel.
		 * Input: references to channel signals.
		 */ 
		function void assign_channel(ref address_logic_type AxADDR);
			AxADDR  = address_logic_type'   (this.address);
		endfunction
	endclass     

	/* Class: wdata_t
	 * Object contains write data information (W channel).
	 */
	class wdata_t #(
			int BYTES       = 4
			);
		/* Packed data types with parametrized widths */
		typedef bit   [   BYTES-1:0][7:0]   data_type;
		typedef bit   [   BYTES-1:0]        byte_enable_type;
		typedef struct {
			data_type           data;
			byte_enable_type    strobe;
		}                                   write_data_type;

		/* Logic data types with parametrized widths for driving W channel */
		typedef logic [   BYTES-1:0][7:0]   data_logic_type;
		typedef logic [   BYTES-1:0]        byte_enable_logic_type;

		/* Local variables containing data about transaction */
		local write_data_type               data;

		/* Function: new
		 * Constructor. Initializes object local variables.
		 * Inputs: id - W transaction parameter.
		 */
		function new;

		endfunction

		/* Function: write
		 * Write data to local data queue.
		 */
		function void write(data_type data = '0, byte_enable_type strobe = '1); 
			write_data_type     wdata;
			wdata.data          = data;
			wdata.strobe        = strobe;                
			this.data 			= wdata;
		endfunction

		/* Function: read
		 * Returns data from local data queue with index based on internal read pointer.
		 * Output: structure with data and strobe (write_data_type).
		 */
		function write_data_type read;
			read = this.data;
		endfunction

		/* Function: show
		 * Displays W transaction data and read pointer value in simulator.
		 */
		function void show;
			$display("data = %h, strobe = %h", data.data, data.strobe);           
		endfunction 

		/* Function: assign_channel
		 * Assigns data to W channel.
		 * Input: references to channel signals.
		 */ 
		function void assign_channel(ref data_logic_type WDATA, ref byte_enable_logic_type WSTRB);
			write_data_type data    = read();
			WDATA                   = data_logic_type'          (data.data);
			WSTRB                   = byte_enable_logic_type'   (data.strobe);
		endfunction
	endclass

	/* Class: bresp_t
	 * Object contains write response information (B channel).
	 */
	class bresp_t;

		/* Logic data types with parametrized widths for driving B channel */
		typedef logic [1:0]             response_logic_type;
        
		/* Local variables containing data about transaction */
		local response_t                response;

		/* Function: new
		 * Constructor. Initializes object local variables.
		 * Inputs: id, resp - B transaction parameters.
		 */
		function new(response_t resp = RESPONSE_OKAY);
			this.response   = resp;
		endfunction

		/* Function: set_response
		 * Set object local variable : response.
		 */
		function void set_response(response_t resp = RESPONSE_OKAY);
			this.response = resp;
		endfunction

		/* Function: get_response
		 * Returns object local variable : response.
		 */
		function response_t get_response;
			get_response = this.response;
		endfunction
        
		/* Function: show
		 * Displays B transaction data and read pointer value in simulator.
		 */
		function void show;
			$display("RESP = %s", response.name());          
		endfunction 

		/* Function: assign_channel
		 * Assigns data to B channel.
		 * Input: references to channel signals.
		 */ 
		function void assign_channel(ref response_logic_type BRESP);
			BRESP   = response_logic_type'  (get_response());
		endfunction        
	endclass
    
	/* Class: rdata_t
	 * Object contains read data information (R channel).
	 */
	class rdata_t #(
			int BYTES       = 4
			);
		/* Packed data types with parametrized widths */
		typedef bit     [   BYTES-1:0][7:0]     data_type;

		/* Logic data types with parametrized widths for driving R channel */
		typedef logic   [   BYTES-1:0][7:0]     data_logic_type;
		typedef logic   [1:0]                   response_logic_type;

		/* Local variables containing data about transaction */
		local data_type                         data;
		local response_t                        response;

		/* Function: new
		 * Constructor. Initializes object local variables.
		 * Inputs: id, resp - R transaction parameters.
		 */
		function new(response_t resp = RESPONSE_OKAY);
			this.response = resp;
		endfunction

		/* Function: set_response
		 * Set object local variable : id.
		 */
		function void set_response(response_t resp = RESPONSE_OKAY);
			this.response = resp;
		endfunction

		/* Function: write 
		 * Write data to local data queue.
		 */
		function void write(data_type data = '0);               
			this.data = data;
		endfunction      
    
		/* Function: read
		 * Returns data from local data queue with index based on internal read pointer.
		 * Output: structure with data and strobe (write_data_type).
		 */        
		function data_type read();
			read = this.data;
		endfunction

		/* Function: get_response
		 * Returns object local variable : response.
		 */
		function response_t get_response;
			get_response = this.response;
		endfunction

		/* Function: show
		 * Displays R transaction data and read pointer value in simulator.
		 */
		function void show;
			$display("data = %h", data[0]);        
		endfunction 

		/* Function: assign_channel
		 * Assigns data to R channel.
		 * Input: references to channel signals.
		 */
		function void assign_channel(ref data_logic_type RDATA, ref response_logic_type RRESP);
			RDATA   = data_logic_type'(read());
			RRESP   = response_logic_type'(get_response());
		endfunction
	endclass
endpackage
