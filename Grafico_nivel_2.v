`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 18.09.2017 22:09:17
// Design Name: 
// Module Name: Grafico_nivel_2
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


module Grafico_nivel_2(
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] graph_rgb,
    output wire graph_on,
    output wire finalbox
    );
    
    //-------------NIVEL2----------------------------
    //--------------------------------------------
    //           BARRA 1 HORIZONTAL SUPERIOR
    //--------------------------------------------
    // bar left, right boundary
    localparam ONE_BAR_X_L = 300;
    localparam ONE_BAR_X_R = 580;
    // bar top, bottom boundary
    localparam ONE_BAR_Y_T = 140; 
    localparam ONE_BAR_Y_B = 200;
    //--------------------------------------------
    //         BARRA 2 VERTICAL DERECHA
    //--------------------------------------------
    // bar left, right boundary
    localparam TWO_BAR_X_L = 520;
    localparam TWO_BAR_X_R = 580;
    // bar top, bottom boundary
    localparam TWO_BAR_Y_T = 140; 
    localparam TWO_BAR_Y_B = 290;
    //--------------------------------------------
    //            BARRA 3 HORIZONTAL INFERIOR 
    //--------------------------------------------
    // bar left, right boundary
    localparam THREE_BAR_X_L = 200;
    localparam THREE_BAR_X_R = 580;
    // bar top, bottom boundary
    localparam THREE_BAR_Y_T = 270; 
    localparam THREE_BAR_Y_B = 310;
    //--------------------------------------------
    //         BARRA 4 VERTICAL CENTRAL
    //--------------------------------------------
    // bar left, right boundary
    localparam FOUR_BAR_X_L = 300;
    localparam FOUR_BAR_X_R = 360;
    // bar top, bottom boundary
    localparam FOUR_BAR_Y_T = 140; 
    localparam FOUR_BAR_Y_B = 250;
    // object output signals
    //--------------------------------------------
    //           BARRA 5 VERTICAL IZQUIERDA
    //--------------------------------------------
    // bar left, right boundary
    localparam FIVE_BAR_X_L = 140;
    localparam FIVE_BAR_X_R = 200;
    // bar top, bottom boundary
    localparam FIVE_BAR_Y_T = 270; 
    localparam FIVE_BAR_Y_B = 400;
    // object output signals
    //--------------------------------------------
    //           BARRA 6 FINAL BOX!
    //--------------------------------------------
    // bar left, right boundary
    localparam SIX_BAR_X_L = 140;
    localparam SIX_BAR_X_R = 200;
    // bar top, bottom boundary
    localparam SIX_BAR_Y_T = 400; 
    localparam SIX_BAR_Y_B = 420;
    // object output signals
    
    wire one_bar_on, two_bar_on, three_bar_on, four_bar_on, five_bar_on, six_bar_on;
    wire [2:0] one_bar_rgb, two_bar_rgb, three_bar_rgb, four_bar_rgb, five_bar_rgb, six_bar_rgb;
    
    // body      
    //--------------------------------------------
    //           BARRA 1 horizontal
    //--------------------------------------------   
    // pixel within bar
    assign one_bar_on = ((ONE_BAR_X_L<=pix_x) && (pix_x<=ONE_BAR_X_R) && (ONE_BAR_Y_T<=pix_y) && (pix_y<=ONE_BAR_Y_B));
    // bar rgb output
    assign one_bar_rgb = 3'b011;   
    //--------------------------------------------
    //         BARRA 2 vertical
    //--------------------------------------------
    // pixel within bar
    assign two_bar_on = ((TWO_BAR_X_L<=pix_x) && (pix_x<=TWO_BAR_X_R) && (TWO_BAR_Y_T<=pix_y) && (pix_y<=TWO_BAR_Y_B));
    // bar rgb output
    assign two_bar_rgb =3'b011; // cian
    //--------------------------------------------
    //            BARRA 3 horizontal 
    //--------------------------------------------
    // pixel within bar
    assign three_bar_on = ((THREE_BAR_X_L<=pix_x) && (pix_x<=THREE_BAR_X_R) && (THREE_BAR_Y_T<=pix_y) && (pix_y<=THREE_BAR_Y_B));
    // bar rgb output
    assign three_bar_rgb = 3'b011; // cian
    //--------------------------------------------
    //         BARRA 4 vertical
    //--------------------------------------------
    // pixel within bar
    assign four_bar_on = ((FOUR_BAR_X_L<=pix_x) && (pix_x<=FOUR_BAR_X_R) && (FOUR_BAR_Y_T<=pix_y) && (pix_y<=FOUR_BAR_Y_B));
    // bar rgb output
    assign four_bar_rgb = 3'b011 ; // cian
    //--------------------------------------------
    //           BARRA 5 horizontal
    //--------------------------------------------
    
    // pixel within bar
    assign five_bar_on = ((FIVE_BAR_X_L<=pix_x) && (pix_x<=FIVE_BAR_X_R) && (FIVE_BAR_Y_T<=pix_y) && (pix_y<=FIVE_BAR_Y_B));
    // bar rgb output
    assign five_bar_rgb = 3'b110 ; // cian   
    //--------------------------------------------
    //           BARRA 6 horizontal
    //--------------------------------------------   
    // pixel within bar
     assign six_bar_on = ((SIX_BAR_X_L<=pix_x) && (pix_x<=SIX_BAR_X_R) && (SIX_BAR_Y_T<=pix_y) && (pix_y<=SIX_BAR_Y_B));
    // bar rgb output
     assign six_bar_rgb = 3'b001;  
    //-------------------------------------------- 
    assign graph_on = ((one_bar_on)||(two_bar_on)||(three_bar_on)||(four_bar_on)||(five_bar_on))||(six_bar_on);
    //--------------------------------------------       
    assign finalbox = six_bar_rgb;
     
    always @*
    begin
      if (~video_on)
         graph_rgb = 3'b000; // blank
      else
      begin
        if (six_bar_on)
            graph_rgb = six_bar_rgb;
        else if (graph_on)
            graph_rgb = one_bar_rgb;
         else
            graph_rgb = 3'b000; 
       end
    end
endmodule
