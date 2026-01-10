interface count_if (input bit clock);
  //Interface Signals 
  logic load;
  logic up_down;
  logic resetn;
  logic [3:0] count;
  logic [3:0] data_in;
  
  // Driver Clocking Block 
  clocking dr_cb@ (posedge clock);
    default input #1 output #1; 
    output data_in;
    output up_down;
    output resetn;
    output load;
  endclocking
  
  // write monitor clocking block 
  
  clocking wr_cb@ (posedge clock); 
    default input #1 output #1; 
    input data_in;
    input up_down;
    input load; 
    input resetn;
  endclocking
  
  // Read monitor clocking block 
  
  clocking rd_cb@ (posedge clock); 
    default input #1 output #1; 
    input count; 
  endclocking

  // Driver
  modport DRV (clocking dr_cb);
  // Write Monitor
  modport WR_MON (clocking wr_cb);
  // Read Monitor
  modport RD_MON (clocking rd cb);
    
endinterface
  
