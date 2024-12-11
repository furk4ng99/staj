module tb_receiver();

    parameter CLOCK_RATE = 100000000; 
    parameter BAUD_HEDEF = 115200; 
	
    reg rx_i;
    reg clk;
    reg rx_start;
    wire rx_done;
    wire [7:0] rx_out;
	
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end
    receiver #(CLOCK_RATE, BAUD_HEDEF) u_receiver(
        .rx_i(rx_i),
        .clk(clk),
        .rx_done(rx_done),
        .rx_out(rx_out)
    );
    initial begin
        rx_start = 0;
        rx_i = 1; 
        #50;
        rx_start = 1;
        rx_i = 0;  
        #43450;
        rx_i = 1; 
        #86800;
        rx_i = 0; 
        #86800;
        rx_i = 1; 
        #86800;
        rx_i = 0; 
        #86800;
        rx_i = 1;  
        #86800;
        rx_i = 0; 
        #86800;
        rx_i = 1;  
        #86800;
        rx_i = 0;
		#86800
		rx_i = 1;
        // Finish
        @(posedge rx_done);
		#86800

        $stop;
    end

endmodule
