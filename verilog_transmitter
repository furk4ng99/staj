`timescale 1ns / 1ps

module transmitter #(
    parameter CLOCK_RATE = 100000000,
    parameter BAUD_HEDEF = 115200
)
(
    input wire [7:0] data_in,
    input clk,       
	input tx_start,
    output tx_done,
    output tx_o
	
);

	localparam IDLE     = 2'b00;
	localparam START    = 2'b01;
	localparam DATA     = 2'b10;
	localparam STOP     = 2'b11;


	reg [7:0] data;
	reg [1:0] state = IDLE;
	reg [2:0] counter = 3'd0;
	reg [31:0] bit_timer = 0;
	reg [31:0] baud_div = CLOCK_RATE / BAUD_HEDEF - 1;
	reg tx_o_;
	reg tx_done_;

always @(posedge clk) begin
	
    case (state)
        IDLE: begin
			tx_o_ 		<= 1;
			tx_done_ 	<= 0;
			bit_timer 	<= 0;
			
			if (tx_start == 1) begin
				state <= START;
			end
        end
        START : begin
			tx_o_ <= 0;
			if (bit_timer == baud_div) begin
				
				bit_timer <= 0;
				state <= DATA;
				data <= data_in;
			end
			else begin
				bit_timer <= bit_timer + 1;
			end
        end
        DATA: begin
			tx_o_ = data[counter];
			if (counter == 7) begin
				if (bit_timer == baud_div) begin
					counter		<= 0;
					bit_timer 	<= 0;
					state 		<= STOP;
				end	
				else begin
					bit_timer <= bit_timer + 1;
				end
			end
			else begin
				if (bit_timer == baud_div) begin
					counter <= 0;
					bit_timer <= 0;
					counter <= counter + 1;
				end	
				else begin
					bit_timer <= bit_timer + 1;
				end
			end
        end
        STOP: begin				
				tx_o_ <= 1;
				if (bit_timer == baud_div) begin
					tx_done_ <= 1;
					counter <= 0;
					bit_timer <= 0;
					state <= IDLE;
				end	
				else begin
					bit_timer <= bit_timer + 1;
				end
		end
    endcase
end
assign   tx_o    = tx_o_;
assign 	 tx_done = tx_done_;
endmodule
