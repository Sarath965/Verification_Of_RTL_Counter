class count_sb;
  
  event DONE;
  
  count_trans r_data, sb_data, cov_data;
  
  int ref_data, rm_data, data_verified;
  
  mailbox #(count_trans) ref2sb; //Local mailbox 
  mailbox #(count_trans) rdm2sb; //Local mailbox

  //Coverage model
  covergroup mem_coverage;
    option.per_instance = 1;
    
    DATA : coverpoint cov_data.data_in {
      bins LOW = {[2:3]);
      bins MID = {[4:6]};
      bins HIGH = {[7:8]};
    }

    LOAD : coverpoint cov_data.load {
      bins LOW = {0};
      bins HIGH = {1};
    }
                   
    UP_DOWN : coverpoint cov_data.up_down {
      bins LOW = {0};
      bins HIGH = {1};
    }
I
    RST : coverpoint cov_data.resetn {
      bins LOW = {0};
      bins HIGH = {1};
    }

    COUNT : coverpoint cov_data.count {
      bins LOW = (0 => 11);
      bins HIGH = (11 => 0);
    }
      
    LOADXDATA: cross LOAD, DATA, RST, UP_DOWN;
      
endgroup: mem_coverage
      
  function new(mailbox #(count_trans) ref2sb, mailbox #(count_trans) rdm2sb);
    this.ref2sb = ref2sb;
    this.rdm2sb = rdm2sb;
    mem_coverage = new();
  endfunction
      
  virtual task check(count_trans rdata);
    if(r_data.count == rdata.count)
      $display ("Count Matches");
    else
      $display("Count not matching");
    
    cov_data = new r_data;
    mem_coverage.sample();
    data_verified++;
    
    if(data_verified >= (no_of_transactions))
      begin 
        ->DONE;
      end
endtask

  virtual task start();
    fork
      while(1)
        begin
          ref2sb.get(r_data);
          ref_data++;
          rdm2sb.get(sb_data);
          rm_data++;
          check(sb_data);
        end
    join_none
  endtask

  virtual function void report();
    $display("............SCOREBOARD REPORT............");
    $display(" Data_expected = %d Data_generated = %d Data_verified= %d", ref_data, rm_data, data_verified);
    $display(".........................................");
  endfunction
  
endclass
