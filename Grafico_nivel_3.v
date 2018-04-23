`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 19.09.2017 00:57:52
// Design Name: 
// Module Name: Grafico_nivel_3
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

module Grafico_nivel_3(
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] graph_rgb,
    output wire graph_on,
    output wire finalbox
    );
   //--------------------------------------------
   //           BARRA 1 horizontal superior
   //--------------------------------------------
   // bar left, right boundary
   localparam ONE_BAR_X_L = 300;//
   localparam ONE_BAR_X_R = 580;//
   // bar top, bottom boundary
   localparam ONE_BAR_Y_T = 80; //204
   localparam ONE_BAR_Y_B = 120;
   //--------------------------------------------
   // 		BARRA 2 vertical derecha
   //--------------------------------------------
   // bar left, right boundary
   localparam TWO_BAR_X_L = 540;
   localparam TWO_BAR_X_R = 580;
   // bar top, bottom boundary
   localparam TWO_BAR_Y_T = 80; //204
   localparam TWO_BAR_Y_B = 400;
   //--------------------------------------------
   //            BARRA 3 horizontal inferior1
   //--------------------------------------------
   // bar left, right boundary
   localparam THREE_BAR_X_L = 400;
   localparam THREE_BAR_X_R = 580;
   // bar top, bottom boundary
   localparam THREE_BAR_Y_T = 360; //204
   localparam THREE_BAR_Y_B = 400;
   //--------------------------------------------
   //	 	BARRA 4 vertical central
   //--------------------------------------------
   // bar left, right boundary
   localparam FOUR_BAR_X_L = 300;
   localparam FOUR_BAR_X_R = 340;
   // bar top, bottom boundary8
   localparam FOUR_BAR_Y_T = 120; //204
   localparam FOUR_BAR_Y_B = 260;
   // object output signals
   //--------------------------------------------
   //	       BARRA 5 vertical central 2
   //--------------------------------------------
   // bar left, right boundary
   localparam FIVE_BAR_X_L = 400;
   localparam FIVE_BAR_X_R = 440;
   // bar top, bottom boundary
   localparam FIVE_BAR_Y_T = 280; //204
   localparam FIVE_BAR_Y_B = 400;
   // object output signals
   //--------------------------------------------
   //	       BARRA 6 vertical central 3
   //--------------------------------------------
   // bar left, right boundary
   localparam SIX_BAR_X_L = 300;
   localparam SIX_BAR_X_R = 340;
   // bar top, bottom boundary
   localparam SIX_BAR_Y_T = 280; //204
   localparam SIX_BAR_Y_B = 400;
   // object output signals
   //--------------------------------------------
   //	       BARRA 7 horizontal central
   //--------------------------------------------
   // bar left, right boundary
   localparam SEVEN_BAR_X_L = 300;
   localparam SEVEN_BAR_X_R = 440;
   // bar top, bottom boundary
   localparam SEVEN_BAR_Y_T = 280; //204
   localparam SEVEN_BAR_Y_B = 320;
   // object output signals
   //--------------------------------------------
   //	       BARRA 8 horizontal inferior 2
   //--------------------------------------------
   // bar left, right boundary
   localparam EIGHT_BAR_X_L = 280;
   localparam EIGHT_BAR_X_R = 300;
   // bar top, bottom boundary
   localparam EIGHT_BAR_Y_T = 360; //204
   localparam EIGHT_BAR_Y_B = 400;
   // object output signals
   //--------------------------------------------
   //	       BARRA 9 vertical final
   //--------------------------------------------
   // bar left, right boundary
   localparam NINE_BAR_X_L = 240;
   localparam NINE_BAR_X_R = 280;
   // bar top, bottom boundary
   localparam NINE_BAR_Y_T = 140; //204
   localparam NINE_BAR_Y_B = 400;
   // object output signals
   //--------------------------------------------
   //           BARRA 10 
   //--------------------------------------------
    
    // bar left, right boundary
    localparam TEN_BAR_X_L = 160;
    localparam TEN_BAR_X_R = 240;
    // bar top, bottom boundary
    localparam TEN_BAR_Y_T = 140; //204
    localparam TEN_BAR_Y_B = 180;
    // object output signals
   //--------------------------------------------
    //           BARRA 11 vertical final
    //--------------------------------------------
     
    // bar left, right boundary
     localparam ELEVEN_BAR_X_L = 140;
     localparam ELEVEN_BAR_X_R = 180;
     // bar top, bottom boundary
     localparam ELEVEN_BAR_Y_T = 140; //204
     localparam ELEVEN_BAR_Y_B = 400;
     // object output signals
     //--------------------------------------------
     //           BARRA 12 vertical final
     //--------------------------------------------
          
     // bar left, right boundary
      localparam TWELVE_BAR_X_L = 140;
      localparam TWELVE_BAR_X_R = 180;
     // bar top, bottom boundary
      localparam TWELVE_BAR_Y_T = 400; //204
      localparam TWELVE_BAR_Y_B = 440;
     // object output signals
          
    wire one_bar_on, two_bar_on, three_bar_on, four_bar_on, five_bar_on, six_bar_on, seven_bar_on, eight_bar_on, nine_bar_on, ten_bar_on, eleven_bar_on, twelve_bar_on;
    wire [2:0] one_bar_rgb, two_bar_rgb, three_bar_rgb, four_bar_rgb, five_bar_rgb, six_bar_rgb, seven_bar_rgb, eight_bar_rgb, nine_bar_rgb ,ten_bar_rgb, eleven_bar_rgb, twelve_bar_rgb ;
    
    // body      
   //--------------------------------------------
   //           BARRA 1 horizontal
   //--------------------------------------------    // pixel within bar
    assign one_bar_on = (ONE_BAR_X_L<=pix_x) && (pix_x<=ONE_BAR_X_R) &&
                   (ONE_BAR_Y_T<=pix_y) && (pix_y<=ONE_BAR_Y_B);
   //--------------------------------------------
   // 		BARRA 2 vertical
   //--------------------------------------------
   // pixel within bar
    assign two_bar_on = (TWO_BAR_X_L<=pix_x) && (pix_x<=TWO_BAR_X_R) &&
                   (TWO_BAR_Y_T<=pix_y) && (pix_y<=TWO_BAR_Y_B);
   //--------------------------------------------
   //            BARRA 3 horizontal 
   //--------------------------------------------
    // pixel within bar
    assign three_bar_on = (THREE_BAR_X_L<=pix_x) && (pix_x<=THREE_BAR_X_R) &&
                   (THREE_BAR_Y_T<=pix_y) && (pix_y<=THREE_BAR_Y_B);
   //--------------------------------------------
   //	 	BARRA 4 vertical
   //--------------------------------------------
    // pixel within bar
    assign four_bar_on = (FOUR_BAR_X_L<=pix_x) && (pix_x<=FOUR_BAR_X_R) &&
                   (FOUR_BAR_Y_T<=pix_y) && (pix_y<=FOUR_BAR_Y_B);
   //--------------------------------------------
   //	       BARRA 5 horizontal
   //--------------------------------------------

   // pixel within bar
    assign five_bar_on = (FIVE_BAR_X_L<=pix_x) && (pix_x<=FIVE_BAR_X_R) &&
                   (FIVE_BAR_Y_T<=pix_y) && (pix_y<=FIVE_BAR_Y_B);
   //--------------------------------------------
   //	       BARRA 6 vertical
   //--------------------------------------------
    // pixel within bar
    assign six_bar_on = (SIX_BAR_X_L<=pix_x) && (pix_x<=SIX_BAR_X_R) &&
                   (SIX_BAR_Y_T<=pix_y) && (pix_y<=SIX_BAR_Y_B);
   //--------------------------------------------
   //	       BARRA 7 horizontal
   //--------------------------------------------
    // pixel within bar
    assign seven_bar_on = (SEVEN_BAR_X_L<=pix_x) && (pix_x<=SEVEN_BAR_X_R) &&
                   (SEVEN_BAR_Y_T<=pix_y) && (pix_y<=SEVEN_BAR_Y_B);
   //--------------------------------------------
   //	       BARRA 8 vertical
   //--------------------------------------------
    // pixel within bar
    assign eight_bar_on = (EIGHT_BAR_X_L<=pix_x) && (pix_x<=EIGHT_BAR_X_R) &&
                   (EIGHT_BAR_Y_T<=pix_y) && (pix_y<=EIGHT_BAR_Y_B);
     //--------------------------------------------
    // right vertical bar
    //--------------------------------------------
   //	       BARRA 9 vertical final
   //--------------------------------------------

    // pixel within bar
    assign nine_bar_on = (NINE_BAR_X_L<=pix_x) && (pix_x<=NINE_BAR_X_R) &&
                   (NINE_BAR_Y_T<=pix_y) && (pix_y<=NINE_BAR_Y_B);
   //--------------------------------------------
   //           BARRA 10 horizontal
   //--------------------------------------------
   // pixel within bar
    assign ten_bar_on = (TEN_BAR_X_L<=pix_x) && (pix_x<=TEN_BAR_X_R) &&
                    (TEN_BAR_Y_T<=pix_y) && (pix_y<=TEN_BAR_Y_B);
    //--------------------------------------------
    //           BARRA 8 vertical
    //--------------------------------------------
     assign eleven_bar_on = (ELEVEN_BAR_X_L<=pix_x) && (pix_x<=ELEVEN_BAR_X_R) &&
                    (ELEVEN_BAR_Y_T<=pix_y) && (pix_y<=ELEVEN_BAR_Y_B);
    //--------------------------------------------
    //           BARRA 9 vertical final
    //--------------------------------------------
    
    // pixel within bar
     assign twelve_bar_on = (TWELVE_BAR_X_L<=pix_x) && (pix_x<=TWELVE_BAR_X_R) &&
                     (TWELVE_BAR_Y_T<=pix_y) && (pix_y<=TWELVE_BAR_Y_B);
    // bar rgb output
     assign twelve_bar_rgb =3'b001; // rojo
    //--------------------------------------------
    // rgb multiplexing circuit
    //--------------------------------------------
    assign graph_on = (one_bar_on)||(two_bar_on)||(three_bar_on)||(four_bar_on)||(five_bar_on)||(six_bar_on)||(seven_bar_on)||(eight_bar_on)||(nine_bar_on)||(ten_bar_on)||(eleven_bar_on)||(twelve_bar_on);
    assign finalbox = twelve_bar_rgb;
     
    always @*
    begin
      if (~video_on)
         graph_rgb = 3'b000; // blank
      else
      begin
        if (twelve_bar_on)
            graph_rgb = twelve_bar_rgb;
        else if (graph_on)
            graph_rgb = 3'b011;
         else
            graph_rgb = 3'b000; 
       end
    end
endmodule
