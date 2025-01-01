//apb_ref_model.sv

`ifndef APB_REF_SV
`define APB_REF_SV
class apb_ref_model;

  // Take transaction handles
  apb_trans trans_h;
  
  reg [`DATA_WIDTH-1:0] ref_mam [0:`DEPTH-1];
  
  // Declare mailboxes
  mailbox #(apb_trans) mon2ref_mbx;
  mailbox #(apb_trans) ref2scr_mbx;
  

  function void connect(mailbox #(apb_trans) mon2ref_mbx,
                        mailbox #(apb_trans) ref2scr_mbx);
    this.mon2ref_mbx = mon2ref_mbx;
    this.ref2scr_mbx = ref2scr_mbx;
  endfunction
  
  task reset();
    integer i;
    for(i=0;i<`DEPTH;i=i+1)begin
       ref_mam[i]=`DATA_WIDTH'd0;
    end
  endtask
 
  task run();
      reset();
      forever begin
        mon2ref_mbx.get(trans_h);
  
        predict_exp_data(trans_h);
      
        ref2scr_mbx.put(trans_h);
		
		fork
			begin
				@(wait_reset_done);
				reset();
			end
		join_none
      end
  endtask
 
 task predict_exp_data(apb_trans trans_h);
     if(trans_h.PWRITE)
	      ref_mam[trans_h.PADDAR] = trans_h.PWDATA;
	 else
          trans_h.EXP_RDATA = ref_mam[trans_h.PADDAR];

    trans_h.display("REF BLOCK",trans_h);		  
 endtask
    
 
endclass
`endif