
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
							   	   TESTCASE 
////////////////////////////////////////////////////////////////////////////
***************************************************************************/



class count_trans_ex extends count_trans;


endclass

class count_trans_ex1 extends count_trans;


endclass

class test;

	virtual count_if.WR_DRV wr_drv_if;
	virtual count_if.WR_MON wr_mon_if;
	virtual count_if.RD_MON rd_mon_if;

	count_env env_h;

	//count_trans ex_h1;
	//count_trans ex_h2;

	function new(virtual count_if.WR_DRV wr_drv_if,
				 virtual count_if.WR_MON wr_mon_if,
				 virtual count_if.RD_MON rd_mon_if);

	this.wr_drv_if = wr_drv_if;
	this.wr_mon_if = wr_mon_if;
	this.rd_mon_if = rd_mon_if;

	env_h = new(wr_drv_if,wr_mon_if,rd_mon_if);

	endfunction:new

	virtual task build_and_run();
		
		begin
			if($test$plusargs("TEST1"))
			begin
				number_of_transaction = 10;
				env_h.build();
				env_h.run();
				$finish;
			end	

		/*	if($test$plusargs("TEST2"))
			begin
				ex_h1 = new;
				number_of_transaction = 10;
				env_h.build();
				env_h.gen_h.gen_trans = ex_h1;
				env_h.run();
				$finish;
			end

			if($test$plusargs("TEST3"))
			begin
				ex_h2 = new;
				number_of_transaction = 10;
				env_h.build();
				env_h.gen_h.gen_trans = ex_h2;
				env_h.run();
				$finish;
			end

			
		*/

		end
	
	endtask:build_and_run

endclass:test



