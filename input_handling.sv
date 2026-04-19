`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 12:34:28
// Design Name: 
// Module Name: input_handling
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


module input_handling(

    input clk,
    input BTNL,
    input BTNU,
    input BTND,
    output disp_rising_edge
    );
    
    logic previous_disp;
    
    always@(posedge clk or posedge BTNL) begin
        if (BTNL) begin
            previous_disp <= 0;
        end else begin
            previous_disp <= BTND;
        end
    end
    
    assign disp_rising_edge = (~previous_disp) & BTND; 
  
endmodule

