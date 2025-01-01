//apb_monitor.sv

`ifndef APB_MON_SV
`define APB_MON_SV
class apb_monitor;

  // Declare transaction handle for the monitored transaction
  apb_trans trans_h;

  // Declare mailboxes for communication
	  mailbox #(apb_trans) mon2ref_mbx;
	  
	  mailbox #(apb_trans) mon2scr_mbx;

  // Declare virtual interface for monitoring
  virtual apb_inf.MON_MP mvif;  // Virtual interface pointer

  // Connect function to initialize mailbox and virtual interface
  function void connect (mailbox #(apb_trans) mon2ref_mbx,
                         mailbox #(apb_trans) mon2scr_mbx,
                         virtual apb_inf.MON_MP mvif);
    this.mon2ref_mbx = mon2ref_mbx;
    this.mon2scr_mbx = mon2scr_mbx;
    this.mvif = mvif;
  endfunction
  
    task run();
     
       monitor();
	   // trans_cg.sample();
	
    endtask
    
    task monitor();
      trans_h = new();
     forever begin
      @(posedge mvif.mon_cb);
      wait(mvif.mon_cb.PSLEx && !mvif.mon_cb.PENABLE);begin
        trans_h.PADDAR = mvif.mon_cb.PADDAR;
        trans_h.PWRITE = mvif.mon_cb.PWRITE;
	  end
      @(posedge mvif.mon_cb);
      wait(mvif.mon_cb.PSLEx && mvif.mon_cb.PENABLE &&  mvif.mon_cb.PREADY);begin
       if(mvif.mon_cb.PWRITE)
          trans_h.PWDATA = mvif.mon_cb.PWDATA;
       else
          trans_h.PRDATA = mvif.mon_cb.PRDATA;
      end
      // Send the captured transaction to the reference and scoreboard
      mon2ref_mbx.put(trans_h);
      mon2scr_mbx.put(trans_h);
	  
      trans_h.display("MONITOR BLOCK", trans_h);
     end
  endtask
endclass
`endif