`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2020 05:24:17 AM
// Design Name: 
// Module Name: vga_colorizer
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


module VGA( 
                    input           video_on,
                    input[11:0]     Background,
                    input[11:0]     bomber,
                    input[11:0]     bombs,
                    input[11:0]     bucket,
                    input           active_bomber, active_bucket, active_bombs,
                    output reg[3:0] red,
                    output reg[3:0] green,
                    output reg[3:0] blue           
    );
           
   always @(*) begin
        if(~video_on)  begin
            {red, green, blue} <= {4'b0000, 4'b0000, 4'b0000};
        end
        else if(active_bomber)
            {red, green, blue} <= bomber;
        else if(active_bucket)
            {red, green, blue} <= bucket;
        else if(active_bombs)
            {red, green, blue} <= bombs;
        else
            {red, green, blue} <= Background;
   end
    
endmodule
