// design for synchronous fifo

module synfifo#(parameter width=8,depth=8,addr=$clog2(depth))
  (input clk,rst,wen,ren, input [width-1:0] wdata, output reg [width-1:0] rdata, output full,empty);
  
  reg[width-1:0]mem[0:depth-1];
  reg [addr:0]wptr,rptr;
  
  always@(posedge clk)
    begin
      if(rst)
        wptr<=0;
      else if(wen && !full) begin
        mem[wptr]<=wdata;
        wptr<=wptr+1;
      end
    end
  
  always@(posedge clk)
    begin
      if(rst)
        rptr<=0;
      else if(ren && !empty) begin
        rdata<=mem[rptr];
        rptr<=rptr+1;
      end
    end
  assign empty=(wptr==rptr);
  assign full=(wptr[addr] != rptr[addr])&&(wptr[addr-1:0] == rptr[addr-1:0]);
endmodule
      
