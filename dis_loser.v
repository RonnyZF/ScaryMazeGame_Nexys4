`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ronny Zarate Ferreto
// 
// Create Date: 25.09.2017 00:04:14
// Design Name: 
// Module Name: dis_loser
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


module dis_loser(

	input wire clk, reset,on,
	output reg an0,an1,an2,an3,an4,an5,an6,an7,
	output reg [6:0] out_disp
    );
	reg an00, an11, an22, an33;
	reg [6:0] reg_disp;
	reg [26:0] count1;
	reg [2:0] count2;
	reg [2:0] count;
	
	
	 //contador

//contador1
	always @ (posedge clk or posedge reset)
	
		if (reset)
			begin
				count1<=0;
				
			end
		else
			begin
				if (count1==27'b000000001011110000100000000)
					count1<=27'b000000000000000000000000000;
				else 
					count1<=count1 + 27'b000000000000000000000000001;
			end


//contador2	
	always @ (posedge clk or posedge reset)

		if (reset) 
			begin
				count2 <= 3'b000;
			end 
		else 
			begin
				if (count1==27'b000000001011110000100000000)
					count2 <= count2 + 3'b001;
				//else if ( count2 == 2'b11)
					//begin
				//		count2 <= 2'b00;
				//		count2 <= count2 + 2'b01;
					//end
			end
	
// modulo salida de encendido display	

   always @(posedge clk or posedge reset)
		if (reset)
			begin
				an0 <= 1'b1;
				an1 <= 1'b1;
				an2 <= 1'b1;
				an3 <= 1'b1;
				an4 <= 1'b1;
                an5 <= 1'b1;
                an6 <= 1'b1;
                an7 <= 1'b1;
			end
			
      else 
			if(count2 == 3'b000 && on==1'b1)
				begin
					an0 <= 1'b0;
					an1 <= 1'b1;
					an2 <= 1'b1;
					an3 <= 1'b1;
					an4 <= 1'b1;
                    an5 <= 1'b1;
                    an6 <= 1'b1;
                    an7 <= 1'b1;
					reg_disp[6:0] = 7'b0001000;

				end
			else 
				if (count2 == 3'b001 && on==1'b1)
					begin
					
						an0 <= 1'b1;
						an1 <= 1'b0;
						an2 <= 1'b1;
						an3 <= 1'b1;
						an4 <= 1'b1;
                        an5 <= 1'b1;
                        an6 <= 1'b1;
                        an7 <= 1'b1;
						//out_disp[6:0] = 7'b1111001;
						//reg_disp[7:0] = 8'b00111110;
						reg_disp[6:0] = 7'b0000110;
					end
                else 
                    if (count2 == 3'b010 && on==1'b1)
                        begin
                            an0 <= 1'b1;
                            an1 <= 1'b1;
                            an2 <= 1'b0;
                            an3 <= 1'b1;
                            an4 <= 1'b1;
                            an5 <= 1'b1;
                            an6 <= 1'b1;
                            an7 <= 1'b1;
                            //reg_disp[7:0] = 8'b01000110;
                            //out_disp[6:0] =7'b1111000;
                            reg_disp[6:0] = 7'b1000001;
                        end
                    else
                        if (count2 == 3'b011 && on==1'b1)
                            begin
                                an0 <= 1'b1;
                                an1 <= 1'b1;
                                an2 <= 1'b1;
                                an3 <= 1'b0;
                                an4 <= 1'b1;
                                an5 <= 1'b1;
                                an6 <= 1'b1;
                                an7 <= 1'b1;
                                //reg_disp[7:0] = 8'b00111101;
                                //out_disp[6:0] = 7'b0110000;
                                reg_disp[6:0] = 7'b1000000;
                            end
                        else
                            if (count2 == 3'b100 && on==1'b1)
                                begin
                                    an0 <= 1'b1;
                                    an1 <= 1'b1;
                                    an2 <= 1'b1;
                                    an3 <= 1'b1;
                                    an4 <= 1'b0;
                                    an5 <= 1'b1;
                                    an6 <= 1'b1;
                                    an7 <= 1'b1;
                                    //reg_disp[7:0] = 8'b00111101;
                                    //out_disp[6:0] = 7'b0110000;
                                    reg_disp[6:0] = 7'b0000110;
                                end
                            else
                                if (count2 == 3'b101 && on==1'b1)
                                    begin
                                        an0 <= 1'b1;
                                        an1 <= 1'b1;
                                        an2 <= 1'b1;
                                        an3 <= 1'b1;
                                        an4 <= 1'b1;
                                        an5 <= 1'b0;
                                        an6 <= 1'b1;
                                        an7 <= 1'b1;
                                        reg_disp[6:0] = 7'b1001000;
                                    //reg_disp[7:0] = 8'b00111101;
                                    //out_disp[6:0] = 7'b0110000;
                                    end

                                 else
                                      if (count2 == 3'b110 && on==1'b1)
                                           begin
                                               an0 <= 1'b1;
                                               an1 <= 1'b1;
                                               an2 <= 1'b1;
                                               an3 <= 1'b1;
                                               an4 <= 1'b1;
                                               an5 <= 1'b1;
                                               an6 <= 1'b0;
                                               an7 <= 1'b1;
                                               reg_disp[6:0] = 7'b0001000;
                                               //reg_disp[7:0] = 8'b00111101;
                                               //out_disp[6:0] = 7'b0110000;
                                           end
                                    else
                                        if (count2 == 3'b111 && on==1'b1)
                                            begin
                                              an0 <= 1'b1;
                                              an1 <= 1'b1;
                                              an2 <= 1'b1;
                                              an3 <= 1'b1;
                                              an4 <= 1'b1;
                                              an5 <= 1'b1;
                                              an6 <= 1'b1;
                                              an7 <= 1'b0;
                                              reg_disp[6:0] = 7'b0000010;
                                      //reg_disp[7:0] = 8'b00111101;
                                      //out_disp[6:0] = 7'b0110000;
                                            end
                                        else
                                            begin
                                                an0 <= 1'b1;
                                                an1 <= 1'b1;
                                                an2 <= 1'b1;
                                                an3 <= 1'b1;
                                                an4 <= 1'b1;
                                                an5 <= 1'b1;
                                                an6 <= 1'b1;
                                                an7 <= 1'b1;
                                            end
                                        
                                
	always @*
		begin
			case (reg_disp)                 // gfedcba
				7'b0001000: out_disp[6:0] = 7'b0001000; //R
				7'b0000110: out_disp[6:0] = 7'b0000110; //E
				7'b1000001: out_disp[6:0] = 7'b1000001; //V
				7'b1000000: out_disp[6:0] = 7'b1000000; //O
				7'b0000110: out_disp[6:0] = 7'b0000110; //E
				7'b1001000: out_disp[6:0] = 7'b1001000; //M
				7'b0001000: out_disp[6:0] = 7'b0001000; //A
				7'b0000010: out_disp[6:0] = 7'b0000010; //G
				default: out_disp[6:0] = 7'b1111111;
			endcase
		end
endmodule
