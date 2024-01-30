
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
							   	   TOP MODULE 
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

import count_pkg::*;
module top();

	bit clk;
	
	count_if DUV_IF(clk);
	
	test test_h;

	counter_mod12 COUNTER(.clk(clk),
						  .rst(DUV_IF.rst),
						  .load(DUV_IF.load),
						  .mode(DUV_IF.mode),
			 			  .data_in(DUV_IF.data_in),
						  .data_out(DUV_IF.data_out));
	
	always #5 clk = ~clk;

	initial
		begin
			
			$display("inside top");
			test_h = new(DUV_IF,DUV_IF,DUV_IF);
			
			test_h.build_and_run();
			
		end
	
endmodule:top



