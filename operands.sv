`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 12:40:39
// Design Name: 
// Module Name: store_operands
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


module store_operands(
    input clk,
    input BTNL,
    input load_operand_1, load_operand_2,
    input [5:0] input_operand,
    output reg signed [5:0] operand1, operand2
    );
    
    always_ff @(posedge clk or posedge BTNL) begin
        if (BTNL) begin
            operand1 <= 5'b00000;
            operand2 <= 5'b00000;
        end
        
        else begin 
            if (load_operand_1) begin
                operand1 <= input_operand;
            end
            else if (load_operand_2) begin
                operand2 <= input_operand;
            end
        end
    end 
endmodule


