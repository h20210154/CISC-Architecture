`timescale 1ns / 1ps

module cisc_top ( clk, rst);
input clk, rst;

wire [28:0]cwrd1;
wire [4:0] addr,ib_to_nsreg,sb_to_nsreg,mem_addr;
wire [3:0] flag; 
wire [15:0] data_in,data_out, ird_to_insdec;

memory       m1   (.dout_m(data_in),.eab(mem_addr),.din_m(data_out),.clk(clk),.cwrd(cwrd1),.rst(rst));
control_reg  c1   (.cwrd(cwrd1),.addr(addr),.clk(clk),.reset(rst));
exec_unit    e1   (.clk(clk),.rst(rst), .cwrd(cwrd1), .edb_in(data_in),.edb_out(data_out), .eab(mem_addr),.cc(flag),.ire(ird_to_insdec));
in_dec       i1   (.ins(ird_to_insdec), .ib(ib_to_nsreg), .sb(sb_to_nsreg),.rst(rst) );
ns_reg       n1   (.cwrd(cwrd1),.nsreg(addr), .ib(ib_to_nsreg), .sb(sb_to_nsreg),.cc(flag) );


/*memory       m1   (data,mem_addr,data,clk,cwrd1,rst);
control_reg  c1   (cwrd1,addr,clk,rst);
exec_unit    e1   (clk,rst, cwrd1,data,mem_addr,flag,ird_to_insdec );
in_dec       i1   (ird_to_insdec,ib_to_nsreg,sb_to_nsreg,rst );
ns_reg       n1   (cwrd1[6:0],addr, ib_to_nsreg, sb_to_nsreg,flag);*/

endmodule

