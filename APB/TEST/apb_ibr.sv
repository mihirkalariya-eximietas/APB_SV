//apb_ibr.sv
`ifndef APB_IBR_SV
`define APB_IBR_SV

class apb_ibr extends apb_genrator;

    task run();
		req = new();
		`WRITE(put_trans, req, 12)
	    `READ(put_trans, req, 12)
		-> reset_done;
	    `READ(put_trans, req, 10)
    endtask

endclass
`endif