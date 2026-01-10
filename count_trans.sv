class count trans;
  //Interface Signals. 
  rand logic [3:0]data_in; 
  rand logic load; 
  rand logic up_down; 
  rand logic resetn; 
  logic [3:0] count;
  
  //Constraints
  constraint C1 {data_in inside {[2:8]};} 
  constraint C3 {load dist {1:=30, 0:=70};} 
  constraint C4 {up_down dist {0:=50, 1:=50};} 
  constraint C5 {resetn dist {0:=10, 1:=90};}
                              
  //Display method
  virtual function void display (input string s);
    begin
      $display("......................%s.....................",s);
      $display("Up_down = %d", up_down);
      $display("load = %d", load);
      $display("data_in= %d", data_in);
      $display("coont = %d", count);
      $display("resetn = %d", resetn); 
      $display("..............................................");
    end
  endfunction
endclass
