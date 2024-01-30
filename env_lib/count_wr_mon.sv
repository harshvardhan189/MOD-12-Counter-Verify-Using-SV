
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								WRITE MONITOR
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

class count_wr_mon;

	virtual count_if.WR_MON wr_mon_if;

	mailbox #(count_trans) mon2rm;

	count_trans data2rm;


	function new (virtual count_if.WR_MON wr_mon_if,
				  mailbox #(count_trans) mon2rm);
	
		this.wr_mon_if = wr_mon_if;
		this.mon2rm = mon2rm;
		this.data2rm = new();
	
	endfunction :new


	virtual task monitor();
		

		@(wr_mon_if.wr_mon_cb);
	//	wait(wr_mon_if.wr_mon_cb.load==1)
	//	@(wr_mon_if.wr_mon_cb);
		begin
		data2rm.rst 	 = wr_mon_if.wr_mon_cb.rst;
		data2rm.load 	 = wr_mon_if.wr_mon_cb.load;
		data2rm.mode	 = wr_mon_if.wr_mon_cb.mode;
		data2rm.data_in  = wr_mon_if.wr_mon_cb.data_in;
		
		data2rm.display("DATA FROM WRITE MONITOR");
		end

	endtask :monitor



	virtual task start();
		fork
			forever
			begin
				monitor();
				mon2rm.put(data2rm);
					$display("write monitor start");
			end
		join_none
	endtask:start
	

endclass : count_wr_mon


