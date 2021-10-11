`timescale 1ns/1ps

module risc_clocking #(
	parameter ZYNQ_PRESENT = "false"
) (
    input   zynq_pl_clk,
    input   zynq_pl_resetn,
    input	sys_clk,
    input 	sys_reset,
    input 	aux_reset,
    output 	risc_clk,
    output 	risc_resetn,
    output  locked
);
	
	generate
		if (ZYNQ_PRESENT == "true") begin
			risc_clock_internal clock_inst 
			(
				.zynq_pl_clk	(zynq_pl_clk),
				.zynq_pl_resetn	(zynq_pl_resetn),
				.risc_clk	    (risc_clk),
				.locked		    (locked)
			);			
		end
		else if (ZYNQ_PRESENT == "false") begin
			risc_clock_external clock_inst 
			(
				.sys_clk	(sys_clk),
				.sys_reset	(sys_reset),
				.risc_clk	(risc_clk),
				.locked		(locked)
			);	
		end
	endgenerate
	
	logic risc_reset_ext;
	logic risc_reset_aux;
	
	generate
	   if (ZYNQ_PRESENT == "true") begin
	       assign risc_reset_ext = 0;
	       assign risc_reset_aux = ~zynq_pl_resetn || aux_reset;
	   end
	   else if (ZYNQ_PRESENT == "false") begin
	       assign risc_reset_ext = sys_reset;
	       assign risc_reset_aux = aux_reset;
	   end
	endgenerate
	
	risc_reset reset_inst (
		.slowest_sync_clk		(risc_clk),
		.ext_reset_in			(risc_reset_ext),
		.aux_reset_in			(risc_reset_aux),
		.mb_debug_sys_rst		(1'b0),
		.dcm_locked				(locked),
		.mb_reset				(),
		.bus_struct_reset		(),
		.peripheral_reset		(),
		.interconnect_aresetn	(),
		.peripheral_aresetn		(risc_resetn)
	);
	
endmodule
