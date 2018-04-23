`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 08.09.2017 09:39:26
// Design Name: 
// Module Name: Generador_menu
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


module Generador_menu(
    input wire clk,
    input wire video_on,
    input wire menu,
    //input wire reset,
    input wire [9:0] pixel_x, pixel_y,
    output reg [2:0] rgb_text,
    output wire menu_on
    );                   

   // signal declaration
    reg [10:0] rom_addr;
    reg [6:0] char_addr;
    reg [3:0] row_addr;
    reg [2:0] bit_addr;
    wire [7:0] font_word;
    reg font_bit, text_bit_on;
    wire [2:0] color;
    
    localparam [1:0]
       tsmall = 1'b0,
       tmedium  = 1'b1;
    
      
    //  Instanceación del módulo de Memoria.
    ROM_menu memoria1(
    .clk(clk),
    .addr(rom_addr),
    .data(font_word)
    );
//********************************************************************************
        
    always @*
    begin
      case (menu)
         tsmall:
            begin
                 char_addr <= {pixel_y[6:5], pixel_x[8:4]};                                                        
                 row_addr <= pixel_y[4:1];                                                                         
                 bit_addr <= pixel_x[3:1];                                                                         
                 rom_addr <= {char_addr, row_addr};                                                                
                 font_bit <= font_word[~bit_addr];                                                                 
                 text_bit_on <= (176<=pixel_x) && (pixel_x<=272) && (256<=pixel_y) && (pixel_y<=384) ? font_bit : 1'b0;
            end
         tmedium: // 8 data + 1 parity + 1 stop
                begin
                char_addr <= {pixel_y[6:5], pixel_x[8:4]};
                row_addr <= pixel_y[4:1];
                bit_addr <= pixel_x[3:1];
                rom_addr <= {char_addr, row_addr};
                font_bit <= font_word[~bit_addr];
                text_bit_on <= (176<=pixel_x) && (pixel_x<=512) && (256<=pixel_y) && (pixel_y<=384) ? font_bit : 1'b0;
                end
      endcase
    end
    
    assign color = (176<=pixel_x) && (pixel_x<=512) && (256<=pixel_y) && (pixel_y<=288) ? 3'b111 : 3'b100;
    assign menu_on = text_bit_on;     
    // rgb multiplexing circuit
  
    always @*   //  Siempre que exista una lógica combinacional:
        if (~video_on)  //  Si vide_on no está encendidad:
            rgb_text = 3'b000; //  La pantalla se torna de color blanco.
        else    //  Sino,
            begin
            if (~text_bit_on)    //  Si la señal text_bit_on está encendida:
                begin
                rgb_text = 3'b000;  //  La pantalla se torna de color verde.
                end
            else    //  Sino,
                if (font_bit)
                begin
                rgb_text = color; 
                end
            else
                begin
                rgb_text = 3'b000;
                end
            end 
                   
endmodule   