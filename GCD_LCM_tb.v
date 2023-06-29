`timescale 1ns/1ns
`include "GCD_LCM.v"

module GCD_LCM_tb;
reg clk, rst_n,start;
reg [size-1:0] data_in;
wire [size-1:0] gcd;
wire [size*2:0] lcm;
wire done;


localparam size = 8;
// logic clk = 0;

// logic rst_n;

// logic start;

// logic done;

// logic [size-1:0] data_in,gcd,lcm;

 

GCD_LCM

#(

    .SIZE(size)

) calc (

    .rst_n (rst_n),

    .clk (clk),

    .start(start),

    .done(done),

    .data_in(data_in),

    .gcd(gcd),

    .lcm(lcm)

);

 initial 
 begin
 $dumpfile("GCD_LCM_tb.vcd"); 
 $dumpvars(0,GCD_LCM_tb);
end 

localparam CLK_PERIOD = 100;

initial clk=0;
always #(CLK_PERIOD/2) clk=~clk;

initial begin

    rst_n = 1'b0; start = 1'b0; data_in = 0;

    #(20) rst_n = 1'b1; start = 1'b1; data_in = 100;

    #(CLK_PERIOD) start = 1'b0; data_in = 20;

    #(CLK_PERIOD*20) $finish();

end
endmodule