`timescale 1ns / 1ps

module uart_top_module(

    input rx_i,
    input clk,
    output tx_o

);
	
	reg [7:0] data_in;
	reg carpma_en;
	reg tx_start;
	reg [7:0] carpilan;
	reg [7:0] carpan;
	wire [15:0] sonuc2;
	wire [7:0] rx_out;
	wire carpma_done;
	wire tx_done;
	wire rx_done;
	reg [2:0] state = 3'd0;


	localparam RECEIVER_1 		= 3'd0;
	localparam RECEIVER_2 		= 3'd1;
	localparam CARPMA  			= 3'd2;
	localparam TRANSMITTER_1 	= 3'd3;
	localparam TRANSMITTER_2 	= 3'd4;
	localparam FINISH 			= 3'd5;

	parameter CLOCK_RATE = 100000000;
	parameter BAUD_HEDEF = 115200;

fixed_carpma carpma_inst(

	.carpma_en(carpma_en),
    .carpan(carpan),
    .carpilan(carpilan),
    .clk(clk),
    .sonuc2(sonuc2),
    .carpma_done(carpma_done)

);

transmitter tx_inst(

    .data_in(data_in),
    .clk(clk),
    .tx_start(tx_start),
    .tx_done(tx_done),
    .tx_o(tx_o)

);

receiver rx_inst(

    .rx_i(rx_i),
    .clk(clk),
    .rx_done(rx_done),
    .rx_out(rx_out)

);

always @(posedge clk) begin
	case (state)
			RECEIVER_1 : begin
				if ( rx_done) begin
					carpan <= rx_out;
					state <= RECEIVER_2;
				end
			end
			RECEIVER_2 : begin
				if ( rx_done) begin
					carpilan <= rx_out;
					state <= CARPMA;
				end
			end
			CARPMA: begin
				carpma_en <= 1;
				if (carpma_done == 1) begin
					state <= TRANSMITTER_1;
				end
			end
			TRANSMITTER_1: begin
				data_in <= sonuc2[7:0];
				tx_start <= 1'b1;
				if (tx_done == 1) begin
					state <= TRANSMITTER_2;
				end
			end
			TRANSMITTER_2: begin
				data_in <= sonuc2[15:8];
				tx_start <= 1'b1;
				if (tx_done == 1) begin
					state <= FINISH;
				end
			end
			FINISH : begin
			 // tx_start 0 oldugunda 3. dongu baslamis oluyor.
			end
	endcase
end

endmodule
