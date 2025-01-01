//apb_base_test.sv

`ifndef APB_BASE_TEST_SV
`define APB_BASE_TEST_SV

class apb_base_test;

	apb_env env_h;
  
	//driver and monitor interface
	virtual apb_inf.DRV_MP vif;
	virtual apb_inf.MON_MP mvif;
	
	//testcase
	// apb_write_read wr_rd;
	apb_write_only wr_only;
	apb_read_only rd_only;
	apb_b2b b2b;
	apb_ibr ibr;
	// apb_ideal_State ideal;
   
   //create environment and call its methods here as needed
   function void build();
		env_h = new();
		env_h.build();
   endfunction
	
	
	function void connect(virtual apb_inf.DRV_MP vif,virtual apb_inf.MON_MP mvif);
		this.vif = vif;
		this.mvif = mvif;
		
		// if ($test$plusargs("WR_RD")) begin
			// wr_rd= new();
			// env_h.gen_h = wr_rd;
		// end
		
		if ($test$plusargs("WR_ONLY")) begin
			wr_only= new();
			env_h.gen_h = wr_only;
		end
		
		if ($test$plusargs("RD_ONLY")) begin
			rd_only= new();
			env_h.gen_h = rd_only;
		end
		
		if ($test$plusargs("B2B")) begin
			b2b= new();
			env_h.gen_h = b2b;
		end
		
		if ($test$plusargs("IBR")) begin
			ibr= new();
			env_h.gen_h = ibr;
		end
		
		// if ($test$plusargs("IDEAL")) begin
			// ideal= new();
			// env_h.gen_h = ideal;
		// end
		
		env_h.connect(vif,mvif);
		env_h.new_connect();
	endfunction
   
   
   task run();
      env_h.run();
   endtask
     
  

endclass
`endif