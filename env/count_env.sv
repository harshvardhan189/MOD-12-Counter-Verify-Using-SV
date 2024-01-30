
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								 ENVIRONMENT 
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

class count_env;

	
	virtual count_if.WR_DRV wr_drv_if;
	virtual count_if.WR_MON wr_mon_if;
	virtual count_if.RD_MON rd_mon_if;


	mailbox #(count_trans)gen2wdr  = new;
	mailbox #(count_trans)mon2rm   = new;
	mailbox #(count_trans)rdmon2sb = new;
	mailbox #(count_trans)rm2sb    = new;

	
	count_gen	  gen_h;
	count_wr_drv  wr_drv_h;
	count_wr_mon  wr_mon_h;
	count_rd_mon  rd_mon_h;
	count_ref	  ref_h;
	count_sb	  sb_h;    


	function new(virtual count_if.WR_DRV wr_drv_if,
				 virtual count_if.WR_MON wr_mon_if,
				 virtual count_if.RD_MON rd_mon_if);
		
		this.wr_drv_if = wr_drv_if;
		this.wr_mon_if = wr_mon_if;
		this.rd_mon_if = rd_mon_if;
	
	endfunction :new


	virtual task build();
	
		gen_h    = new(gen2wdr);
		wr_drv_h = new(wr_drv_if,gen2wdr);
		wr_mon_h = new(wr_mon_if,mon2rm);
		rd_mon_h = new(rd_mon_if,rdmon2sb);
		ref_h    = new(mon2rm,rm2sb);
		sb_h     = new(rm2sb,rdmon2sb);

	endtask:build

	
	virtual task reset_dut();

		begin
		
		@(wr_drv_if.wr_drv_cb);
		wr_drv_if.wr_drv_cb.rst		<= 1;
        wr_drv_if.wr_drv_cb.load	<= 0;
        wr_drv_if.wr_drv_cb.data_in	<= 0;
  	    wr_drv_if.wr_drv_cb.mode	<= 0;

		end

	endtask:reset_dut


	virtual task start();
	
	gen_h.start();
    wr_drv_h.start();
    wr_mon_h.start();
    rd_mon_h.start();
    ref_h.start();
    sb_h.start();    
	
	endtask:start


	virtual task stop();

		wait(sb_h.DONE.triggered);
		
	endtask:stop


	virtual task run();

		reset_dut();
		$display("rest called");
		start();
		$display("start called");
		stop();
		sb_h.report();

	endtask:run

endclass : count_env


