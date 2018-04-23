`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Instituto Tecnologico de Costa Rica
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 18.09.2017 12:00:07
// Design Name: Scary Maze
// Module Name: Grafico_nivel_1
// Project Name: Scary Maze game
// Target Devices: Nexys4
// Tool Versions: Vivado2017.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Scary_maze_top(
    input wire clk,
    input wire reset,
    input wire btn_next,
    input wire btn_up,
    input wire btn_dowm,
    input wire btn_control,
    //Salidas VGA
    output reg [2:0] RGB_VGA,
    output wire hsync,
    output wire vsync, 
    output wire [15:0]led_o,
    //Comunicaci�n con el acelerometro
    input wire miso,
    output wire ss,
    output wire mosi,
    output wire sclk,
    
    output wire [6:0] disp_seg_o,
    output wire [7:0] disp_an_o
    //output reg colicion_led
    );
    //Conexiones VGA
    wire [9:0]pixel_x;
    wire [9:0]pixel_y;
    wire p_tick;
    wire video_on;
    //Conexiones de las diferentes capas gr�ficas
    reg [2:0] rgb_reg;
    wire [2:0] rgb_titulo;
    wire [2:0] graph_rgb;
    wire [2:0] rgb_menu;
    wire [2:0] rgb_cursor1;
    wire [2:0] rgb_cursor2;
    wire [2:0] rgb_pointer_lvl1;
    wire [2:0] rgb_pointer_lvl2;
    wire [2:0] rgb_pointer_lvl3;
    wire [2:0] rgb_gameover;
    wire [2:0] rgb_nivel1;
    wire [2:0] rgb_nivel2;
    wire [2:0] rgb_nivel3;
    wire [2:0] rgb_vidas;
    wire [2:0] rgb_final;
    //Conexiones de habilitacion de las capas gr�ficas
    wire text_on;
    wire graph_on;
    wire menu_on;
    wire cursor1_on;
    wire cursor2_on;
    wire pointer_on_lvl1;
    wire pointer_on_lvl2;
    wire pointer_on_lvl3;
    wire nivel1_on;
    wire nivel2_on;
    wire nivel3_on;
    wire vidas_on;
    
    wire finalbox_lvl1;    
    wire finalbox_lvl2;
    wire finalbox_lvl3;
    
    wire  [8:0] ACCEL_X_I;
    wire [8:0]  ACCEL_Y_I;
    wire [8:0]  ACCEL_MAG_I;
    reg  [11:0] ACCEL_RADIUS = 12'H004;
    reg menu;
    
    wire [1:0] nivel;
    
    wire out_btn_next;
    wire out_btn_up;
    wire out_btn_dowm;
    wire out_btn_control;
    reg up_lvl;
    reg down_lvl;
    reg up_dif;
    reg down_dif;
    
    wire right_x; 
    wire left_x;
    wire up_y;
    wire down_y;
    
    wire vidas;
    reg colision;
    wire lim_W1_lvl1, lim1_lvl1;
    wire lim_W1_lvl2, lim1_lvl2;
    wire lim_W1_lvl3, lim1_lvl3;
    
    reg resetlvl;
    reg [7:0] seg_ani;
    reg [7:0] an_ani;
    reg disp_out;
//---------------------------------------------------------------------------------------------
//Instanciaciones de los diferentes modulos
//---------------------------------------------------------------------------------------------
//Modulo sincronizador VGA
//---------------------------------------------------------------------------------------------
    Sincronizador_VGA inst_sync(
        .clk(clk), .reset(reset),
        .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(p_tick),
        .pixel_x(pixel_x), .pixel_y(pixel_y)
        );
//---------------------------------------------------------------------------------------------
//Modulo generador del titulo del juego
//---------------------------------------------------------------------------------------------               
    Generador_titulo inst_titulo(
        .clk(clk), .video_on(video_on),
        .reset(reset), 
        .pixel_x(pixel_x), .pixel_y(pixel_y),
        .rgb_text(rgb_titulo)
        );
//---------------------------------------------------------------------------------------------
//Modulo generador del menu
//---------------------------------------------------------------------------------------------        
    Generador_menu inst_menu(
            .clk(clk), .video_on(video_on), .menu(menu),
            .pixel_x(pixel_x), .pixel_y(pixel_y),
            .rgb_text(rgb_menu), .menu_on(menu_on)
            );
//---------------------------------------------------------------------------------------------
//Modulo generador de la pantalla game over
//---------------------------------------------------------------------------------------------        
    Gameover_screen inst_gameover(
            .clk(clk), .video_on(video_on), .reset(reset),
            .pixel_x(pixel_x), .pixel_y(pixel_y),
            .rgb_gameover(rgb_gameover)
            );
//---------------------------------------------------------------------------------------------
//Modulo generador del nivel 1
//---------------------------------------------------------------------------------------------        
    Grafico_nivel_1 inst_nivel1(
            .video_on(video_on),
            .pix_x(pixel_x), .pix_y(pixel_y),
            .graph_rgb(rgb_nivel1), .graph_on(nivel1_on), .finalbox(finalbox_lvl1)
            );
//---------------------------------------------------------------------------------------------
//Modulo generador del nivel 2
//---------------------------------------------------------------------------------------------        
    Grafico_nivel_2 inst_nivel2(
            .video_on(video_on),
            .pix_x(pixel_x), .pix_y(pixel_y),
            .graph_rgb(rgb_nivel2), .graph_on(nivel2_on), .finalbox(finalbox_lvl2)
            );
//---------------------------------------------------------------------------------------------
//Modulo generador del nivel 3
//---------------------------------------------------------------------------------------------        
    Grafico_nivel_3 inst_nivel3(
            .video_on(video_on),
            .pix_x(pixel_x), .pix_y(pixel_y),
            .graph_rgb(rgb_nivel3), .graph_on(nivel3_on), .finalbox(finalbox_lvl3)
            );
//---------------------------------------------------------------------------------------------
//M�dulo generador del cursor para seleccion de nivel
//---------------------------------------------------------------------------------------------
    lvl_sel_cursor inst_lvl_sel_cursor(
                .clk(clk), .video_on(video_on),
                .btn_up(up_lvl), .btn_down(down_lvl), .reset(reset),
                .pix_x(pixel_x), .pix_y(pixel_y),
                .cursor_rgb(rgb_cursor1),
                .cursor_on(cursor1_on), .nivel(nivel)
                );     
//---------------------------------------------------------------------------------------------
//M�dulo generador del cursor para seleccion de dificultad
//---------------------------------------------------------------------------------------------
    dif_sel_cursor inst_dif_sel_cursor(
                    .clk(clk), .video_on(video_on),
                    .enable(menu),
                    .btn_up(up_dif), .btn_down(down_dif), .reset(reset),
                    .pix_x(pixel_x), .pix_y(pixel_y),
                    .cursor_rgb(rgb_cursor2),
                    .cursor_on(cursor2_on)
                    );
//---------------------------------------------------------------------------------------------
//M�dulo controlador del acelerometro
//---------------------------------------------------------------------------------------------
    Acelerometro Control_acelerometro(
                .clk(clk),                 	// 100MHz clock from on-board oscillator
                .reset(reset),
                .miso(miso),
                .mosi(mosi),
                .sclk(sclk),
                .ss(ss),
                .right_x(right_x), 
                .left_x(left_x),
                .up_y(up_y),
                .down_y(down_y)
        );
//---------------------------------------------------------------------------------------------
//M�dulo generador del puntero del juego NIVEL 1
//---------------------------------------------------------------------------------------------
    Game_pointer game_pointer(
                .clk(clk),
                .reset(out_btn_control||resetlvl),
                .reset1(reset),
                .video_on(video_on),
                .pix_x(pixel_x), .pix_y(pixel_y),
                .right_x(up_y), 
                .left_x(down_y),
                .up_y(right_x),
                .down_y(left_x),
                //.map_on(rgb_nivel1),
                .graph_rgb1(rgb_pointer_lvl1),
                .graph_on(pointer_on_lvl1),
                .lim_W1(lim_W1_lvl1), .lim1(lim1_lvl1)
    );
//---------------------------------------------------------------------------------------------
//M�dulo generador del puntero del juego NIVEL 2
//---------------------------------------------------------------------------------------------
    Game_pointer_lvl2 game_pointer_lvl2(
                .clk(clk),
                .reset(out_btn_control||resetlvl),
                .reset1(reset),
                .video_on(video_on),
                .pix_x(pixel_x), .pix_y(pixel_y),
                .right_x(up_y), 
                .left_x(down_y),
                .up_y(right_x),
                .down_y(left_x),
                //.map_on(rgb_nivel1),
                .graph_rgb1(rgb_pointer_lvl2),
                .graph_on(pointer_on_lvl2),
                .lim_W1(lim_W1_lvl2), .lim1(lim1_lvl2)
    );
//---------------------------------------------------------------------------------------------
//M�dulo generador del puntero del juego NIVEL 3
//---------------------------------------------------------------------------------------------
    Game_pointer_lvl3 game_pointer_lvl3(
                .clk(clk),
                .reset(out_btn_control||resetlvl),
                .reset1(reset),
                .video_on(video_on),
                .pix_x(pixel_x), .pix_y(pixel_y),
                .right_x(up_y), 
                .left_x(down_y),
                .up_y(right_x),
                .down_y(left_x),
                //.map_on(rgb_nivel1),
                .graph_rgb1(rgb_pointer_lvl3),
                .graph_on(pointer_on_lvl3),
                .lim_W1(lim_W1_lvl3), .lim1(lim1_lvl3)
    );

 //---------------------------------------------------------------------------------------------
//M�dulo debouncer boton next
//---------------------------------------------------------------------------------------------
    Dbncr Inst_Dbncr(
                .clk_i(clk),
                .sig_i(btn_next),
                .pls_o(out_btn_next)
                    );
 //---------------------------------------------------------------------------------------------
//M�dulo debouncer boton up
//---------------------------------------------------------------------------------------------
   Dbncr Inst_DbncrUP(
               .clk_i(clk),
               .sig_i(btn_up),
               .pls_o(out_btn_up)
                   );
 //---------------------------------------------------------------------------------------------
//M�dulo debouncer boton dowm
//---------------------------------------------------------------------------------------------
  Dbncr Inst_Dbncrdowm(
              .clk_i(clk),
              .sig_i(btn_dowm),
              .pls_o(out_btn_dowm)
                  );
 //---------------------------------------------------------------------------------------------
 //M�dulo debouncer boton CONTROL
 //---------------------------------------------------------------------------------------------
   Dbncr Inst_Dbncrcontrol(
               .clk_i(clk),
               .sig_i(btn_control),
               .pls_o(out_btn_control)
                   );
 //---------------------------------------------------------------------------------------------
//M�dulo debouncer boton CONTROL
//---------------------------------------------------------------------------------------------
    Imagen_final int_imagen_final(
    .video_on(video_on), .reset(reset), .clk(clk),
    .pixel_x(pixel_x), .pixel_y(pixel_y),
    .RGB_OUT(rgb_final)
    );
 //---------------------------------------------------------------------------------------------
//M�dulo manejo de vidas
//---------------------------------------------------------------------------------------------
Contador_vidas contador_vidas(
            .clk(clk),
            .reset(reset),
            .signal(colision),
            .count_out(vidas),
            .video_on(video_on),
            .pix_x(pixel_x), .pix_y(pixel_y),
            .vidas_rgb(rgb_vidas),
            .vidas_on(vidas_on)                  
             );                 
                  
 //---------------------------------------------------------------------------------------------
//M�dulo manejo de vidas
//---------------------------------------------------------------------------------------------
Leds Leds (
           .clk_i(clk),  
           .rst_i(reset),  
           .en_i(colision),  
           .rnl_i(colision),  
           .leds_o(led_o)
            );
 //---------------------------------------------------------------------------------------------
//M�dulo manejo de vidas
//---------------------------------------------------------------------------------------------

           
dis_loser (.clk(clk), .reset(reset), .on(disp_out), .an0(disp_an_o[0]), .an1(disp_an_o[1]), .an2(disp_an_o[2]), .an3(disp_an_o[3]),
                         .an4(disp_an_o[4]), .an5(disp_an_o[5]), .an6(disp_an_o[6]), .an7(disp_an_o[7]), .out_disp(disp_seg_o));           
                  
//---------------------------------------------------------------------------------------------
//L�gica de control del juego
//---------------------------------------------------------------------------------------------    
    reg [2:0] presente = 3'b000;
    reg [2:0]  futuro;
        
    localparam [2:0]
       Menu_nivel = 3'b000,
       Menu_dificultad  = 3'b001,
       nivel_1 = 3'b010,
       nivel_2 = 3'b011,
       nivel_3 = 3'b100,
       game_over = 3'b101,
       scary = 3'b110;

   always @(posedge clk)
     begin
        if (reset)
        begin
            futuro = 3'b000;
         end 
        else
            presente <= futuro;
             
       case (futuro)
        Menu_nivel:
        begin
            menu = 0;
            up_lvl = out_btn_up;
            down_lvl = out_btn_dowm; 
            disp_out=1'b0;

            if (p_tick)
            begin
               if (cursor1_on)
                    rgb_reg <= rgb_cursor1;
               else if (~menu_on)
                    rgb_reg <= rgb_titulo;
                else
                    rgb_reg <= rgb_menu;
             end
             RGB_VGA <= rgb_reg;
             
             if (out_btn_next)
             begin
                futuro <= presente + 1;
             end
        end
        Menu_dificultad:
        begin
            menu = 1;
            up_dif = out_btn_up;
            down_dif = out_btn_dowm; 
            if (p_tick)
            begin
               if (cursor1_on)
                    rgb_reg <= rgb_cursor1;
              else if (cursor2_on)
                    rgb_reg <= rgb_cursor2;
               else if (~menu_on)
                    rgb_reg <= rgb_titulo;
                else
                    rgb_reg <= rgb_menu;
             end
             RGB_VGA <= rgb_reg; 
             
             if ((out_btn_next)&&(nivel==2'b00))
             begin
                futuro <= presente + 1;
             end
             else if ((out_btn_next)&&(nivel==2'b01))
             begin
                futuro <= presente + 2;
             end
             else if ((out_btn_next)&&((nivel==2'b10)||(nivel==2'b11)))
             begin
                futuro <= presente + 3;
             end         
        end
        
        nivel_1:
        begin
            colision = lim1_lvl1;
            resetlvl = ~lim1_lvl1;
            if (p_tick)
            begin
               if (pointer_on_lvl1)
                    rgb_reg <= rgb_pointer_lvl1;
               else if (~nivel1_on)
                    rgb_reg <= rgb_vidas;                                       
               else 
                    rgb_reg <= rgb_nivel1;
            end
            if (lim_W1_lvl1)
            begin
                futuro <= presente + 1;
                resetlvl = 1'b1;
            end
            else if (vidas)
            begin
                futuro = 3'b101;
            end
            RGB_VGA <= rgb_reg;
            
        end
        nivel_2:
        begin
            colision = lim1_lvl2;
            resetlvl = ~lim1_lvl2;
            if (p_tick)
            begin
               if (pointer_on_lvl2)
                    rgb_reg <= rgb_pointer_lvl2; 
                else if (~nivel2_on)
                    rgb_reg <= rgb_vidas;                                         
                else 
                    rgb_reg <= rgb_nivel2;
            end
            if (lim_W1_lvl2)
            begin
                futuro <= presente + 1;
                resetlvl = 1'b1;
            end
            else if (vidas)
            begin
                futuro = 3'b101;
            end
            RGB_VGA <= rgb_reg;
            
        end
        nivel_3:
        begin
            colision = lim1_lvl3;
            resetlvl = ~lim1_lvl3;
            if (p_tick)
            begin
               if (pointer_on_lvl3)
                    rgb_reg <= rgb_pointer_lvl3; 
               else if (~nivel3_on)
                    rgb_reg <= rgb_vidas;                                         
               else 
                    rgb_reg <= rgb_nivel3;
            end
            if (lim_W1_lvl3)
            begin
                futuro = 3'b110;
                resetlvl = 1'b1;
            end
            else if (vidas)
            begin
                futuro = 3'b101;
            end
            RGB_VGA <= rgb_reg;
        end
        game_over:
        begin
            if (p_tick)
            begin
               rgb_reg <= rgb_gameover;
             end
             RGB_VGA = rgb_gameover;  
             disp_out=1'b1;
        end
        scary:
        begin
            if (p_tick)
            begin
               rgb_reg <= rgb_final;
             end
             RGB_VGA = rgb_final;  
            end
       endcase
     end

endmodule
