`timescale 1ns / 1ps
module memory(dout_m,eab,din_m,clk,cwrd,rst);
input [4:0] eab;
input [15:0]din_m;//din here is processor's dout
input [28:0]cwrd;// cwrd remains same
input clk,rst;
output reg [15:0]dout_m;// memory content

reg [15:0] mem [0:31];

//always @(reset)
 
always @(rst)
    begin
    
    mem[0] = 16'h4497;
    mem[1] = 16'h0047;
    mem[2] = 16'h44D7;
    mem[3] = 16'h248F;
    mem[4] = 16'h24CF;
    mem[5] = 16'h04E8;
    mem[6] = 16'h0001;
    mem[7] = 16'h6419;
    mem[8] = 16'h601A;
    mem[9] = 16'h0047;
    mem[10] = 16'h234F;
    mem[11] = 16'h230F;
    mem[12] = 16'h188C;
    mem[13] = 16'h1CCD;
    mem[14] = 16'h08C2;
    mem[15] = 16'h1083;
 
end

always @(negedge clk) if (!rst) dout_m = mem[eab];

always @(posedge clk)
begin
if (cwrd[11]==1'b1)
mem[eab] = din_m;
end

endmodule

