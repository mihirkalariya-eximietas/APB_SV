//apb_b2b.sv

`ifndef APB_B2B_SV
`define APB_B2B_SV

class apb_b2b extends apb_genrator;
task run();
		req = new();
			// Initialize memory with write operations
	for (int i = 0; i <= 12; i++) begin
		
		if(!req.randomize() with {req.PWRITE == 1; })
                $error("Randomization failed for req");
           
        req.PADDAR = i;
		req.PWDATA = i;
		put_trans(req);        
            
           if(!req.randomize() with {req.PWRITE == 0;
	                                     PWDATA == 0;})
                $error("Randomization failed for req");
               		 
           req.PADDAR= i;
           put_trans(req);
	end
	endtask
endclass
`endif