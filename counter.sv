module counter (
  input clock,
  input [3:0] din, 
  input load, 
  input up_down, 
  input resetn, 
  output reg[3:0] count);

  always @ (posedge clk)
    begin
      if(!resetn)
        count <= 4'b0000;
      else if (load)
        count <= din;
      else if (up_down == 0)
        begin
            if (count >= 11)
              count <= 4'b0;  
            else
              count <= count +1'b1;
        end
      else
        begin
          if ((count == 0)
            count <= 4'd11;
          else
            count <= count - 1'b1;
        end
    end
endmodule
