`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 12:12:27
// Design Name: 
// Module Name: digital_calculator
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


module digital_calculator(
    input clk,
    input BTNL,
    input BTNU,
    input BTND,
    input [4:0] sw,
    output [6:0] seg,
    output [3:0] an
    );
    
    logic [3:0] input_number = sw[3:0];
    logic arith_operator = sw[4];
    
    logic disp_rising_edge;
    logic signed [5:0] number_1;
    logic signed [5:0] number_2;
    logic signed [5:0] result;
    logic signed [5:0] disp_result;
    logic mode;
    logic load_number_1;
    logic load_number_2;
    logic [2:0] state;
    
    input_handling handling(clk,BTNL,BTNU,BTND,disp_rising_edge);
    store_operands operands(clk,BTNL,load_number_1,load_number_2,{1'b0, input_number},number_1,number_2);
    control_logic control(clk,BTNL,input_number,BTNU,disp_rising_edge,result,arith_operator,disp_result,mode,load_number_1,load_number_2,state);
    arithmetic_operations operations(number_1,number_2,arith_operator,result);
    display_control display(clk,disp_result,mode,seg,an);
  
endmodule

