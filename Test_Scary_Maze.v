`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2017 03:57:46
// Design Name: 
// Module Name: Test_Scary_Maze
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


module Test_Scary_Maze(

    );
    reg clk;
    reg in_reset;
    reg btn_next;
    reg btn_up;
    reg btn_dowm;
    reg btn_control;
    //Salidas VGA
    wire [2:0] RGB_VGA;
    wire hsync;
    wire vsync; 
    //Comunicación con el acelerometro
    reg miso;
    wire ss;
    wire mosi;
    wire sclk;

    Scary_maze_top Scary_maze_test(
        .clk(clk),
        .in_reset(in_reset),
        .btn_next(btn_next),
        .btn_up(btn_up),
        .btn_dowm(btn_dowm),
        .btn_control(btn_control),
        //Salidas VGA
        .RGB_VGA(RGB_VGA),
        .hsync(hsync),
        .vsync(vsync), 
        //Comunicación con el acelerometro
        .miso(miso),
        .ss(ss),
        .mosi(mosi),
        .sclk(sclk) 
        );
         
         initial
         begin
         clk=1;
         #10 in_reset=1;
         #25 in_reset=0; 
         #5 btn_next=0;
         #5 btn_up=0; 
         #5 btn_dowm=0;
         #25 btn_control1 = 0;
         #5 miso = 0;
         #4005 miso = 1;
         #5005 miso = 0;
         #6005 miso = 1;
         #8005 miso = 0;
         #9005 miso = 1;
         #10005 miso = 1;
         #11005 miso = 0;
         #12005 miso = 1;
         #13005 miso = 1;
         #14005 miso = 0;
         #15005 miso = 1;
         #16005 miso = 0;
         #160000 btn_next = 1;
         #160200 btn_next = 0;
         #320000 btn_next=1;
         #320100 btn_next=0;
         end
         
         always
         begin
             #5 clk=~clk;
         end

        
        
        
endmodule
