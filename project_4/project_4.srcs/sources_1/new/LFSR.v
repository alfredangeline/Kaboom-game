`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 03:51:31 AM
// Design Name: 
// Module Name: LFSR
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


module LFSR(
    input HCLK,
    input HRESETn,
    output reg[9:0] random_data
    );
    
    reg[9:0] Q, D;
    
    always @(posedge HCLK or negedge HRESETn) begin
        if(~HRESETn)
            D <= 10'd512;
        else 
            Q <= D; 
    end
    
    always @(*) begin
        D[0] <= Q[9]^Q[4]^Q[5];
        D[1] <= Q[0];
        D[2] <= Q[1];
        D[3] <= Q[2];
        D[4] <= Q[3];
        D[5] <= Q[4];
        D[6] <= Q[5];
        D[7] <= Q[6];
        D[8] <= Q[7];
        D[9] <= Q[8];
    end
    
    
endmodule
