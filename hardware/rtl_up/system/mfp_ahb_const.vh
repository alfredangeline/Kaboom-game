// 
// mfp_ahb_const.vh
//
// Verilog include file with AHB definitions
// 

//---------------------------------------------------
// Physical bit-width of memory-mapped I/O interfaces
//---------------------------------------------------
`define MFP_N_LED          16
`define MFP_N_SW           16
`define MFP_N_PB           5
`define MFP_N_7SEGEN       8   //7seg digit enables (anodes)
`define MFP_N_7SEG_N       8   //7seg outputs (cathodes)
`define MFP_N_7SEG_DP      8   //7seg segment decimal point enabale  
`define MFP_N_7SEGLOW      32  //7seg lower digit value width
`define MFP_N_7SEGHI       32  //7seg ulpper digit value width 

`define MFP_IO_BOMBER_LFSR             10     //LFSR = {bomber_new Location}
`define MFP_IO_KABOOM_BOMBER_INFO      32     //BOMBER LOCATION
`define MFP_IO_KABOOM_BUCKET_INFO      32     //BUCKET LOCATION



//---------------------------------------------------
// Memory-mapped I/O addresses
//---------------------------------------------------
//ADDED
`define H_7SEGEN_N_ADDR         (32'h1f700000) //7seg digit enables
`define H_7SEGLOW_ADDR          (32'h1f700008) //7SEG lower digit values
`define H_7SEGHI_ADDR           (32'h1f700004) //7SEG upper digit values
`define H_7SEG_DP_N_ADDR        (32'h1f70000c) //7seg segment decimal point enabale 

`define H_LED_ADDR    			(32'h1f800000)
`define H_SW_ADDR   			(32'h1f800004)
`define H_PB_ADDR   			(32'h1f800008)

//rojobot ports
`define H_BOMBER_LFSR_ADDR                    (32'h1f80000c)  //(input) Bot info port
`define H_BOMBER_BOMBER_LOCATION_ADDR         (32'h1f80000c)  //(input) Bot info port
`define H_KABOOM_BUCKET_LOCATION_ADDR         (32'h1f80000c)  //(input) Bot info port
`define H_KABOOM_ACTIVE_BOMBS_ADDR            (32'h1f800010)  //(output) Bot control port
`define H_KABOOM_BOMB_ADDR                    (32'h1f800014)  //(input)  Bot update port (poll) 



//IO number definitions
`define H_LED_IONUM   			(4'h0)
`define H_SW_IONUM  			(4'h1)
`define H_PB_IONUM  			(4'h2)

//KABOOM ionums for mux
`define H_KABOOM_LFSR_IONUM                     (4'h3)
`define H_KABOOM_BOMBER_LOCATION_IONUM          (4'h4) 
`define H_KABOOM_BUCKET_LOCATION_IONUM          (4'h5) 
`define H_KABOOM_ACTIVE_BOMBS_IONUM             (4'h6) 

//ADDED
`define H_7SEGEN_IONUM          (4'h0)
`define H_7SEGHI_IONUM			(4'h1)
`define H_7SEGLO_IONUM			(4'h2)
`define H_7SEGDP_IONUM			(4'h3)

//---------------------------------------------------
// RAM addresses
//---------------------------------------------------
`define H_RAM_RESET_ADDR 		(32'h1fc?????)
`define H_RAM_ADDR	 		    (32'h0???????)
`define H_RAM_RESET_ADDR_WIDTH  (8) 
`define H_RAM_ADDR_WIDTH		(16) 

`define H_RAM_RESET_ADDR_Match  (7'h7f)
`define H_RAM_ADDR_Match 		(1'b0)
`define H_LED_ADDR_Match		(7'h7e) //also matches bot controls
//ADDED
`define H_7SEG_ADDR_Match       (7'h7d)


//---------------------------------------------------
// AHB-Lite values used by MIPSfpga core
//---------------------------------------------------

`define HTRANS_IDLE    2'b00
`define HTRANS_NONSEQ  2'b10
`define HTRANS_SEQ     2'b11

`define HBURST_SINGLE  3'b000
`define HBURST_WRAP4   3'b010

`define HSIZE_1        3'b000
`define HSIZE_2        3'b001
`define HSIZE_4        3'b010
