//apb_read_only.sv

`ifndef APB_READ_ONLY_SV
`define APB_READ_ONLY_SV

class apb_read_only extends apb_genrator;
task run();
	
    req = new();
	 `WRITE(put_trans, req, 15)

     `READ(put_trans, req, 15)
endtask
endclass
`endif