`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:49:48 AM
// Design Name: 
// Module Name: kaboom_if
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


module kaboom_if
#(
	parameter			N_BOMBS = 20
)
(
    input           HCLK,
    input [11:0]	pixel_row,
    input [11:0]    pixel_column,
    input [31:0]    bomber_info_reg,
    input [31:0]    bucket_info_reg,
    input [31:0]    bomb_info_reg,
    output[11:0]    bomb_icon, bomber_icon, bucket_icon,
    output          active_bomber, active_bucket, active_bombs
    );
    
    kaboom_bomber kaboom_bomber(
                            .HCLK(HCLK),
                            .bomber_info_reg(bomber_info_reg),
                            .pixel_row(pixel_row),
                            .pixel_column(pixel_column),
                            .bomber_icon(bomber_icon),
                            .active_bomber(active_bomber));
                    
   kaboom_bucket kaboom_bucket(
                           .HCLK(HCLK),
                           .bucket_info_reg(bucket_info_reg),
                           .pixel_row(pixel_row),
                           .pixel_column(pixel_column),
                           .bucket_icon(bucket_icon),
                           .active_buket(active_buket));
                           
   bombs_icon
   #(.N_BOMBS(N_BOMBS))
    (
            .HCLK(HCLK),
            .pixel_row(pixel_row),
            .pixel_column(pixel_column),
            .bomb_info_reg(bomb_info_reg),
            .bomb_icon(bomb_icon),
            .active_bomb(active_bomb)
        );
    
    
endmodule
