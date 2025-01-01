//apb_env.sv

`ifndef APB_ENV_SV
`define APB_ENV_SV

class apb_env;
	
	apb_trans trans_h;

	apb_genrator gen_h;

	apb_driver drv_h;
	
	apb_monitor mon_h;

	apb_ref_model ref_model_h;
	
	apb_scoreboard scoreboard_h;
	
	mailbox #(apb_trans) gen2drv_mbx = new();
	mailbox #(apb_trans) mon2ref_mbx = new();
	mailbox #(apb_trans) mon2scr_mbx = new();
	mailbox #(apb_trans) ref2scr_mbx = new();
	
	//driver and monitor interface
	virtual apb_inf.DRV_MP vif;
	virtual apb_inf.MON_MP mvif;
	
	function void connect(virtual apb_inf.DRV_MP vif,virtual apb_inf.MON_MP mvif);
		this.vif = vif;
		this.mvif = mvif;
		//$display("apb_enviroment");
	endfunction
	
	//create all the component in this method
	function void build();
		trans_h = new();
		//gen_h = new();
		drv_h = new();
		mon_h = new();
		ref_model_h = new();
		scoreboard_h = new();
	endfunction
  
    //call all verif sub component connect method here
	function void new_connect();
		gen_h.connect(gen2drv_mbx);
		drv_h.connect(gen2drv_mbx,vif);
		mon_h.connect(mon2ref_mbx,mon2scr_mbx,mvif);
		ref_model_h.connect(mon2ref_mbx,ref2scr_mbx);
		scoreboard_h.connect(mon2scr_mbx,ref2scr_mbx);
	endfunction
  
	task run();
	
	fork 
		gen_h.run();
		 drv_h.run();
		 mon_h.run();
		 ref_model_h.run();
		 scoreboard_h.run();
	 join_any

	endtask
endclass
`endif