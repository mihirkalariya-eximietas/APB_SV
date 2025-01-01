//apb_pkg.sv

`include "apb_inf.sv"

package apb_pkg;

 event item_done_ev;
 event wait_reset_done;
 event reset_done;

`include "apb_defines.sv"
 `include "apb_trans.sv"
 `include "apb_genrator.sv"
 `include "apb_driver.sv"
 `include "apb_monitor.sv"
 `include "apb_ref_model.sv"
 `include "apb_scoreboard.sv"
 `include "apb_env.sv"
 //test cases
 // `include "apb_write_read.sv"
 `include "apb_write_only.sv"
 `include "apb_read_only.sv"
 `include "apb_b2b.sv"
 `include "apb_ibr.sv"
 // `include "apb_ideal_State.sv"
 
 `include "apb_base_test.sv"
endpackage