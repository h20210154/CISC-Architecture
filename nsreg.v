`timescale 1ns / 1ps
module ns_reg(cwrd, nsreg, ib, sb,cc );


input [28:0] cwrd;
input [3:0] cc;
input [4:0] ib,sb;
reg [4:0] cb;
output reg [4:0] nsreg;

always @(cwrd)
begin



 nsreg = cwrd [6] ? (cwrd[5] ? cwrd[4:0]:cb) : (cwrd[5] ? sb:ib);
/*case (cwrd [6:5] )
    00: nsreg = ib;
    01: nsreg = sb;
    10: nsreg = cb;
    11: nsreg = cwrd[4:0];
    default nsreg = 5'b00000;
 endcase
 */
 end
 
 always @ (cc)
 begin
   if(cc==4'b0001)
     cb=5'b00111;
     
   if (cc==4'b0000)
    cb=5'b01000;
 
 end
 endmodule
