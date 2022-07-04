`timescale 1ns / 1ps
module tb_cisc();

reg clk, rst;
 /*reg [28:0] cwrd;
 reg [15:0] din_m;
 reg [4:0] eab;
wire [15:0] dout_m;*/

cisc_top uut(.clk(clk), .rst(rst));
/*memory  m3 (.dout_m(dout_m),.eab(eab),.din_m(din_m),.clk(clk),.cwrd(cwrd),.rst(rst));

initial
begin
rst = 1'b1;
if(rst)
    begin
     cwrd = 29'b01_01_00_0000__00_001_01_1_00_00_11_00010; 
     eab = 5'd0; din_m= 16'h4497;
     eab = 5'd1; din_m= 16'h0047;
     eab = 5'd2; din_m= 16'h44D7;
     eab = 5'd3; din_m= 16'h248F;
     eab = 5'd4; din_m= 16'h24CF;
     eab = 5'd5; din_m= 16'h04E8;
     eab = 5'd6; din_m= 16'h0001;
     eab = 5'd7; din_m= 16'h6419;
     eab = 5'd8; din_m= 16'h601A;
     eab = 5'd9; din_m= 16'h0047;
     eab = 5'd10; din_m= 16'h234F;
     eab = 5'd11; din_m= 16'h230F;
     eab = 5'd12; din_m= 16'h188C;
     eab = 5'd13; din_m= 16'h1CCD;
     eab = 5'd14; din_m= 16'h08C2;
     eab = 5'd15; din_m= 16'h1083;
    
      
    end
end*/

initial
begin

rst = 1'b1;

#2 rst = 1'b0;

end

initial
begin

clk = 1'b1;
forever #5 clk = ~clk;
#500 $finish;

end
 

endmodule
