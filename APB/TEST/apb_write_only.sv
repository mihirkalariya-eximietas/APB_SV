//apb_write_only.sv
`ifndef APB_WRITE_ONLY_SV
`define APB_WRITE_ONLY_SV
class apb_write_only extends apb_genrator;
task run();
	
    req = new();
	 `WRITE(put_trans, req, 15)

endtask
endclass
`endif