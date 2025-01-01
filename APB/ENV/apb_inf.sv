//apb_inf.sv

`ifndef APB_INF_SV
`define APB_INF_SV
`define ADDR_WIDTH 4
`define DATA_WIDTH 8 
`define DEPTH 16 

interface apb_inf(input PCLK);
logic RESETn;
logic [`ADDR_WIDTH-1:0]PADDAR;
logic [`DATA_WIDTH-1:0]PWDATA;
logic PSLEx;
logic PENABLE;
logic PWRITE;

logic [`DATA_WIDTH-1:0] PRDATA;
logic PREADY;
logic PSLVERR;

clocking drv_cb @(posedge PCLK);
    default input #1 output #1;
    input RESETn;
    input PREADY;
    output PADDAR;
    output PWDATA;
    output PWRITE;
	output PSLEx;
	output PENABLE;
	
  endclocking
  
  // Clocking block for monitor
  clocking mon_cb @(posedge PCLK);
    default input #1 output #1;
     input RESETn;
     input PADDAR;
     input PWDATA;
     input PWRITE;
	 input PSLEx;
	 input PENABLE;
	 input PRDATA;
     input PREADY;
     input PSLVERR;
  endclocking
  
  // Modport declarations
  modport DRV_MP (clocking drv_cb);
  modport MON_MP (clocking mon_cb);
  
    //*******************************************************************************
                                //asertion for APB//
    //*******************************************************************************    
	
	
	//***********************************IDLE***************************************
	Invalid_address_and_data_in_idle: assert property
        (@(posedge PCLK)
        (!PSLEx && !PENABLE) |-> (PADDAR === 'x && PWDATA === 'x))
        else $error("APB Protocol Error: Address or Data signals are valid during IDLE phase");
	
	PENABLE_low_in_idle: assert property
        (@(posedge PCLK)
        (!PSLEx) |-> (!PENABLE))
        else $error("APB Protocol Error: PENABLE is not low during IDLE phase");
		
	stay_in_idle: assert property
        (@(posedge PCLK)
        (!PSLEx && !PENABLE && !PWRITE) |=> !PSLEx)
        else $error("APB Protocol Error: Transition stay in IDLE");

    Transfer_to_setup: assert property
        (@(posedge PCLK)
        (!PSLEx && !PENABLE && PWRITE) |=> PSLEx)
        else $error("APB Protocol Error: Transition from IDLE to SETUP failed with PWRITE high");

	//***********************************SETUP***************************************
	
	signals_assert_in_setup : assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && !PENABLE) |-> (PADDAR !== 'x) && (PWDATA !== 'x)&&(PRDATA !== 'x)
		                                   &&(PWRITE !== 'x))
        else $error("APB Protocol Error: signals_assert_in_setup");
	
	PREADY_low_in_setup : assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && !PENABLE) |-> (!PREADY))
		else $error("APB Protocol Error: PREADY_low_in_setup");
		
	Stay_one_cycle_in_setup : assert property
	    (@(posedge PCLK)
	    (!RESETn && PSLEx && !PENABLE) |=> (!RESETn && PSLEx && PENABLE))
	    else $error("APB Protocol Error: Stay_one_cycle_in_setup");
	
	signals_stable_in_setup: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && !PENABLE) |-> $stable(PADDAR) && $stable(PWDATA)
                                           && $stable(PRDATA) && $stable(PWRITE))
        else $error("APB Protocol Error: signals must remain stable during SETUP phase");
		
		
	//***********************************ACCESS**************************************
		
	signals_stable_in_access: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && PENABLE) |-> $stable(PADDAR) && $stable(PWDATA) &&
                                          $stable(PRDATA) && $stable(PWRITE))
        else $error("APB Protocol Error: signals must remain stable during ACCESS phase");
		
	PREADY_high_in_access: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && PENABLE) |-> (PREADY == 1))
        else $error("APB Protocol Error: PREADY should be low during ACCESS phase");
		
	Transition_to_idle_from_access: assert property
        (@(posedge PCLK)
        (PSLEx && PENABLE && PREADY && PWRITE=='x) |=> (PSLEx == 0))
        else $error("APB Protocol Error: Transition to IDLE phase failed from ACCESS phase");
    
	Transition_to_setup_from_access: assert property
        (@(posedge PCLK)
        (PSLEx && PENABLE && PREADY && PWRITE !='x) |=> (PSLEx && !PENABLE))
        else $error("APB Protocol Error: Transition to setup phase failed from ACCESS phase");
		
	stay_in_access : assert property	
	    (@(posedge PCLK)
        (PSLEx && PENABLE && !PREADY ) |=> (PSLEx && PENABLE))
        else $error("APB Protocol Error: Transition to access phase failed from ACCESS phase");
		
		
		
		
		
    //***********************************PADDAR**************************************
    
    Address_in_bounds: assert property 
        (@(posedge PCLK)
        (!RESETn && PSLEx && PREADY) |-> (PADDAR < `DEPTH))
        else $error("APB Protocol Error: Address is out of bounds");
    
	//***********************************RESETn**************************************
	
	Reset_active_during_reset: assert property
        (@(posedge PCLK)
        (RESETn == 0) |-> (PSLEx == 0 && PENABLE == 0))
        else $error("APB Protocol Error: Signals active during reset");
		
	//***********************************PWDATA**************************************
	
	PWDATA_asserted_only_on_write: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx) |-> (PWRITE ? (PWDATA !== 'x) : (PWDATA === 'x)))
        else $error("APB Protocol Error: PWDATA asserted during read operation");
	
	//***********************************PRDATA**************************************
	
	PRDATA_asserted_only_on_write: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx) |-> (!PWRITE ? (PRDATA !== 'x) : (PRDATA === 'x)))
        else $error("APB Protocol Error: PRDATA asserted during write operation");
		
	//***********************************PWRITE**************************************
	PWRITE_for_pwdata: assert property
        (@(posedge PCLK)
        (!RESETn && PWRITE) |-> PWDATA)
        else $error("APB Protocol Error: PWRITE_for_pwdata");
	
	PWRITE_for_prdata: assert property
        (@(posedge PCLK)
        (!RESETn && !PWRITE) |-> PRDATA)
        else $error("APB Protocol Error: PWRITE_for_prdata");
		
	//***********************************PSLVERR**************************************
	PSLVERR_assert_on_invalid_access: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && PENABLE && PREADY && (PADDAR >= `DEPTH)) |-> (PSLVERR == 1))
        else $error("APB Protocol Error: PSLVERR must be asserted on invalid address access");

	PSLVERR_deassert_on_valid_access: assert property
        (@(posedge PCLK)
        (!RESETn && PSLEx && PENABLE && PREADY && (PADDAR < `DEPTH)) |-> (PSLVERR == 0))
        else $error("APB Protocol Error: PSLVERR must be deasserted on valid address access");

endinterface

`endif