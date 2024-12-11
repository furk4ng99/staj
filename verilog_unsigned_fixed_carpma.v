`timescale 1ns / 1ps

module fixed_carpma #(
	parameter FRACTION      = 52, // 32 --> 23 		64 --> 52
	parameter DURUM_UST_BIT = 105 // 32 --> 47 		64 --> 105
	)
	(
	input [FRACTION:0] carpilan,
	input [FRACTION:0] carpan,
	input clk,
	output [DURUM_UST_BIT:0] sonuc2  
	);
 
	reg [7:0] durum 	= 0;
	reg [DURUM_UST_BIT:0] sonuc1 	= 0;
	reg [DURUM_UST_BIT:0] sonuc	= 0;
	integer  i = 0; // 

always @(posedge clk) begin 
    case(durum)
        0:begin
			if (carpan[i] == 0) begin // carpanin i. bitinin sifir olmasi durumu
				i 	  = i + 1;
				durum <= 0;
			end
			else begin // carpanin i. bitinin 1 olmasi durumu
				sonuc1		 		= carpilan;  // 0000000011010000
				durum 				<= 2; // durum 2'ye gidilir
			end
        end
        2:begin // carpanin i. biti bir olma durumu
				sonuc1 				= sonuc1 << i;
				durum				<=	3;
		end 
		3: begin
			sonuc 				= sonuc1 + sonuc;
			durum <= 4;
		end
        4:begin
            if (i == FRACTION) begin
			//
			end
			else begin
				i = i + 1;
				durum <= 0;
			end
         end
    endcase 
    end
   assign sonuc2 = sonuc;
endmodule 
