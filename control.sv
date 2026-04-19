`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 12:48:27
// Design Name: 
// Module Name: control_logic
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


module control_logic(
    input clk,
    input BTNL,
    input [3:0] input_operand,
    input confirm_debounce,
    input display_mode_edge,
    input signed [5:0] output_res,
    input arith_operator,
    
    output logic signed [5:0] result_display,
    output logic display_mode,
    output logic load_operand_1,
    output logic load_operand_2,
    output logic [2:0] state
    );
    
    localparam S0_idle = 3'b000;
    localparam S1_number1 = 3'b001;
    localparam S2_number1_check = 3'b010;
    localparam S3_number2 = 3'b011;
    localparam S4_number2_check = 3'b100; 
    localparam S5_calc = 3'b101;
    
    initial begin
        load_operand_1 = 0;
        load_operand_2 = 0;
    end
    
    always @(posedge clk or posedge BTNL) begin
        if(BTNL) begin
        result_display <= 6'b000000;
        display_mode <= 0;
        state <= S0_idle;
        load_operand_1 <= 0;
        load_operand_2 <= 0;
        end
        else begin
            if(display_mode_edge) begin
                display_mode <= ~display_mode;
            end
        
        case(state)
            S0_idle: begin
                state <= S1_number1;
            end
            
            S1_number1: begin
                result_display <= $signed({1'b0,input_operand});
                if (confirm_debounce) begin
                    state <= S2_number1_check;
                    load_operand_1 <= 1;
                end
            end
            
            S2_number1_check: begin
                load_operand_1 <= 0;
                if (~confirm_debounce) begin
                    state <= S3_number2;
                end
            end  
            
            S3_number2: begin
                result_display <= $signed({1'b0,input_operand});
                    if (confirm_debounce) begin
                        state <= S4_number2_check;
                        load_operand_2 <= 1;
                    end 
            end
            
            S4_number2_check: begin
                load_operand_2 <= 0;
                if (~confirm_debounce) begin
                    state <= S5_calc;
                end
            end
            
            S5_calc: begin
                result_display <= output_res;
                end
            endcase
end
end 
endmodule
