module incomp_state_spec(curr_state, flag);
  input [1:0] curr_state;   // 2-bit input
  output reg [1:0] flag;    // Changed output to reg since it's assigned in always block

  always @(curr_state) begin
    case (curr_state)         
      2'b00, 2'b01: flag = 2'b10; // Assign 2 to flag
      2'b11: flag = 2'b00;        // Assign 0 to flag
      default: flag = 2'bxx;      // Incomplete specification (default case)
    endcase
  end
endmodule

// TESTBENCH///

module tb_incomp_state_spec;

  // Testbench variables
  reg [1:0] curr_state;  // Input to the module
  wire [1:0] flag;       // Output from the module

  // Instantiate the module
  incomp_state_spec uut (
    .curr_state(curr_state),
    .flag(flag)
  );

  // Stimulus block
  initial begin
    $monitor("Time = %0t | curr_state = %b | flag = %b", $time, curr_state, flag);

    // Apply all possible states to curr_state
    curr_state = 2'b00; #10;  // Test case: 0
    curr_state = 2'b01; #10;  // Test case: 1
    curr_state = 2'b10; #10;  // Test case: undefined (incomplete state)
    curr_state = 2'b11; #10;  // Test case: 3

    // End simulation
    $finish;
  end

  // Waveform generation
  initial begin
    $dumpfile("incomp_state_spec_waveform.vcd"); // Name of waveform file
    $dumpvars(0, tb_incomp_state_spec);          // Dump all variables in the module
  end

endmodule




/*  OUTPUT

Time = 0 | curr_state = 00 | flag = 10
Time = 10 | curr_state = 01 | flag = 10
Time = 20 | curr_state = 10 | flag = xx
Time = 30 | curr_state = 11 | flag = 00    */
