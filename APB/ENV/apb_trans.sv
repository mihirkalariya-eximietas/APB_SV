//apb_trans.sv
`ifndef APB_TRANS_SV
`define APB_TRANS_SV

class apb_trans;


// bit PCLK;
// bit RESETn;
    rand bit [`ADDR_WIDTH:0]PADDAR;
    rand bit [`DATA_WIDTH:0]PWDATA;
    bit PSLEx;
    bit PENABLE;
    rand bit PWRITE;
    
    bit [`DATA_WIDTH:0] PRDATA;
    bit PREADY;
    bit PSLVERR;
    
    bit [(`DATA_WIDTH-1) : 0] EXP_RDATA;
//bit [(`DATA_WIDTH-1) : 0] EXP_WDATA;

// constraint pwrite{
    // if (PWRITE == 1) {
        // PWDATA == 1;  
        // PRDATA == 0;  
    // } else {
        // PWDATA == 0;  
        // PRDATA == 1;  
    // }
// }
  // Constraint block
  
	
function void display(string name = "",apb_trans trans_h);
		$display("********************************************************");
		$display("%0s | address : %0d  : %0t",name,trans_h,$time);
		//$display("OPERATION     : %s                 ",this.kind_e);
		$display("PWRITE     : %0d                ",this.PWRITE); 
		$display("PWDATA     : %0d                ",this.PWDATA);
		$display("PRDATA     : %0d                ",this.PRDATA);
		$display("PADDAR     : %0d                ",this.PADDAR);
		$display("EXP_RDATA  : %0d                ",this.EXP_RDATA);
		// $display("PSLEx   : %0d                ",this.PSLEx);
		// $display("PENABLE     : %0d                ",this.PENABLE); 
		$display("********************************************************\n\n");
	endfunction
endclass

`endif