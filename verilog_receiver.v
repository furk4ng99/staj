`timescale 1ns / 1ps


module receiver#(
    parameter CLOCK_RATE = 100000000,
    parameter BAUD_HEDEF = 115200
)
(
	
	input rx_i,
	input clk,
	output rx_done,
	output [7:0] rx_out
	
    );
	
	localparam IDLE     = 2'b00;
	localparam START    = 2'b01;
	localparam DATA     = 2'b10;
	localparam STOP     = 2'b11;

	reg [2:0] counter = 3'd0;
	reg [7:0] rx_out_;
	reg data;
	reg [1:0] state = IDLE;
	reg [31:0] bit_timer = 0;
	reg [31:0] baud_div = CLOCK_RATE / BAUD_HEDEF - 1;
	reg rx_o_;
	reg rx_done_;
	
	
	always @(posedge clk) begin
	
	case(state)
	
	
		IDLE: begin
				rx_o_  		<= 0;
				rx_done_ 	<= 0;
				bit_timer 	<= 0;
				if (rx_i == 0) begin
					state <= START;
				end 
			end
			START : begin
				rx_o_ <= 0;
				if (bit_timer == baud_div/2) begin
					bit_timer <= 0;
					state <= DATA;
				end	
				else begin
					bit_timer <= bit_timer + 1;
				end
			end
			DATA: begin
					if (bit_timer == baud_div) begin
						rx_o_ 		 	 <= rx_i; // 1
						rx_out_[counter] <= rx_i; // 8 1 0
						if (counter == 7) begin
							counter		<= 0;
							bit_timer 	<= 0;
							state 		<= STOP;
						end	
						else begin
							counter <= counter + 1;
						end
						bit_timer <= 0;
					end		
					else begin
						bit_timer <= bit_timer + 1;
					end
			end
		   STOP: begin
					rx_o_ <= 1;
					if (bit_timer == baud_div) begin
						rx_done_ 	<= 1;
						counter 	<= 0;
						bit_timer 	<= 0;
						state 		<= IDLE;
					end	
					else begin
						bit_timer <= bit_timer + 1;
					end
			end	
    endcase
	end

assign rx_out = rx_out_;
assign rx_done = rx_done_;

endmodule
