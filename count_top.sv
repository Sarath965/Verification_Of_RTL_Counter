module top();
//Import count _pkg
  import count_pkg::*;
  bit clock;
//Instantiate the interface
 count_if DUV_IF(clock);
// Handle for test
 test t_h;
// Instantiate DUV
 counter DUV(.clock(clock), 
             .data_in(DUV_IF.data_in), 
             .load(DUV_IF.load),
             .up_down(DUV_IF.up_down),
             .resetn(DUV_IF.resetn),
             .count(DUV_IF.count));

  initial
    begin
      forever
        #10 clock = ~clock;
    end
  
  initial
    begin
      if($tests$plusargs("TEST"))
        begin
          t_h = new(DUV_IF,DUV_IF,DUV_IF);
          no_of_transactions = 100;
          t_h.build();
          t_h.run();
          $finish;
        end
    end
endmodule
