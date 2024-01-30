
/***************************************************************************
////////////////////////////////////////////////////////////////////////////
								PACKAGE
////////////////////////////////////////////////////////////////////////////
***************************************************************************/


package count_pkg;

	int number_of_transaction =100;

	`include "count_trans.sv"
	`include "count_gen.sv"
	`include "count_wr_drv.sv"
	`include "count_wr_mon.sv"
	`include "count_rd_mon.sv"
	`include "count_ref.sv"
	`include "count_sb.sv"
	`include "count_env.sv"
	`include "test.sv"


endpackage:count_pkg


