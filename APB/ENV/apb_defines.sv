`ifndef APB_DEFINES_SV
`define APB_DEFINES_VS

`define ADDR_WIDTH 4
`define DATA_WIDTH 8 
`define DEPTH 16

`define WRITE(PUT_TRANS_MACRO, REQ, TIMES) \
  repeat(TIMES) begin \
    if(!(REQ.randomize() with {REQ.PWRITE == 1;})) \
      $error("RANDOMIZATION FAILED!"); \
    PUT_TRANS_MACRO(REQ); \
  end
  
  
  `define READ(PUT_TRANS_MACRO, REQ, TIMES) \
  begin \
    for (int i = 0; i < TIMES; i++) begin \
      if (!(REQ.randomize() with {REQ.PWRITE == 0; REQ.PWDATA == 0;})) begin \
        $error("RANDOMIZATION FAILED!"); \
      end \
      PUT_TRANS_MACRO(REQ); \
    end \
  end


// typedef enum bit[1:0] {IDLE, READ, WRITE} trans_kind;

`endif
