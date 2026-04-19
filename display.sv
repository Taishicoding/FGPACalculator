`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 16.10.2024 13:23:23
//// Design Name: 
//// Module Name: display_control
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


module display_control(
    input clk,
    input signed [5:0] data,
    input display_mode,
    output logic [6:0] seg,
    output logic [3:0] an
    );
   
    logic [3:0] first_digit,second_digit,third_digit;
    logic [19:0] count_refresher;
    logic [1:0] select_digit;
    logic [5:0] sign_data_mag;
    logic is_negative;
    logic [7:0] extended_data;
   
    integer tens, ones;
   
    always @(*) begin
        if (data[5]) begin
            is_negative = 1;
            sign_data_mag = -data;
        end else begin
            is_negative = 0;
            sign_data_mag = data;
        end
       
        if (display_mode == 0) begin
            tens = sign_data_mag / 10;
            ones = sign_data_mag % 10;    
            first_digit = ones[3:0];
            second_digit = tens[3:0];
            third_digit = is_negative ? 4'hE : 4'hF;
        end else begin
            extended_data = {2'b00,sign_data_mag};
            first_digit = extended_data[3:0];    
            second_digit = extended_data[7:4];
            third_digit = is_negative ? 4'hE : 4'hF;
        end
    end
   
    always @(posedge clk) begin
        count_refresher <= count_refresher + 1;
        select_digit <= count_refresher[19:18];
    end  
   
    always @(*) begin
        case (select_digit)
            2'b00: begin
                an = 4'b1110;
                seg = display_mode ? hexa_seven_seg(first_digit) : decimal_seven_seg(first_digit);
            end
            2'b01: begin
                an = 4'b1101;
                seg = display_mode ? hexa_seven_seg(second_digit) : decimal_seven_seg(second_digit);
            end
            2'b10: begin
                an = 4'b1011;
                seg = decimal_seven_seg(third_digit);
            end
            default: begin
                an = 4'b1111;
                seg = 7'b1111111;
            end
        endcase
    end
       
    function [6:0] decimal_seven_seg;
        input [3:0] bin;
        begin
            case(bin)
                4'b0000: decimal_seven_seg = 7'b1000000;
                4'b0001: decimal_seven_seg = 7'b1111001;
                4'b0010: decimal_seven_seg = 7'b0100100;
                4'b0011: decimal_seven_seg = 7'b0110000;
                4'b0100: decimal_seven_seg = 7'b0011001;
                4'b0101: decimal_seven_seg = 7'b0010010;
                4'b0110: decimal_seven_seg = 7'b0000010;
                4'b0111: decimal_seven_seg = 7'b1111000;
                4'b1000: decimal_seven_seg = 7'b0000000;
                4'b1001: decimal_seven_seg = 7'b0010000;
                4'b1110: decimal_seven_seg = 7'b0111111;
                default: decimal_seven_seg = 7'b1111111;
            endcase
        end
    endfunction  
   
    function [6:0] hexa_seven_seg;
        input [3:0] hex;
        begin
            case(hex)
                4'b0000: hexa_seven_seg = 7'b1000000;
                4'b0001: hexa_seven_seg = 7'b1111001;
                4'b0010: hexa_seven_seg = 7'b0100100;
                4'b0011: hexa_seven_seg = 7'b0110000;
                4'b0100: hexa_seven_seg = 7'b0011001;
                4'b0101: hexa_seven_seg = 7'b0010010;
                4'b0110: hexa_seven_seg = 7'b0000010;
                4'b0111: hexa_seven_seg = 7'b1111000;
                4'b1000: hexa_seven_seg = 7'b0000000;
                4'b1001: hexa_seven_seg = 7'b0010000;
                4'b1010: hexa_seven_seg = 7'b0001000;
                4'b1011: hexa_seven_seg = 7'b0000011;
                4'b1100: hexa_seven_seg = 7'b1000110;
                4'b1101: hexa_seven_seg = 7'b0100001;
                4'b1110: hexa_seven_seg = 7'b0000110;
                4'b1111: hexa_seven_seg = 7'b0001110;
                default: hexa_seven_seg = 7'b1111111;
            endcase
        end
    endfunction
endmodule 