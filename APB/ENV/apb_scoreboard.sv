//apb_scoreboard.sv

`ifndef APB_SCR_SV
`define APB_SCR_SV

class apb_scoreboard;
  
    // Take transaction handles
    apb_trans trans_h;
    apb_trans act_trans;
    apb_trans exp_trans;
    static int pass = 0 ,fail =0;
    
    bit[(`DATA_WIDTH -1):0] act_que[$];
    bit[(`DATA_WIDTH -1):0] exp_que[$];
    bit[(`DATA_WIDTH -1):0] act_pop ,exp_pop;
    
    mailbox #(apb_trans) mon2scr_mbx;
    mailbox #(apb_trans) ref2scr_mbx;
    
    function void connect(mailbox #(apb_trans) mon2scr_mbx,
                          mailbox #(apb_trans) ref2scr_mbx);
        this.mon2scr_mbx = mon2scr_mbx;
        this.ref2scr_mbx = ref2scr_mbx;
    endfunction
    
    covergroup trans_cg;
	
        PADDAR_CP: coverpoint act_trans.PADDAR {
            bins lowest_PADDAR  = {0};                         
            bins mid_range_PADDAR = {[(`DEPTH/2 - 2):(`DEPTH/2 + 2)]}; 
            bins highest_PADDAR = {[`DEPTH/2 + 2:`DEPTH-1]};              
            }
        
      	PWDATA_cp: coverpoint act_trans.PWDATA {
            bins low_rang_PWDATA = {[0:85]}; 
            bins mid_rang_PWDATA = {[86:170]};
            bins high_rang_PWDATA = {[171:255]};
            }
      
        PRDATA_cp: coverpoint act_trans.PRDATA {
            bins low_rang_PRDATA = {[0:85]}; 
            bins mid_rang_PRDATA = {[86:170]};
            bins high_rang_PRDATA = {[171:255]};
            }
			
		PWRITE_cp: coverpoint act_trans.PWRITE {
            bins write = {1};   
            bins read = {0};     
            bins back2back = (1 => 0 => 1 => 0); 
            bins con_write = (1[*8]);
            bins con_read = (0[*8]);
            }

        
		// PSLEx_cp: coverpoint act_trans.PSLEx {
            // bins PSLEx_active = {1};
            // bins PSLEx_inactive = {0};
            // }
              
        // PENABLE_cp: coverpoint act_trans.PENABLE {
            // bins PENABLE_active = {1};
            // bins PENABLE_inactive = {0};
            // }
		
        // PSLVERR_cp: coverpoint act_trans.PSLVERR {
            // bins no_error = {0};
            // bins error = {1};
            // }		
		// PENABLExPSLEx: cross PENABLE_cp , PSLEx_cp{
		    // }
    endgroup
    
    trans_cg = new();    
      
    task run();
         act_trans = new();
         exp_trans = new();
 	 forever begin
 	    mon2scr_mbx.get(act_trans);
 	    act_que.push_back(act_trans.PRDATA);
 	 
 	    ref2scr_mbx.get(exp_trans);
         exp_que.push_back(exp_trans.PRDATA);
 	 
 	    check_data(act_trans,exp_trans);
 	    count();
      end
    endtask
    
    task check_data(apb_trans act_trans, apb_trans exp_trans);
         fork 
 	 		wait(act_que.size() != 0);
 	 		wait(exp_que.size() != 0);
 	 	join
 	 	
 	 	act_pop = act_que.pop_front();
 	 	exp_pop = exp_que.pop_front();
 	 	
 	 	if(act_pop != exp_pop) begin
 	 			fail++;
 	 			$error($time," : FAILED! EXP : %0d and ACT : %0d | Act_pop : %0d and Exp_pop : %0d",exp_trans.PRDATA,act_trans.PRDATA,act_pop,exp_pop);
 	 			end
 	 		else begin
 	 		    pass++;
 	 			$info("-----sucess-----\n|act_data = %4d |exp_data = %4d| %4t|",act_trans.PRDATA,exp_trans.PRDATA,$time);
 	         end
            trans_cg.sample();
    endtask
  
    function void count();
 	 	$display("%0d no. of times passed",pass);
 	 	$display("%0d no. of times failed",fail);
    endfunction

endclass	

`endif