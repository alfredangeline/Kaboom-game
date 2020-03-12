`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2020 12:59:12 AM
// Design Name: 
// Module Name: mfp_ahb_SPI
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mfp_ahb_SPI
#(
        parameter SYSCLK_HZ = 50000000,
        parameter SPI_CLK_HZ = 1000000
)
(
    input HCLK,
    input HRESETn,
    input [7:0] TX_BUFFER,
    output reg[7:0] RX_BUFFER,
    output reg TX_DONE,
    input TX_START,
    input HOLD_SS,
    
    //SPI Interface signal
    output SCLK,
    input MISO,
    output MOSI,
    output SS  
  );
    
    // Determine the division rate in order to create the 2X SCLK tick
    localparam CLK_DIV = (SYSCLK_HZ/(2*SPI_CLK_HZ)) - 1;
    
    // To generate the 2X SCLK tick, then SCLK
    integer SCLK_2X_DIV;
    wire SCLK_2X_TICK = 1'b0;
    // Internal SCLK signal
    wire SCLK_INT = 1'b0;
    
    // Enable Output Signals
    wire EN_SCLK = 1'b0;
    wire EN_SS  = 1'b0;
    
    // Control Signals 
    wire EN_SHIFT = 1'b0;       // Enable shifting the MOSI_REG and MISO_REG registers
    wire EN_LOAD_DOUT = 1'b0;   // Enable loading the Dout register
                                // from the shift register for MISO 
    wire EN_LOAD_DIN  = 1'b0;  //  Load the MOSI shift register 
    
    wire SHIFT_TICK_IN = 1'b0;  //  the moment at which the shifting is made, 
    wire SHIFT_TICK_OUT = 1'b0;  // i.e. at the SCLK frequency
    
    // State machine internal condition signals
    wire Start_Shifting = 1'b0; 
    wire Shifting_Done  = 1'b0;  
    
    //Counter for number of bits sent/received
    reg[7:0] CntBits;
    wire Reset_Counters; // to reset all the counters, when in the Idle State
    
    //Shift In and Shift Out Registers
    reg[7:0] MOSI_REG = 8'b00000000;
    reg[7:0] MISO_REG = 8'b00000000;
    
    //Pipe Done signal to ensure that data is stable at the output
    reg DONE_1  = 1'b0;
    
    
    // Define Control Signals and States. From MSB: 7:EN_LOAD_DIN, 6:EN_SHIFT, 5:Reset_Counters, 
    //                                          4:EN_SCLK, 3:EN_SS, 2:EN_LOAD_DOUT, 1:STC(1), 0:STC(0)
    wire[7:0] stIdle = 8'b10100000;
    wire[7:0] stPrepare = 8'b00001001;
    wire[7:0] stShift = 8'b01011011;
    wire[7:0] stDone = 8'b00001110;
   
    wire[7:0] StC = stIdle;
    
    // Assign the control signals first
    assign EN_LOAD_DIN    = StC[7];
    assign EN_SHIFT       = StC[6];
    assign Reset_Counters = StC[5];
    assign EN_SCLK        = StC[4];
    assign EN_SS          = StC[3];
    assign EN_LOAD_DOUT   = StC[2];
    
    //Assign the outputs
    assign SS = ((~HRESETn & (HOLD_SS | EN_SS)) ? 1'b1 : 1'b0);
    assign MOSI  = MOSI_REG[7];
    assign SCLK = (EN_SCLK ? 1'b0 : SCLK_INT);
    
    always @(posedge HCLK) begin
        if(EN_LOAD_DOUT)
            RX_BUFFER <= MISO_REG;  
        
        DONE_1 <= EN_LOAD_DOUT;
        TX_DONE   <= DONE_1; 
    end
    
    
    always @(posedge HCLK) begin
        if(Reset_Counters)
            CntBits <= 8'd0;
        else if(SHIFT_TICK_OUT) begin
            if(CntBits == 8'd7)
               CntBits <= 8'd0;
            else
               CntBits <= CntBits + 1;
        end    
    end
   
   
   // Assign the State machine internal condition signals
    
   // Start Shifting in the stPrepare state, after 
    // either a falling edge of SCLK_INT comes in a single byte transfer mode
    // or immediately after a Start command received, in multiple byte transfer mode
    assign Start_Shifting = (StC == stPrepare) & (HOLD_SS | (SCLK_INT & SCLK_2X_TICK));

    //Shifting ends when 8 bits has been transferred, 
    //at the falling edge of SCLK_INT
   assign Shifting_Done =  (StC == stShift) & (CntBits == 8'd7) & SCLK_INT & SCLK_2X_TICK; 
    
    
    
    
endmodule
