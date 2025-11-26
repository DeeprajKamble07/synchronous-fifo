// testbench for synchronous fifo

module tb;
  parameter width=8,depth=8;
  reg clk,rst,wen,ren;
  reg[7:0]wdata;
  wire[7:0]rdata;
  wire full,empty;
  synfifo #(8,8) dut(clk,rst,wen,ren,wdata,rdata,full,empty);
  initial begin
    
    clk=0;
    forever #5 clk=~clk;
  end
  initial begin
    rst=1;
    #10 rst=0;
    wen=0;
    ren=0;
    wdata=0;
    
    repeat(depth) begin
      @(posedge clk);
      if(!full) begin
        wen=1;
        wdata=$random();
      end
    end
    @(posedge clk);
    wen=0;
    
    repeat(depth) begin
      @(posedge clk);
      if(!empty) begin
        ren=1;
      end
    end
    @(posedge clk);
    ren=0;
    #20 $finish;
  end
  initial begin
    $monitor("[%0t] clk=%0b rst=%0b wen=%0b ren=%0b wdata=%0d rdata=%0d full=%0d empty=%0d",$time,clk,rst,wen,ren,wdata,rdata,full,empty);
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
    
