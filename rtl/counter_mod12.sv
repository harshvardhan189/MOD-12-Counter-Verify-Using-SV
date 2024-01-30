
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
							RTL MOD12 COUNTER
////////////////////////////////////////////////////////////////////////////
***************************************************************************/


module counter_mod12(
			 input clk,rst,load,mode,
			 input [3:0] data_in,
			 output reg [3:0] data_out);

always@(posedge clk)
begin
	if(rst)
		data_out <= 0;
	
	else if(load)
		data_out <= data_in;
	
	else
	begin
		if(mode == 1)
		begin
			if(data_out == 4'd11)
			data_out<=0;
			else 
			data_out++;
		end

		else if(mode == 0)
		begin
			if(data_out == 0)
			data_out<=4'd11;
			else 
			data_out--;
		end
	end


end

endmodule:counter_mod12































