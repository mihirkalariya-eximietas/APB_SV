//apb_write_read.sv
`ifndef APB_WRITE_READ_SV
`define APB_WRITE_READ_SV
class apb_write_read extends apb_genrator;
    task run();
    	
        req = new();
    	 `WRITE(put_trans, req, 24)
          
    	 `READ(put_trans, req, 12)
    
    endtask
endclass
`endif