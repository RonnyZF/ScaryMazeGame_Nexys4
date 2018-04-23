`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2017 13:58:15
// Design Name: 
// Module Name: Comparador
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
module Comparador(
        input wire [11:0] axis_x, axis_y,
        input wire clk,
        output reg [3:0] dir_x, dir_y
        );
        
        parameter pos_cutoff=11'b00100000000; // positive threshold=128
        parameter neg_cutoff=11'b11100000000; // negative threshold=-128
        
        always@(posedge clk)
            begin
                if(axis_x[11]) // if y is negative
                begin
                     if(axis_x[10:0]<=neg_cutoff)   // assign rigth direction if less than negative threshold
                     dir_x=4'b0010;
                     else
                     dir_x=4'b0000;        // else no movement
                end	 
                else
                    begin
                     if(axis_x[10:0]>=pos_cutoff)  // assign left direction if greater than positive threshold
                     dir_x=4'b1000;
                     else
                     dir_x=4'b0000;       // else no movement
                   end
            end
            
        always@(posedge clk)
                begin
                    if(axis_y[11]) // if y is negative
                    begin
                         if(axis_y[10:0]<=neg_cutoff)   // assign rigth direction if less than negative threshold
                         dir_y=4'b0010;
                         else
                         dir_y=4'b0000;        // else no movement
                    end     
                    else
                        begin
                         if(axis_y[10:0]>=pos_cutoff)  // assign left direction if greater than positive threshold
                         dir_y=4'b1000;
                         else
                         dir_y=4'b0000;       // else no movement
                       end
                end
                 
endmodule