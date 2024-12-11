`timescale 1ns / 1ps

module tb_uart_top_module;

	reg clk;
    wire tx_o;
    reg rx_i;
    uart_top_module dut(
        .clk(clk),
        .rx_i(rx_i),
        .tx_o(tx_o)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
	
	initial begin

		rx_i <= 1'b1; 
        #1; 
        rx_i <= 1'b0;
        #8680;
        //AA
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b1;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b1;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b1;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b1;
        #8680;

        rx_i <= 1'b1;
        #8680;
        ///////////////////1
        rx_i <= 1'b0;
        #8680;
        //16
        rx_i <= 1'b1;
        #8680;
        rx_i<= 1'b1;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b1;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b0;
        #8680;
        rx_i <= 1'b0;
        #8680;
		
		#86800
		#86800
		
		$stop;
	
	end
	
endmodule
