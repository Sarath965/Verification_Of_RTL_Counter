class count_driver;
  
  virtual count_if.DRV_MP dr_if;
  count_trans data2duv;
  mailbox #(count_trans) gen2dr;
  
  function new(virtual count_if.DRV_MP dr_if, mailbox #(count_trans) gen2dr);
    this.dr_if = dr_if;
    this.gen2dr = gen2dr;
  endfunction
  
  virtual task count();
    @(dr_if.dr_cb);
      dr_if.dr_cb.load <= data2duv.load;
      dr_if.dr_cb.data_in <= data2duv.data_in;
      dr_if.dr_cb.up_down <= data2duv.up_down; 
      dr_if.dr_cb.resetn <= data2duv.resetn;
  endtask
  
  virtual task start();
    fork
      begin
        forever
          begin
            gen2dr.get(data2duv);
            count();
          end
      end
    join_none
  endtask
endclass
