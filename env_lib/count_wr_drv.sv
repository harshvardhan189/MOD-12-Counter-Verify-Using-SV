/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								WRITE DRIVER
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

 
class count_wr_drv;
	
	virtual count_if.WR_DRV wr_drv_if;

	count_trans data2duv;

	mailbox #(count_trans)gen2wdr;

	function new (virtual count_if.WR_DRV wr_drv_if,
					  mailbox #(count_trans)gen2wdr);

			this.wr_drv_if = wr_drv_if;
			this.gen2wdr = gen2wdr;
					
	endfunction:new


	virtual task drive();
		@(wr_drv_if.wr_drv_cb);
		wr_drv_if.wr_drv_cb.rst  	<= data2duv.rst;
		wr_drv_if.wr_drv_cb.load 	<= data2duv.load;
		wr_drv_if.wr_drv_cb.mode 	<= data2duv.mode;
		wr_drv_if.wr_drv_cb.data_in <= data2duv.data_in;
		
		repeat(2) @(wr_drv_if.wr_drv_cb);
		//wr_drv_if.wr_drv_cb.load 	<= 0;

	endtask : drive


	virtual task start();
		
		fork
			forever
			begin
				gen2wdr.get(data2duv);
				drive();
					$display("write driver start");
			end
		join_none

	endtask : start


endclass:count_wr_drv


