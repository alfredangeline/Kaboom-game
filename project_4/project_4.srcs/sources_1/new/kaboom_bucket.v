`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 12:16:11 AM
// Design Name: 
// Module Name: kaboom_bomber
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


module kaboom_bucket(
    input HCLK,
    input [31:0]    bucket_info_reg,
    input [11:0]	pixel_row,
    input [11:0]    pixel_column,
    output[11:0]    bucket_icon,
    output      active_buket
    );
    
    localparam ICON_ROW_SIZE = 64;
    localparam ICON_COLUMN_SIZE = 64;
    
    
    wire [11:0]     LocX_reg, LocY_reg;
    assign LocX_reg = bucket_info_reg[11:0];
    assign LocY_reg = bucket_info_reg[27:16];
    
    reg valid_row, valid_col;
    reg[11:0] icon_row_start, icon_row_end, icon_col_start, icon_col_end;
    reg[11:0] icon_addr;
    reg[11:0] row_addr, col_addr;
    //assign 
    
    icon1_mem icon1_mem(.clka(HCLK), .addra(icon_addr), .douta(bucket));

    
   
    always @(LocY_reg, LocX_reg, pixel_row, pixel_column) begin
        icon_row_start = (LocY_reg * 6) - ICON_ROW_SIZE/2;
        icon_row_end   = (LocY_reg * 6) + ICON_ROW_SIZE/2;
        icon_col_start = (LocX_reg * 8)- ICON_COLUMN_SIZE/2;
        icon_col_end   = (LocX_reg * 8) + ICON_COLUMN_SIZE/2;
        
        valid_row <= (pixel_row > icon_row_start) && (pixel_row < icon_row_end);
        valid_col <= (pixel_column > icon_col_start) && (pixel_column < icon_col_end);
    end
    
    assign active_buket = valid_row & valid_col;
    
    always @(active_buket) begin 
       if(active_buket) begin
            row_addr = pixel_row - icon_row_start;
            col_addr = pixel_column - icon_col_start;
            icon_addr = {row_addr[5:0], col_addr[5:0]};
       end
    end 
    
    
    
endmodule


