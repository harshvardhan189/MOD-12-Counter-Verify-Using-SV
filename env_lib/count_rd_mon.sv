
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								  READ MONITOR
////////////////////////////////////////////////////////////////////////////
***************************************************************************/


class count_rd_mon;

	virtual count_if.RD_MON rd_mon_if;
	
	mailbox #(count_trans)rdmon2sb;
	
	count_trans data2sb;

	function new(virtual count_if.RD_MON rd_mon_if,
				 mailbox #(count_trans)rdmon2sb);
		this.rd_mon_if = rd_mon_if;
		this.rdmon2sb = rdmon2sb;
		this.data2sb=new;
		
	endfunction :new

	virtual task monitor();
		
		@(rd_mon_if.rd_mon_cb);

		data2sb.data_out  = rd_mon_if.rd_mon_cb.data_out;

		data2sb.display("DATA FROM READ MONITOR");
	
	endtask:monitor

	virtual task start();
		fork
			forever
			begin
				monitor();
				rdmon2sb.put(data2sb);
					$display("read_mon start");
			end
		join_none
	endtask :start



endclass:count_rd_mon



