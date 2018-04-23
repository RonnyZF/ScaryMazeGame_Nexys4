`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 12.09.2017 00:55:26
// Design Name: 
// Module Name: dif_sel_cursor
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


module dif_sel_cursor(
    input wire video_on,
    input wire enable,
    input wire clk,
    input wire reset,
    //input wire [1:0] control,
    input wire btn_up, btn_down,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] cursor_rgb,
    output wire cursor_on
    );
    
    localparam [1:0]
        first = 2'b00,
        second = 2'b01,
        third = 2'b10,
        extra = 2'b11;
    //--------------------------------------------        
    localparam centro_x0 = 323;
    localparam centro_y0 = 302;   
    //--------------------------------------------
    localparam left_BAR_X_L0 = centro_x0 - 5;
    localparam left_BAR_X_R0 = centro_x0 + 5;
    localparam left_BAR_Y_T0 = centro_y0 - 10; 
    localparam left_BAR_Y_B0 = centro_y0 + 10;
    //--------------------------------------------
    localparam right_BAR_X_L0 = centro_x0 - 10;
    localparam right_BAR_X_R0 = centro_x0 + 10;
    localparam right_BAR_Y_T0 = centro_y0 - 5; 
    localparam right_BAR_Y_B0 = centro_y0 + 5;
    //--------------------------------------------
    localparam top_BAR_X_L0 = centro_x0 - 7;
    localparam top_BAR_X_R0 = centro_x0 + 7;
    localparam top_BAR_Y_T0 = centro_y0 - 7; 
    localparam top_BAR_Y_B0 = centro_y0 + 7;
    //--------------------------------------------
    //--------------------------------------------        
     localparam centro_x1 = 323;
     localparam centro_y1 = 334;   
    //--------------------------------------------
    localparam left_BAR_X_L1 = centro_x1 - 5;
    localparam left_BAR_X_R1 = centro_x1 + 5;
    localparam left_BAR_Y_T1 = centro_y1 - 10; 
    localparam left_BAR_Y_B1 = centro_y1 + 10;
    //--------------------------------------------
    localparam right_BAR_X_L1 = centro_x1 - 10;
    localparam right_BAR_X_R1 = centro_x1 + 10;
    localparam right_BAR_Y_T1 = centro_y1 - 5; 
    localparam right_BAR_Y_B1 = centro_y1 + 5;
    //--------------------------------------------
    localparam top_BAR_X_L1 = centro_x1 - 7;
    localparam top_BAR_X_R1 = centro_x1 + 7;
    localparam top_BAR_Y_T1 = centro_y1 - 7; 
    localparam top_BAR_Y_B1 = centro_y1 + 7;
    //--------------------------------------------
    //--------------------------------------------        
      localparam centro_x2 = 323;
      localparam centro_y2 = 366;   
     //--------------------------------------------
     localparam left_BAR_X_L2 = centro_x2 - 5;
     localparam left_BAR_X_R2 = centro_x2 + 5;
     localparam left_BAR_Y_T2 = centro_y2 - 10; 
     localparam left_BAR_Y_B2 = centro_y2 + 10;
     //--------------------------------------------
     localparam right_BAR_X_L2 = centro_x2 - 10;
     localparam right_BAR_X_R2 = centro_x2 + 10;
     localparam right_BAR_Y_T2 = centro_y2 - 5; 
     localparam right_BAR_Y_B2 = centro_y2 + 5;
     //--------------------------------------------
     localparam top_BAR_X_L2 = centro_x2 - 7;
     localparam top_BAR_X_R2 = centro_x2 + 7;
     localparam top_BAR_Y_T2 = centro_y2 - 7; 
     localparam top_BAR_Y_B2 = centro_y2 + 7;
     //--------------------------------------------
    reg right_bar_on, left_bar_on, top_bar_on;
    reg [1:0] presente = 2'b00;
    reg [1:0] futuro;
    always @(posedge clk)
    begin
        if (reset)
        begin
            futuro = 2'b00;
            presente = 2'b00;
       end
        else if (btn_up)
            futuro <= presente + 3;
        else if (btn_down)
            futuro <= presente + 1;
        else if (futuro == 2'b11)
            begin
            if (btn_up)
                futuro = 2'b10;
            else if (btn_down)
                futuro = 2'b00;
            end
        else
            presente <= futuro;
         
    //always @*
     //begin
         case(presente)
             first:           
                 begin
                     top_bar_on = (top_BAR_X_L0<=pix_x) && (pix_x<=top_BAR_X_R0) && (top_BAR_Y_T0<=pix_y) && (pix_y<=top_BAR_Y_B0);
                     left_bar_on = (left_BAR_X_L0<=pix_x) && (pix_x<=left_BAR_X_R0) && (left_BAR_Y_T0<=pix_y) && (pix_y<=left_BAR_Y_B0);
                     right_bar_on = (right_BAR_X_L0<=pix_x) && (pix_x<=right_BAR_X_R0) && (right_BAR_Y_T0<=pix_y) && (pix_y<=right_BAR_Y_B0);
    
                 end
             second:
                 begin
                     top_bar_on = (top_BAR_X_L1<=pix_x) && (pix_x<=top_BAR_X_R1) && (top_BAR_Y_T1<=pix_y) && (pix_y<=top_BAR_Y_B1);
                     left_bar_on = (left_BAR_X_L1<=pix_x) && (pix_x<=left_BAR_X_R1) && (left_BAR_Y_T1<=pix_y) && (pix_y<=left_BAR_Y_B1);
                     right_bar_on = (right_BAR_X_L1<=pix_x) && (pix_x<=right_BAR_X_R1) && (right_BAR_Y_T1<=pix_y) && (pix_y<=right_BAR_Y_B1);
    
                 end
             third:
                 begin
                     top_bar_on = (top_BAR_X_L2<=pix_x) && (pix_x<=top_BAR_X_R2) && (top_BAR_Y_T2<=pix_y) && (pix_y<=top_BAR_Y_B2);
                     left_bar_on = (left_BAR_X_L2<=pix_x) && (pix_x<=left_BAR_X_R2) && (left_BAR_Y_T2<=pix_y) && (pix_y<=left_BAR_Y_B2);
                     right_bar_on = (right_BAR_X_L2<=pix_x) && (pix_x<=right_BAR_X_R2) && (right_BAR_Y_T2<=pix_y) && (pix_y<=right_BAR_Y_B2);
    
                 end
             extra:           
                 begin
                    top_bar_on = (top_BAR_X_L2<=pix_x) && (pix_x<=top_BAR_X_R2) && (top_BAR_Y_T2<=pix_y) && (pix_y<=top_BAR_Y_B2);
                    left_bar_on = (left_BAR_X_L2<=pix_x) && (pix_x<=left_BAR_X_R2) && (left_BAR_Y_T2<=pix_y) && (pix_y<=left_BAR_Y_B2);
                    right_bar_on = (right_BAR_X_L2<=pix_x) && (pix_x<=right_BAR_X_R2) && (right_BAR_Y_T2<=pix_y) && (pix_y<=right_BAR_Y_B2);
    
                 end
         endcase
     end 
    
    
    //--------------------------------------------
    // rgb multiplexing circuit
    //--------------------------------------------
    assign cursor_on = (top_bar_on)||(left_bar_on)||(right_bar_on);
    
    always @*
      if ((~video_on)||(~enable))
         cursor_rgb = 3'b000; 
      else
         if (top_bar_on)
            cursor_rgb = 3'b100;
         else if (right_bar_on)
            cursor_rgb = 3'b100;
         else if (left_bar_on)
            cursor_rgb = 3'b100;
         else
            cursor_rgb = 3'b000; 

endmodule
