//apb_driver.sv
`ifndef APB_DRV_SV
`define APB_DRV_SV

class apb_driver;

  apb_trans trans_h;
  // Declare mailbox for communication
  mailbox #(apb_trans) gen2drv_mbx;

  // Virtual interface pointer
  virtual apb_inf.DRV_MP vif;  // This is not an actual interface instance, just a pointer

  // Connect function to initialize mailbox and virtual interface
  function void connect (mailbox #(apb_trans) gen2drv_mbx,
                         virtual apb_inf.DRV_MP vif);
    this.gen2drv_mbx = gen2drv_mbx;
    this.vif = vif;
    $display("apb_driver connected");
  endfunction

  // Main run task
  task run();
    ideal();
	wait(vif.drv_cb.RESETn);
    forever begin
	 
	    fork: DRV_RUN
	      
	        forever begin
	         gen2drv_mbx.get(trans_h);
	         @(vif.drv_cb);
             send_to_dut();
	        end
        
	    join_none
	    
	    wait(!vif.drv_cb.RESETn) 
	    disable fork;
	    -> item_done_ev;
	    ideal();
	    wait(vif.drv_cb.RESETn);
	    trans_h.display("DRIVER BLOCK",trans_h);
    end
	
  endtask
 
 task send_to_dut();
    ////ideal();
    //@(posedge vif.drv_cb);
	setup();
	//@(posedge vif.drv_cb);
    access();
	  -> item_done_ev;

  endtask
 
  task ideal();
   vif.drv_cb.PSLEx <=0;
   vif.drv_cb.PENABLE <= 0;
  endtask
 
  task setup();
    @(vif.drv_cb);
   vif.drv_cb.PSLEx <=1;
   vif.drv_cb.PENABLE <= 0;
   vif.drv_cb.PWRITE <=trans_h.PWRITE ;
   vif.drv_cb.PADDAR <= trans_h.PADDAR;
   vif.drv_cb.PWDATA <= trans_h.PWDATA;
  endtask
 
  task access();
   @(vif.drv_cb);
   vif.drv_cb.PENABLE <= 1'b1;
   wait(vif.drv_cb.PREADY);
  endtask
endclass

`endif
