//apb_genrator.sv

`ifndef APB_GEN_SV
`define APB_GEN_SV
virtual class apb_genrator;

apb_trans req,req_copy;

//mailbox
mailbox #(apb_trans) gen2drv_mbx;

function void connect (mailbox #(apb_trans) gen2drv_mbx);
	this.gen2drv_mbx=gen2drv_mbx;
	$display("apb_genrator connected");
endfunction

pure virtual task run();   
   
	  // req = new();
	// repeat(24) begin
      // if(!req.randomize() with {req.PWRITE == 1; })begin
        // $error("RANDOMIZATION FAILED!");
      // end
	  // req_copy = new req;
      // this.gen2drv_mbx.put(req_copy);
	  // req_copy.display("GENRATOR BLOCK",req_copy);
	  // @(item_done_ev);
	 // end
      
	   // repeat(12) begin
      // if(!req.randomize() with {req.PWRITE == 0;
	                                  // PWDATA == 0;  
                                      // })begin
        // $error("RANDOMIZATION FAILED!");
      // end
	  // req_copy = new req;
      // this.gen2drv_mbx.put(req_copy);
	 // req_copy.display("GENRATOR BLOCK",req_copy);
	  // @(item_done_ev);
	 // end
// endtask

 protected task put_trans(apb_trans req);
	   req_copy = new req;
	   gen2drv_mbx.put(req_copy);
	   req_copy.display("GENERATE BLOCK",req_copy);
	   @(item_done_ev);
 endtask  
 
endclass
`endif