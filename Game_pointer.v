`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 24.09.2017 23:48:22
// Design Name: 
// Module Name: Game_pointer
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
module Game_pointer(
    input wire clk,
    input wire reset,
    input wire reset1,
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    input wire right_x, 
    input wire left_x,
    input wire up_y,
    input wire down_y,
    output wire [2:0] graph_rgb1,
    output wire graph_on,
    output wire lim_W1, lim1
    );

    reg[10:0] eje_X, eje_Y; 
    reg [2:0] graph_rgb;
    wire cub_on, bar_on;
    wire [2:0] cub_rgb, bar_rgb;
    reg [10:0] inicio_X = 324;
    reg [10:0] inicio_Y = 244;
    reg cont;
    reg [10:0] ar, ab, der, izq;
    reg [10:0] up_yt,down_yt, right_xt, left_xt;
    reg refr_tick = 1;      
    wire lim_A, lim_B,lim_C, lim_D;
      
      // PARAMETROS MAPA_1
      localparam BAR1_X_L = 140;
      localparam BAR1_X_R = 580;
      localparam BAR1_Y_T = 140;
      localparam BAR1_Y_B = 200;
      
      localparam BAR2_X_L = 520;
      localparam BAR2_X_R = 580;
      localparam BAR2_Y_T = 140;
      localparam BAR2_Y_B = 400; 
      
      localparam BAR3_X_L = 300;
      localparam BAR3_X_R = 580;
      localparam BAR3_Y_T = 340;
      localparam BAR3_Y_B = 400;
      
      localparam BAR4_X_L = 300;
      localparam BAR4_X_R = 360;
      localparam BAR4_Y_T = 220;
      localparam BAR4_Y_B = 400;
      
      localparam BAR5_X_L = 140;
      localparam BAR5_X_R = 200;
      localparam BAR5_Y_T = 140;
      localparam BAR5_Y_B = 420;
      
      localparam BAR6_X_L = 140;
      localparam BAR6_X_R = 200;
      localparam BAR6_Y_T = 400;
      localparam BAR6_Y_B = 420;
      //assign refr_tick = 1;//(pix_y==481) && (pix_x==0);
      reg [31:0] count;
      always@(posedge clk)
      begin
          if (reset==1 || reset1==1) 
              count = 32'b0;
          else if (count == 32'b00000000000011011011101110100000)
              begin
              count <= 32'b0;
              refr_tick = 1;
              end        
          else
              begin
              count <= count + 1;
              refr_tick = 0;
              end
       end
    reg cntr;
      always @(posedge clk, posedge reset)
           if (reset==1 || reset1==1) 
           begin
              eje_X <= inicio_X;
           end
           else if (refr_tick)
                if(lim1)
                begin
                     if (right_x)
                         eje_X <= eje_X +1;
                     else if (left_x)
                         eje_X <= eje_X -1;
                 end
       always @(posedge clk, posedge reset)
                if (reset==1 || reset1==1) 
                    begin
                      eje_Y <= inicio_Y;
                    end
                else if (refr_tick)
                    if(lim1)
                    begin
                     if (up_y)
                        eje_Y <= eje_Y -1;
                     else if (down_y)
                        eje_Y <= eje_Y + 1;
                     end
 // square ball
   //--------------------------------------------
   localparam BALL_SIZE = 8;
   // ball left, right boundary
   wire [9:0] ball_x_l, ball_x_r;
   // ball top, bottom boundary
   wire [9:0] ball_y_t, ball_y_b;
   // reg to track left, top position
   reg [9:0] ball_x_reg, ball_y_reg;
   wire [9:0] ball_x_next, ball_y_next;
   //--------------------------------------------
   // round ball
   //--------------------------------------------
   wire [2:0] rom_addr, rom_col;
   reg [7:0] rom_data;
   wire rom_bit;
   
      //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire sq_ball_on, rd_ball_on;
   wire [2:0] ball_rgb;

   // body
   //--------------------------------------------
   // round ball image ROM
   //--------------------------------------------
   always @*
   case (rom_addr)
      3'h0: rom_data = 8'b00111100; 
      3'h1: rom_data = 8'b01100110; 
      3'h2: rom_data = 8'b11000011; 
      3'h3: rom_data = 8'b11011011; 
      3'h4: rom_data = 8'b11011011; 
      3'h5: rom_data = 8'b11000011; 
      3'h6: rom_data = 8'b01100110; 
      3'h7: rom_data = 8'b00111100; 
   endcase

   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            ball_x_reg <= inicio_X;
            ball_y_reg <= inicio_Y;
         end
      else
         begin
            ball_x_reg <= ball_x_next;
            ball_y_reg <= ball_y_next;
         end

   //--------------------------------------------
   assign ball_x_l = ball_x_reg;
   assign ball_y_t = ball_y_reg;
   assign ball_x_r = ball_x_l + BALL_SIZE - 1;
   assign ball_y_b = ball_y_t + BALL_SIZE - 1;
   assign sq_ball_on =
            (ball_x_l<=pix_x) && (pix_x<=ball_x_r) &&
            (ball_y_t<=pix_y) && (pix_y<=ball_y_b);
   assign rom_addr = pix_y[2:0] - ball_y_t[2:0];
   assign rom_col = pix_x[2:0] - ball_x_l[2:0];
   assign rom_bit = rom_data[rom_col];
   assign rd_ball_on = sq_ball_on & rom_bit;
   assign ball_rgb = 3'b100;
     
   assign ball_x_next = eje_X;
   assign ball_y_next = eje_Y;

        assign lim_A = (((BAR1_X_L <= eje_X+3) && (eje_X+3 <=  BAR1_X_R) && 
                      (BAR1_Y_T <= eje_Y) && (eje_Y <= BAR1_Y_B) ) | (
                      (BAR2_X_L <= eje_X+3) && (eje_X+3 <=  BAR2_X_R) &&  
                      (BAR2_Y_T <= eje_Y) && (eje_Y <= BAR2_Y_B) ) | (
                      (BAR3_X_L <= eje_X+3) && (eje_X+3 <=  BAR3_X_R) && 
                      (BAR3_Y_T <= eje_Y) && (eje_Y <= BAR3_Y_B) ) | (
                      (BAR4_X_L <= eje_X+3) && (eje_X+3 <=  BAR4_X_R) && 
                      (BAR4_Y_T <= eje_Y) && (eje_Y <= BAR4_Y_B) ) | (
                      (BAR5_X_L <= eje_X+3) && (eje_X+3 <=  BAR5_X_R) && 
                      (BAR5_Y_T <= eje_Y) && (eje_Y <= BAR5_Y_B) ) | (
                      (BAR6_X_L <= eje_X+3) && (eje_X+3 <=  BAR6_X_R) && 
                      (BAR6_Y_T <= eje_Y) && (eje_Y <= BAR6_Y_B)  ));
                      
        assign lim_B = (((BAR1_X_L <= eje_X+6) && (eje_X+6 <=  BAR1_X_R) && 
                     (BAR1_Y_T <= eje_Y) && (eje_Y <= BAR1_Y_B) ) | (
                     (BAR2_X_L <= eje_X+6) && (eje_X+6 <=  BAR2_X_R) &&  
                     (BAR2_Y_T <= eje_Y) && (eje_Y <= BAR2_Y_B) ) | (
                     (BAR3_X_L <= eje_X+6) && (eje_X+6 <=  BAR3_X_R) && 
                     (BAR3_Y_T <= eje_Y) && (eje_Y <= BAR3_Y_B) ) | (
                      (BAR4_X_L <= eje_X+6) && (eje_X+6 <=  BAR4_X_R) && 
                     (BAR4_Y_T <= eje_Y) && (eje_Y <= BAR4_Y_B) ) | (
                     (BAR5_X_L <= eje_X+6) && (eje_X+6 <=  BAR5_X_R) && 
                     (BAR5_Y_T <= eje_Y) && (eje_Y <= BAR5_Y_B) ) | (
                     (BAR6_X_L <= eje_X+6) && (eje_X+6 <=  BAR6_X_R) && 
                     (BAR6_Y_T <= eje_Y) && (eje_Y <= BAR6_Y_B)  )); 
     
        assign lim_C = (((BAR1_X_L <= eje_X+3) && (eje_X+3 <=  BAR1_X_R) && 
                     (BAR1_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR1_Y_B) ) | (
                     (BAR2_X_L <= eje_X+3) && (eje_X+3 <=  BAR2_X_R) &&  
                     (BAR2_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR2_Y_B) ) | (
                     (BAR3_X_L <= eje_X+3) && (eje_X+3 <=  BAR3_X_R) && 
                     (BAR3_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR3_Y_B) ) | (
                     (BAR4_X_L <= eje_X+3) && (eje_X+3 <=  BAR4_X_R) && 
                     (BAR4_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR4_Y_B) ) | (
                     (BAR5_X_L <= eje_X+3) && (eje_X+3 <=  BAR5_X_R) && 
                     (BAR5_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR5_Y_B) ) | (
                     (BAR6_X_L <= eje_X+3) && (eje_X+3 <=  BAR6_X_R) && 
                     (BAR6_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR6_Y_B)  )); 
     
        assign lim_D =( ((BAR1_X_L <= eje_X+6) && (eje_X+6 <=  BAR1_X_R) && 
                     (BAR1_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR1_Y_B) ) | (
                     (BAR2_X_L <= eje_X+6) && (eje_X+6 <=  BAR2_X_R) &&  
                     (BAR2_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR2_Y_B) ) | (
                     (BAR3_X_L <= eje_X+6) && (eje_X+6 <=  BAR3_X_R) && 
                     (BAR3_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR3_Y_B) ) | (
                     (BAR4_X_L <= eje_X+6) && (eje_X+6 <=  BAR4_X_R) && 
                     (BAR4_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR4_Y_B) ) | (
                     (BAR5_X_L <= eje_X+6) && (eje_X+6 <=  BAR5_X_R) && 
                     (BAR5_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR5_Y_B) ) | (
                     (BAR6_X_L <= eje_X+6) && (eje_X+6 <=  BAR6_X_R) && 
                     (BAR6_Y_T <= eje_Y+8) && (eje_Y+8 <= BAR6_Y_B)  )); 
         
         assign lim_W1 = (405 <= eje_Y+8 );
   
         assign lim1 = (lim_A && lim_B && lim_C && lim_D);
    always @*
          if(~video_on)
            graph_rgb = 3'b000;
          else
          if (rd_ball_on)
             graph_rgb = ball_rgb;
         else
            graph_rgb = 3'b000;  

assign graph_rgb1 = graph_rgb;
assign graph_on = rd_ball_on;
endmodule

