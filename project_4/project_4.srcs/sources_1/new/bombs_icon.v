`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 01:13:43 AM
// Design Name: 
// Module Name: bombs_icon
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


module bombs_icon
#(
	parameter			N_BOMBS = 20
)
(
        input HCLK,
        input [11:0]	pixel_row,
        input [11:0]    pixel_column,
        input [31:0]    bomb_info_reg[N_BOMBS - 1: 0],
        output reg[11:0] bomb_icon,
        output active_bomb
    );
    
    localparam ICON_ROW_SIZE = 64;
    localparam ICON_COLUMN_SIZE = 64;
    
    integer i; //number of bombs
    reg [15:0] bomb_Xposition;
    reg [11:0] bomb_Yposition;
    
    wire valid_row, valid_col;
    reg[11:0] icon_row_start, icon_row_end, icon_col_start, icon_col_end;
    reg[11:0] icon_addr;
    reg[11:0] row_addr, col_addr;
    
    icon1_mem icon1_mem(.clka(HCLK), .addra(icon_addr), .douta(bombs));
    
    always @(*) begin
        for(i = 0; i < N_BOMBS; i = i + 1) begin
           if(bomb_info_reg[i][31]) begin
                bomb_Xposition = bomb_info_reg[i][11:0];
                bomb_Yposition = bomb_info_reg[i][27:0];
          end 
          else begin
                bomb_Xposition = bomb_Xposition;
                bomb_Yposition = bomb_Yposition;
          end
           
        end
    end
    
    always @(bomb_Xposition, bomb_Yposition) begin
        icon_row_start = (bomb_Yposition * 6) - ICON_ROW_SIZE/2;
        icon_row_end   = (bomb_Yposition * 6) + ICON_ROW_SIZE/2;
        icon_col_start = (bomb_Xposition * 8) - ICON_COLUMN_SIZE/2;
        icon_col_end   = (bomb_Xposition * 8) + ICON_COLUMN_SIZE/2;          
    end
    
   
     assign valid_row = (pixel_row > icon_row_start) && (pixel_row < icon_row_end);
     assign valid_col = (pixel_column > icon_col_start) && (pixel_column < icon_col_end);
     assign active_bomb = valid_row & valid_col;
    
     always @(active_bomb) begin
       if(active_bomb) begin
                row_addr = pixel_row - icon_row_start;
                col_addr = pixel_column - icon_col_start;
                icon_addr = {row_addr[5:0], col_addr[5:0]};
        end 
        else
            icon_addr <= icon_addr;
    end
    
    
endmodule
