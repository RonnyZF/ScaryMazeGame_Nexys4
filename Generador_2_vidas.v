`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 18.09.2017 23:41:39
// Design Name: 
// Module Name: Generador_2_vidas
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


module Generador_2_vidas(
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] graph_rgb,
    output wire graph_on
    );
    
    //-------------Corazon 1----------------------------
    //--------------------------------------------
    //         BARRA 1 vertical corazon1
    //--------------------------------------------
    // bar left, right boundary
    localparam ONE_BAR_X_L = 430;//
    localparam ONE_BAR_X_R = 435;//
    // bar top, bottom boundary
    localparam ONE_BAR_Y_T = 425; //204
    localparam ONE_BAR_Y_B = 435;
    //--------------------------------------------
    //         BARRA 2 vertical corazon1
    //--------------------------------------------
    // bar left, right boundary
    localparam TWO_BAR_X_L = 435;
    localparam TWO_BAR_X_R = 440;
    // bar top, bottom boundary
    localparam TWO_BAR_Y_T = 420; //204
    localparam TWO_BAR_Y_B = 440;
    //--------------------------------------------
    //            BARRA 3 vertical corazon1
    //--------------------------------------------
    // bar left, right boundary
    localparam THREE_BAR_X_L = 440;
    localparam THREE_BAR_X_R = 445;
    // bar top, bottom boundary
    localparam THREE_BAR_Y_T = 425; //204
    localparam THREE_BAR_Y_B = 445;
    //--------------------------------------------
    //         BARRA 4 vertical  corazon1
    //--------------------------------------------
    // bar left, right boundary
    localparam FOUR_BAR_X_L = 445;
    localparam FOUR_BAR_X_R = 450;
    // bar top, bottom boundary
    localparam FOUR_BAR_Y_T = 420; //204
    localparam FOUR_BAR_Y_B = 440;
    //--------------------------------------------
    //           BARRA 5 vertical   corazon1
    //--------------------------------------------
    // bar left, right boundary
    localparam FIVE_BAR_X_L = 450;
    localparam FIVE_BAR_X_R = 455;
    // bar top, bottom boundary
    localparam FIVE_BAR_Y_T = 425; //204
    localparam FIVE_BAR_Y_B = 435;
    
    //-------------Corazon 2----------------------------
    //--------------------------------------------
    //           BARRA 1 vertical corazon2
    //--------------------------------------------
    // bar left, right boundary
    localparam ONESD_BAR_X_L = 460;//
    localparam ONESD_BAR_X_R = 465;//
    // bar top, bottom boundary
    localparam ONESD_BAR_Y_T = 425; //204
    localparam ONESD_BAR_Y_B = 435;
    //--------------------------------------------
    //         BARRA 2 vertical corazon2
    //--------------------------------------------
    // bar left, right boundary
    localparam TWOSD_BAR_X_L = 465;
    localparam TWOSD_BAR_X_R = 470;
    // bar top, bottom boundary
    localparam TWOSD_BAR_Y_T = 420; //204
    localparam TWOSD_BAR_Y_B = 440;
    //--------------------------------------------
    //            BARRA 3 vertical corazon2
    //--------------------------------------------
    // bar left, right boundary
    localparam THREESD_BAR_X_L = 470;
    localparam THREESD_BAR_X_R = 475;
    // bar top, bottom boundary
    localparam THREESD_BAR_Y_T = 425; //204
    localparam THREESD_BAR_Y_B = 445;
    //--------------------------------------------
    //         BARRA 4 vertical corazon2
    //--------------------------------------------
    // bar left, right boundary
    localparam FOURSD_BAR_X_L = 475;
    localparam FOURSD_BAR_X_R = 480;
    // bar top, bottom boundary
    localparam FOURSD_BAR_Y_T = 420; //204
    localparam FOURSD_BAR_Y_B = 440;
    // object output signals
    //--------------------------------------------
    //           BARRA 5 vertical corazon2
    //--------------------------------------------
    // bar left, right boundary
    localparam FIVESD_BAR_X_L = 480;
    localparam FIVESD_BAR_X_R = 485;
    // bar top, bottom boundary
    localparam FIVESD_BAR_Y_T = 425; //204
    localparam FIVESD_BAR_Y_B = 435;
    //--------------------------------------------
    // object output signals
    wire one_bar_on, two_bar_on, three_bar_on, four_bar_on, five_bar_on, onesd_bar_on, twosd_bar_on, threesd_bar_on, foursd_bar_on, fivesd_bar_on;
    wire [2:0] one_bar_rgb, two_bar_rgb, three_bar_rgb, four_bar_rgb, five_bar_rgb, onesd_bar_rgb, twosd_bar_rgb, threesd_bar_rgb, foursd_bar_rgb, fivesd_bar_rgb;
    //-------------CORAZON 1----------------------------
    //--------------------------------------------
    //           BARRA 1 horizontal corazon1
    //--------------------------------------------    // pixel within bar
    assign one_bar_on = (ONE_BAR_X_L<=pix_x) && (pix_x<=ONE_BAR_X_R) &&
                   (ONE_BAR_Y_T<=pix_y) && (pix_y<=ONE_BAR_Y_B);
    //--------------------------------------------
    //         BARRA 2 vertical corazon1
    //--------------------------------------------
    // pixel within bar
    assign two_bar_on = (TWO_BAR_X_L<=pix_x) && (pix_x<=TWO_BAR_X_R) &&
                   (TWO_BAR_Y_T<=pix_y) && (pix_y<=TWO_BAR_Y_B);
    //--------------------------------------------
    //            BARRA 3 horizontal corazon1
    //--------------------------------------------
    // pixel within bar
    assign three_bar_on = (THREE_BAR_X_L<=pix_x) && (pix_x<=THREE_BAR_X_R) &&
                   (THREE_BAR_Y_T<=pix_y) && (pix_y<=THREE_BAR_Y_B);
    //--------------------------------------------
    //         BARRA 4 vertical corazon1
    //--------------------------------------------
    // pixel within bar
    assign four_bar_on = (FOUR_BAR_X_L<=pix_x) && (pix_x<=FOUR_BAR_X_R) &&
                   (FOUR_BAR_Y_T<=pix_y) && (pix_y<=FOUR_BAR_Y_B);
    //--------------------------------------------
    //           BARRA 5 horizontal corazon 1
    //--------------------------------------------
    // pixel within bar
    assign five_bar_on = (FIVE_BAR_X_L<=pix_x) && (pix_x<=FIVE_BAR_X_R) &&
                   (FIVE_BAR_Y_T<=pix_y) && (pix_y<=FIVE_BAR_Y_B);
    //-------------CORAZON 2----------------------------
    
    //--------------------------------------------
    //           BARRA 1 horizontal
    //--------------------------------------------    // pixel within bar
    assign onesd_bar_on = (ONESD_BAR_X_L<=pix_x) && (pix_x<=ONESD_BAR_X_R) &&
                   (ONESD_BAR_Y_T<=pix_y) && (pix_y<=ONESD_BAR_Y_B);
    //--------------------------------------------
    //         BARRA 2 vertical
    //--------------------------------------------
    // pixel within bar
    assign twosd_bar_on = (TWOSD_BAR_X_L<=pix_x) && (pix_x<=TWOSD_BAR_X_R) &&
                   (TWOSD_BAR_Y_T<=pix_y) && (pix_y<=TWOSD_BAR_Y_B);
    //--------------------------------------------
    //            BARRA 3 horizontal 
    //--------------------------------------------
    // pixel within bar
    assign threesd_bar_on = (THREESD_BAR_X_L<=pix_x) && (pix_x<=THREESD_BAR_X_R) &&
                   (THREESD_BAR_Y_T<=pix_y) && (pix_y<=THREESD_BAR_Y_B);
    //--------------------------------------------
    //         BARRA 4 vertical
    //--------------------------------------------
    // pixel within bar
    assign foursd_bar_on = (FOURSD_BAR_X_L<=pix_x) && (pix_x<=FOURSD_BAR_X_R) &&
                   (FOURSD_BAR_Y_T<=pix_y) && (pix_y<=FOURSD_BAR_Y_B);
    //--------------------------------------------
    //           BARRA 5 horizontal
    //--------------------------------------------
    // pixel within bar
    assign fivesd_bar_on = (FIVESD_BAR_X_L<=pix_x) && (pix_x<=FIVESD_BAR_X_R) &&
                   (FIVESD_BAR_Y_T<=pix_y) && (pix_y<=FIVESD_BAR_Y_B);
    
    assign graph_on = (one_bar_on)||(two_bar_on)||(three_bar_on)||(four_bar_on)||(five_bar_on)||(onesd_bar_on)||(twosd_bar_on)||(threesd_bar_on)||(foursd_bar_on)||(fivesd_bar_on);
    
    always @*
      if (~video_on)
         graph_rgb = 3'b000; 
      else
         if (graph_on)
            graph_rgb = 3'b100; 
         else
            graph_rgb = 3'b000; 

endmodule
