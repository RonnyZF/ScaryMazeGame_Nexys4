`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 26.09.2017 07:13:33
// Design Name: 
// Module Name: Imagen_final
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


module Imagen_final(
    input wire video_on, reset, clk,
    input wire [9:0] pixel_x, pixel_y,
    output wire[2:0] RGB_OUT
    );
     reg bg_i=0;
    //Definici�n del registro de color
    reg [2:0] RGBreg;   
    reg [2:0] control_i = 3'b001;                    //Registro en donde se guarda el color del pixel activo.
    
    //Definici�n de variables
    wire condicion1, condicion2,usar_mp;    //Condiciones para utilizar la memoria y variable donde se guarda si estas condiciones se cumplen (usar_mp).
       wire [9:0] W,xi,yi;                     //W:tama�o horizontal del objeto    xi,yi: Posiciones horiztonal y vertical de inicio del objeto.
    wire [8:0] H;                           //Variable H que representa el tama�o vertical del objeto
    wire [8:0] direccion_mp;                //Esta variable contiene el n�mero de fila del arreglo de memoria.
    wire [0:639] mapa_bits;                 //Esta variable contiene los bits correspondientes a una l�nea horizontal de la pantalla.
    
    //Instanciamiento de la memoria
    ROM_imagen_final ROM_imagen_final(                        //Se instancia al modulo de memoria para usarlo como base de datos y adem�s obtener el valor del ancho y el alto de la imagen.
        .main_clk_i(clk),
        .address_i(direccion_mp),
        .data_o(mapa_bits),
        .W_o(W),
        .H_o(H)
        );
    
    //Definici�n de posici�n inicial del objeto.    
    assign xi = ((640-W)/2);                                                    //Se define la posicion horizontal incial del objeto, con base a su ancho para que el objeto este centrado en su pantalla
    assign yi = ((480-H)/2);                                                    //Se define la posicion vertical incial del objeto, con base a su largo para que el objeto este centrado en su pantalla
    
    
    //Definici�n de condiciones para saber si se esta en el objeto
    assign condicion1   = (xi<=pixel_x) ?   (pixel_x<(xi+W)) :   1'b0;                  //Se revisa que la posicion del pixel activo horizontal este dentro del rango del objeto, en caso de no ser asi se define como falsa.
    assign condicion2   = (yi<=pixel_y) ?   (pixel_y<(yi+H)) :   1'b0;                  //Se revisa que la posicion del pixel activo vertical se encuentre  dentro del rango del objeto, en caso de no ser asi se define como falsa.
    assign usar_mp      = ( condicion1  &&  condicion2  &&  video_on);        //Verifica que se cumplan las condiciones anteriores, y que se encuentre dentro del rango visible de la pantalla para
                                                                                //para guardar en la pantalla usar_mp que se esta dentro del objeto 
                                                                                    
    //Definici�n de variables de acceso de la memoria.                                                                            
    wire bit_actual;                                                            //Definicion de variable para guardar el bit actual.
    assign direccion_mp = (usar_mp) ?   (pixel_y-yi)  :   1'b0;                     //Define la fila del arreglo de memoria al que se quiere acceder.
    assign bit_actual   = (usar_mp) ?   mapa_bits[pixel_x-xi] :   1'b0;             //Define la columna del arreglo de memoria al que se desea acceder.
    
    //Algoritmo de asignaci�n de color
    always @(posedge clk, posedge reset)                            //Esta linea indica que el codigo que sigue se ejecutara tomando en cuenta las se�ales clk y reset cuando esten activas en alto
        begin
        if (reset)                                                         //Verifica la condicion cuando reset esta en alto.
            begin
            RGBreg          <=   3'b000;                                        //Reinicia el registro.
            end
        else
            begin
            if (usar_mp)
                begin
                if (bit_actual)
                    begin
                    RGBreg  <= control_i;       //En caso de que se este dentro del objeto y que el valor en memoria correspondiente sea de "1", enntonces sea asgina al registro el valor defind por la variable de control externa.
                    end
                else
                    begin
                    if (bg_i)
                        begin
                        RGBreg  <=   3'b111;    //En caso que se este dentro del objeto, el valor de memoria sea 0 y la variable "background" esta en alto se le asigna al pixel actual el color blanco
                        end
                    else
                        begin
                        RGBreg  <=   3'b000;    //En caso que se este dentro del objeto, el valor de memoria sea 0 y la variable "background" esta en bajo se le asigna al pixel actual el color negro
                        end
                    end
                end
            else
                begin
                RGBreg      <=   3'b000;        //En caso de que no se est� dentro el objeto, el registro RGBreg toma un valor de cero.
                end
            end
        end
    
    assign RGB_OUT = RGBreg;                      //Se asigna a la slida el valor del registro RGBreg

endmodule

