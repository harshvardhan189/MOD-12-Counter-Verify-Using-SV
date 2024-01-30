/***************************************************************************
////////////////////////////////////////////////////////////////////////////
							TRANSACTION CLASS
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

class count_trans;

	rand bit [3:0] data_in;
	rand bit load;
	rand bit mode;
	rand bit rst;
	
	logic   [3:0] data_out;

	static int trans_id;
	static int no_of_load;
	static int no_of_up;
	static int no_of_down;
	static int no_of_reset;
	


	constraint reset_c{rst dist{1:=20,0:=80};}
	constraint load_c{load dist{1:=90,0:=10};}
	constraint mode_c{mode dist{1:=40,0:=60};}
	constraint d_in_c{data_in inside{[0:11]};}


	function void display(input string msg);
		$display("===============================================");
		$display("%s",msg);
		$display("TRANSACTION NO: %0d",trans_id);
		$display("RESET: %0d",rst);
		$display("NUMBER OF LOAD Data: %0d",no_of_load);
		$display("NUMBER OF UP COUNT: %0d",no_of_up);
		$display("NUMBER OF DOWN COUNT: %0d",no_of_down);
		$display("INPUT DATA: %0d",data_in);
		$display("OUTPUT DATA: %0d",data_out);
		$display("===============================================");
	endfunction :display

	
	function void post_randomize();
		if(rst == 1)
			no_of_reset++;
		if(load == 1)
			no_of_load++;
		if(mode == 1)
			no_of_up++;
		if(mode == 0)
			no_of_down++;
		this.display("\tRANDOMIZE DATA");
	endfunction:post_randomize


	function bit compare(input count_trans rcv, output string msg);
		
		compare=0;
		
		begin
			if(this.data_out != rcv.data_out)
			begin
				$display($time);
				msg = "--------------DATA MISMATCH-------------";
				return(0);
			end

			else	
			begin
				msg = "--------------SUCCESSFULLY COMPARED-------------";
				return(1);
			end
		end

	endfunction:compare


		
endclass:count_trans


