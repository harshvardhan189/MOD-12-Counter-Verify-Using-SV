
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								 SCOREBOARD 
////////////////////////////////////////////////////////////////////////////
***************************************************************************/


class count_sb;

	event DONE;

	int data_verified =0;
	int rm_data_count=0;
	int mon_data_count=0;

	count_trans rm_data;
	count_trans rcvd_data;
	count_trans cov_data;

	mailbox #(count_trans) rm2sb;
	mailbox #(count_trans) rdmon2sb;

	function new(mailbox #(count_trans) rm2sb,
				 mailbox #(count_trans) rdmon2sb);
		
		this.rm2sb =  rm2sb;
		this.rdmon2sb = rdmon2sb;
		this.cov_data = new;

	endfunction:new


	
	covergroup count_cov;
		
		RESET 	  : coverpoint cov_data.rst;
		LOAD  	  : coverpoint cov_data.load;
		MODE  	  : coverpoint cov_data.mode;
		DATA_IN   : coverpoint cov_data.data_in{
							   bins din[] = {[0:11]};
							  /* bins din   = default;*/}
		DATA_OUT  : coverpoint cov_data.data_out{
							   bins din[] = {[0:11]};}

		LOADxDATA_IN : cross LOAD,DATA_IN;

		MODExLOADxDATA_IN : cross MODE,LOAD,DATA_IN;

	endgroup:count_cov


	virtual task check(count_trans rc_data);
		
		
			if(rc_data.data_out != rm_data.data_out )
				begin
					$display("DATA NOT VERIFIED");
					$finish;
				end

			else
			begin
				$display("DATA VERIFIED SUCCESSFULL");
				cov_data = rm_data;
				count_cov.sample();
				data_verified++;
			end

			if(data_verified == number_of_transaction)
			begin
				->DONE;

			end
	endtask : check


	virtual task start();
	
		fork
			forever
				begin
					rm2sb.get(rm_data);
					rm_data_count++;

					rdmon2sb.get(rcvd_data);
					mon_data_count++;

					check(rcvd_data);
				end
		join_none

	endtask : start

	
	
	
	function void report();

		$display("***********************************************");
		$display("============= SCOREBOARD REPORT ===============");
		$display("===============================================");
		$display("READ DATA GENERATED : %0d" , rm_data_count);
		$display("RECEIVED DATA       : %0d" , mon_data_count);
		$display("DATA VERIFIED       : %0d" , data_verified);
		$display("===============================================");
		$display("***********************************************");


	endfunction : report


endclass :count_sb


