//apb_tb_top.sv

module apb_tb_top();
    import apb_pkg::*;
	
	  apb_base_test base_test_h;
  
  bit PCLK;
  
  // Clock generation
  initial begin
    PCLK = 0;
    forever #5 PCLK = ~PCLK;
  end
  
  // Instantiate the interface
  apb_inf rif(PCLK);


  // Instantiate the design
  AMBA_APB DUT (.PCLK(PCLK), .RESETn(rif.RESETn), .PWRITE(rif.PWRITE), .PADDAR(rif.PADDAR), 
           .PSLEx(rif.PSLEx), .PWDATA(rif.PWDATA), 
           .PRDATA(rif.PRDATA), .PENABLE(rif.PENABLE), .PREADY(rif.PREADY), .PSLVERR(rif.PSLVERR));
  
  //task for initial_reset
   task initial_reset();
	    @(posedge rif.PCLK);
	        rif.RESETn = 0;
	    @(posedge rif.PCLK);
	        rif.RESETn = 1;
	    -> wait_reset_done;
   endtask
	
  //task for run_test
  task run_test();
	   if ($time !== 0)
			  $fatal("run_test() must call at zero simulation time");
       base_test_h = new();
	   base_test_h.build();
       base_test_h.connect(rif,rif);
	   base_test_h.run();
  endtask
  
  initial begin
   initial_reset();
   @(reset_done);
   initial_reset();
  end
  
  initial begin
	run_test();
    #20;
    $finish;
  end
 
endmodule