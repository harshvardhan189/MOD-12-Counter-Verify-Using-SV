
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								 REFERENCE MODEL
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

class count_ref;

	count_trans wr_rm;
	count_trans rm_sb;

	//logic [3:0]d_out;

	mailbox #(count_trans) mon2rm;
	mailbox #(count_trans) rm2sb;

	function new(mailbox #(count_trans) mon2rm,
				 mailbox #(count_trans) rm2sb);
		
		this.mon2rm = mon2rm;
		this.rm2sb = rm2sb;
	
	endfunction : new

	virtual task start();
	
		fork
			begin
				forever
				begin

					mon2rm.get(wr_rm);
					this.rm_sb=new wr_rm;	
								
					count();
					rm2sb.put(rm_sb);
				end
			end
		join_none

	endtask : start

	virtual task count();
	
						if(wr_rm.rst)
							wr_rm.data_out = 0;

						else if(wr_rm.load)
							wr_rm.data_out = wr_rm.data_in;
						
						else
							begin
								if(wr_rm.mode == 1)
								begin
									if(wr_rm.data_out == 4'd11)
									wr_rm.data_out=0;
									else 
									wr_rm.data_out++;
								end
						
								else if(wr_rm.mode == 0)
								begin
									if(wr_rm.data_out == 0)
									wr_rm.data_out=4'd11;
									else 
									wr_rm.data_out--;
								end
							end
	endtask :count




endclass : count_ref


