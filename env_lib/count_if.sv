
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								INTERFACE
////////////////////////////////////////////////////////////////////////////
***************************************************************************/


interface count_if(input bit clk);

	
	logic rst,load,mode;
 	logic [3:0] data_in;
	logic [3:0] data_out;

	clocking wr_drv_cb@(posedge clk);
		default input#1 output#1;
		output rst;
		output load;
		output mode;
		output data_in;
	endclocking : wr_drv_cb

	clocking wr_mon_cb@(posedge clk);
		default input#1 output#1;
		input rst;
		input load;
		input mode;
		input data_in;
	endclocking : wr_mon_cb

	clocking rd_mon_cb@(posedge clk);
		default input#1 output#1;
		input data_out;
	endclocking : rd_mon_cb

	
	modport WR_DRV(clocking wr_drv_cb);
	modport WR_MON(clocking wr_mon_cb);
	modport RD_MON(clocking rd_mon_cb);


endinterface : count_if



