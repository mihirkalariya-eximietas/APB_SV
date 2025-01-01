//Idle State Robustness
//apb_ideal_State.sv

`ifndef APB_IDEAL_STATE_SV
`define APB_IDEAL_STATE_SV
    class apb_ideal_State extends apb_genrator;
        
		task run();
                               	
            req = new();
                                   
    	    req.PSLEx = 0;
    	    req.PENABLE= 0;
    	    
        endtask
    
	endclass
`endif