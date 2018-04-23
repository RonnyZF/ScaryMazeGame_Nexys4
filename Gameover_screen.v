`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 18.09.2017 02:17:20
// Design Name: 
// Module Name: Gameover_screen
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


module Gameover_screen(
    input wire clk,
    input wire video_on,reset,
    input wire [9:0] pixel_x, pixel_y,
    output reg [2:0] rgb_gameover
    );                   
    
    // signal declaration
    wire [10:0] rom_addr;
    wire [6:0] char_addr;
    wire [3:0] row_addr;
    wire [2:0] bit_addr;
    wire [7:0] font_word;
    wire font_bit, text_bit_on;
    wire [2:0] sw_reg;
    
    //  Instanceación del módulo de Memoria.
    Gameover_rom memoria3(
    .clk(clk),
    .addr(rom_addr),
    .data(font_word)
    );
    //********************************************************************************
    
    assign char_addr = {pixel_y[7:6], pixel_x[9:5]};
    assign row_addr = pixel_y[5:2];
    assign bit_addr = pixel_x[4:2];
    assign rom_addr = {char_addr, row_addr};
    assign font_bit = font_word[~bit_addr];
    assign text_bit_on = (1<=pixel_x) && (pixel_x<=639) && (128<=pixel_y) && (pixel_y<=384) ? font_bit : 1'b0;
    
    reg [31:0] count;
    reg [2:0] color;
     
    always @ (posedge(clk), posedge(reset))
        begin
            if (reset == 1'b1)
                begin
                count <= 32'b0;
                color <= 3'b000;
                end
            else if (color == 3'b000)
                        begin
                        color <= 001;
                        end                  
            else if (count == 32'b00000101111101011110000100000000)
                begin
                count <= 32'b0;
                color <= color + 1;
                end
              
            else
                begin
                count <= count + 1;
                end
    end
    // rgb multiplexing circuit
    
    always @*   //  Siempre que exista una lógica combinacional:
        if (~video_on)  //  Si vide_on no está encendidad:
            rgb_gameover = 3'b000; //  La pantalla se torna de color blanco.
        else    //  Sino,
            begin
            if (~text_bit_on)    //  Si la señal text_bit_on está encendida:
                begin
                rgb_gameover = 3'b000;  //  La pantalla se torna de color verde.
                end
            else    //  Sino,
                if (font_bit)
                begin
                rgb_gameover = color; 
                end
            else
                begin
                rgb_gameover = 3'b000;
                end
            end 
                   
    endmodule  
