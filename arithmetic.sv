`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 13:16:54
// Design Name: 
// Module Name: arithmetic_operations
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


module arithmetic_operations(
    input signed [5:0] operand_1, operand_2,
    input arith_operator,
    output logic signed [5:0] output_res);
    
    always_comb begin
        if (arith_operator == 1)
            output_res = operand_1 + operand_2;
        
        else if (arith_operator == 0)
            output_res = operand_1 - operand_2;
        end
endmodule
