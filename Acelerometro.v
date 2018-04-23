`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 24.09.2017 21:29:30
// Design Name: 
// Module Name: Acelerometro
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


module Acelerometro(
            input wire clk,                 	// 100MHz clock from on-board oscillator
            input wire reset,
            input wire miso,
            output wire mosi,
            output wire sclk,
            output wire ss,
            output reg right_x, 
            output reg left_x,
            output reg up_y,
            output reg down_y
    );
            wire [11:0] axis_x, axis_y;
            wire [3:0] dir_x, dir_y;
            
	ADXL362Ctrl ADXL_control (
		.SYSCLK (clk),
		.RESET (reset), 
		//Accelerometer data signals
		.ACCEL_X (axis_x),
		.ACCEL_Y (axis_y),  
		.ACCEL_Z (), 
		.ACCEL_TMP (),
		.Data_Ready (),

		//SPI Interface Signals
		.SCLK (sclk),    
		.MOSI (mosi),   
		.MISO (miso),  
		.SS (ss)         
	);
    Comparador inst_comparador(
            .axis_x(axis_x),
            .axis_y(axis_y),
            .clk(clk),     
            .dir_x(dir_x),
            .dir_y(dir_y)
            );
                       
            
    always @(posedge clk)
    begin
        case(dir_x)
            4'b0010: right_x = 1'b1;
            4'b1000: left_x = 1'b1;
            default: 
            begin
            right_x = 1'b0;
            left_x = 1'b0;            
            end            
        endcase              
    end
    
    always @(posedge clk)
    begin
        case(dir_y)
            4'b0010: up_y = 1'b1;
            4'b1000: down_y = 1'b1;
            default: 
            begin
            up_y = 1'b0;
            down_y = 1'b0;            
            end            
        endcase              
    end
endmodule
