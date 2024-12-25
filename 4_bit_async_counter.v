
// 4bit async counter

module counter(clk,rst,count);
 input clk,rst;
 output reg [3:0]count;
 always @(posedge clk or posedge rst) begin
  if(rst)
    count<=1'b0;
  else 
    count<=count+1;
  end 
endmodule



///TEST BENCH


module tb_counter;

  // Testbench variables
  reg clk;       // Clock signal
  reg rst;       // Reset signal
  wire [3:0] count; // Output of the counter

  // Instantiate the counter module
  counter uut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  // Clock generation (50% duty cycle)
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle every 5 time units
  end

  // Stimulus block
  initial begin
    // Monitor outputs
    $monitor("Time = %0t | clk = %b | rst = %b | count = %b", $time, clk, rst, count);

    // Initialize reset
    rst = 1;
    #10; // Hold reset high for 10 time units

    // Release reset
    rst = 0;
    #100; // Allow the counter to count for 100 time units

    // Apply reset again
    rst = 1;
    #10;

    // Release reset
    rst = 0;
    #50;

    // End simulation
    $finish;
  end

  // Generate waveform dump
  initial begin
    $dumpfile("counter_waveform.vcd"); // Name of the waveform file
    $dumpvars(0, tb_counter);         // Dump all variables in this module
  end

endmodule

/* OUTPUT
Time = 0 | clk = 0 | rst = 1 | count = 0000
Time = 5 | clk = 1 | rst = 1 | count = 0000
Time = 10 | clk = 0 | rst = 0 | count = 0000
Time = 15 | clk = 1 | rst = 0 | count = 0001
Time = 20 | clk = 0 | rst = 0 | count = 0001
Time = 25 | clk = 1 | rst = 0 | count = 0010
Time = 30 | clk = 0 | rst = 0 | count = 0010
Time = 35 | clk = 1 | rst = 0 | count = 0011
Time = 40 | clk = 0 | rst = 0 | count = 0011
Time = 45 | clk = 1 | rst = 0 | count = 0100
Time = 50 | clk = 0 | rst = 0 | count = 0100
Time = 55 | clk = 1 | rst = 0 | count = 0101
Time = 60 | clk = 0 | rst = 0 | count = 0101
Time = 65 | clk = 1 | rst = 0 | count = 0110
Time = 70 | clk = 0 | rst = 0 | count = 0110
Time = 75 | clk = 1 | rst = 0 | count = 0111
Time = 80 | clk = 0 | rst = 0 | count = 0111
Time = 85 | clk = 1 | rst = 0 | count = 1000
Time = 90 | clk = 0 | rst = 0 | count = 1000
Time = 95 | clk = 1 | rst = 0 | count = 1001
Time = 100 | clk = 0 | rst = 0 | count = 1001
Time = 105 | clk = 1 | rst = 0 | count = 1010
Time = 110 | clk = 0 | rst = 1 | count = 0000
Time = 115 | clk = 1 | rst = 1 | count = 0000
Time = 120 | clk = 0 | rst = 0 | count = 0000
Time = 125 | clk = 1 | rst = 0 | count = 0001
Time = 130 | clk = 0 | rst = 0 | count = 0001
Time = 135 | clk = 1 | rst = 0 | count = 0010
Time = 140 | clk = 0 | rst = 0 | count = 0010
Time = 145 | clk = 1 | rst = 0 | count = 0011
Time = 150 | clk = 0 | rst = 0 | count = 0011
Time = 155 | clk = 1 | rst = 0 | count = 0100
Time = 160 | clk = 0 | rst = 0 | count = 0100
Time = 165 | clk = 1 | rst = 0 | count = 0101
testbench.sv:45: $finish called at 170 (1s)
Time = 170 | clk = 0 | rst = 0 | count = 0101  */
