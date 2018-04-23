`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 18.09.2017 23:32:19
// Design Name: 
// Module Name: Contador_vidas
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


module Contador_vidas(
    input wire clk,
    input wire reset,
    input wire signal,
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] vidas_rgb,
    output reg vidas_on,
    output reg count_out
    );
    reg [1:0] count;
    
    wire [2:0] una_vida_rgb;
    wire [2:0] dos_vidas_rgb;
    wire [2:0] tres_vidas_rgb;
    
    wire una_vida_on;
    wire dos_vidas_on;
    wire tres_vidas_on;
    
     Generador_1_vida una_vida(
        .video_on(video_on),
        .pix_x(pix_x), .pix_y(pix_y),
        .graph_rgb(una_vida_rgb),
        .graph_on(una_vida_on)
    );
    
    Generador_2_vidas dos_vidas(
        .video_on(video_on),
        .pix_x(pix_x), .pix_y(pix_y),
        .graph_rgb(dos_vidas_rgb),
        .graph_on(dos_vidas_on)
    );
    
     Generador_3_vidas tres_vidas(
        .video_on(video_on),
        .pix_x(pix_x), .pix_y(pix_y),
        .graph_rgb(tres_vidas_rgb),
        .graph_on(tres_vidas_on)
    );
    always @(negedge signal, posedge reset)
    begin
        if (reset)
            count <= 0;
        else 
            count <= count +1;   
    end
    
    always @(posedge clk)
    begin
        if (count==2'b00)
        begin
            vidas_rgb = tres_vidas_rgb;
            vidas_on = tres_vidas_on;
        end
        
        else if (count==2'b01)
        begin
            vidas_rgb = dos_vidas_rgb;
            vidas_on = dos_vidas_on;
        end  
        
        else if (count==2'b10)
        begin
            vidas_rgb = una_vida_rgb;
            vidas_on = una_vida_on;
        end
        else if (count==2'b11)
        begin
            vidas_rgb = 3'b000;
            vidas_on = tres_vidas_on;
        end       
    end
    
    always @(posedge clk)
    begin
        case(count)
        2'b11: count_out = 1'b1;
        default
        count_out = 1'b0;
        endcase
    end
        
        


endmodule