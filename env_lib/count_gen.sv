
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
							GENERATOR CLASS
////////////////////////////////////////////////////////////////////////////
***************************************************************************/

class count_gen;

	count_trans gen_trans;
	count_trans data2send;

	mailbox #(count_trans)gen2wdr;

	function new(mailbox #(count_trans)gen2wdr);
		
		this.gen2wdr = gen2wdr;
		this.gen_trans = new;
	
	endfunction:new


	virtual task start();
		
		fork
			begin
				for(int i=0;i<number_of_transaction;i++)
				begin
					gen_trans.trans_id++;
					assert(gen_trans.randomize());
					$display("%d",number_of_transaction);
					data2send = new gen_trans;
					//data2send.display("data from gen");
					gen2wdr.put(data2send);
					//$display("generator start");

				end
			end
		join_none

	endtask:start

endclass : count_gen


