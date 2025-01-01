`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 

module AMBA_APB(
    input PCLK,
    input RESETn,
    input [(`ADDR_WIDTH - 1):0] PADDAR,
    input PSLEx,
    input PENABLE,
    input PWRITE,
    input [(`DATA_WIDTH - 1):0] PWDATA,
    
    output reg PREADY,
    output reg PSLVERR,
    output reg [(`DATA_WIDTH - 1):0] PRDATA
    );

    // Memory declaration
    reg [(`DATA_WIDTH - 1):0] mem [0:(`DEPTH - 1)];
    
    // State declaration
    parameter [1:0] idle = 2'b00;
    parameter [1:0] setup = 2'b01;
    parameter [1:0] access = 2'b10;
    
    // State declaration of present and next 
    reg [1:0] present_state, next_state;
    
    integer i;

    always @(posedge PCLK) begin
        if(!RESETn) begin
            present_state <= idle;
		    
            for (i = 0; i < `DEPTH; i = i + 1) begin
              mem[i] <= `DATA_WIDTH'd0;
            end
	    end
        
		else begin
          present_state <= next_state;
        end
    end
    
    always @(*) begin
        case (present_state)
            idle: begin
                if ((PSLEx) && (!PENABLE)) begin  
                    next_state <= setup;
                end 
				else begin
                    next_state <= idle;
                end
                    PREADY <= 0;
            end
		    
            setup: begin
                if ((!PENABLE) && (!PSLEx)) begin 
                    next_state <= idle; 
                end 
				else if (PENABLE && PSLEx) begin
                    next_state <= access;
                    PREADY <= 1;
                end 
				else begin
                    next_state <= setup;
                end
            end
		    
            access: begin
                if ((!PENABLE) && (!PSLEx)) begin
                    next_state <= idle;
                    PREADY <= 0;
                end 
				else if ((PSLEx) && (!PENABLE)) begin
                    next_state <= setup;
                end 
				else begin
                    if (PREADY == 1) begin
                        if (PADDAR >= (1 << `ADDR_WIDTH)) begin
                            PSLVERR <= 1;  
                        end 
						else begin
                            if(PWRITE == 1) begin
                                mem[PADDAR] <= PWDATA;
                                PSLVERR <= 0;
                            end 
						    else begin
                                PRDATA <= mem[PADDAR];
                                PSLVERR <= 0;
                            end
                        end
                    end 
					else begin 
                        next_state <= access;
                    end
                end
            end
        endcase 
    end
endmodule
