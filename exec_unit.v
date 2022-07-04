`timescale 1ns / 1ps
module exec_unit(input clk, 
                 input rst,
                 input [28:0] cwrd,
                 output reg [15:0] edb_out,
                 input [15:0] edb_in,
                 output reg [15:0] ire,
                 output reg[3:0] cc , 
                 output reg [4:0] eab);

      

reg [15:0] di,do,t1,irf, t2, edb_in_temp;
reg [15:0] abus,bbus ; //removed t1 & took as output
reg [4:0] pc, ao;
reg [15:0] r[4'b0000:4'b1111];
reg signed [15:0] abus_temp, bbus_temp;


always @ ( posedge clk)
begin

if (rst)
begin
pc = 5'b00000;
cc = 4'd0;
r[0] = 16'd0;
r[1] = 16'h0001;
r[2] = 16'h8888;
r[3] = 16'h5555;
r[7] = 16'h0010;
r[8] = 16'h0010;
r[9] = 16'h000a;
r[10] = 16'h000a;
r[15] = 16'h001f;
end

else edb_in_temp <= edb_in;

end

always @ ( *)
begin
////T1//////////////////////////////////////////////////////////////////////////////////////////////
if (cwrd[18:17]==2'b01)abus = t1; end
always @ ( *)
begin
if (cwrd[18:17]==2'b10) bbus = t1; end
   // default t1 = t1;
//pc//////////////////////////////////////////////////////////////////////////////////////

always @ (*)
begin

if (cwrd[26:25]==2'b01 ) abus = {11'd0,pc}; end
always @ (*)
begin
if (cwrd[26:25]==2'b10) pc = abus[4:0];end
always @ (cwrd)
begin
if (cwrd[26:25]==2'b11) pc = bbus[4:0];end
    //default pc = pc;

//ao////////////////////////////////////////////////////////////////////////////////////////
always @(*  )
begin

if (cwrd[28:27]==2'b01)begin ao = abus[4:0] ; eab = abus[4:0];     end
end
always @(* )
begin
if (cwrd[28:27]==2'b10) ao = bbus[4:0];
   // default ao = ao
end

//Regs///////////////////////////////////////////////////////////////////////////////////

always @ (* )
begin
if (cwrd[22:19] ==  4'b0001 ) r[ire[9:6]] = bbus;
end
   
always @ (* )
begin
if (cwrd[22:19] ==  4'b0010 ) abus = r[ire[3:0]];
end

always @ (*)
begin
if (cwrd[22:19] ==  4'b0011 ) abus = r[ire[9:6]];
end

always @ (*)
begin
if (cwrd[22:19] ==  4'b0100 ) r[ire[3:0]] = bbus;
 end
 
always @ (*)
begin
if (cwrd[22:19] ==  4'b0110) begin bbus = r[ire[9:6]]; r[ire[3:0]] = bbus; end
end

 always @ (*)
begin
if (cwrd[22:19] ==  4'b0111) begin abus = r[ire[9:6]]; r[ire[3:0]] = bbus; end
end

 always @ (*)
begin
if (cwrd[22:19] ==  4'b1101) begin  r[ire[9:6]] = bbus; r[ire[3:0]] = abus; end
end

always @ (*)
begin
if (cwrd[22:19] ==  4'b1001)begin r[ire[9:6]] = bbus; bbus = r[ire[3:0]]; end
end

always @ (*)
begin
 //r[ire[9:6]] = r[ire[9:6]]; r[ire[3:0]] = r[ire[3:0]];
if (cwrd[22:19] ==  4'b1011) begin abus = r[ire[9:6]]; bbus = r[ire[3:0]]; end
end


//T2///////////////////////////////////////////////////////////////////////////////////////////////////
always @ (*)
begin
if (cwrd[24:23]==2'b01) t2 = bbus; end

always @ (*)
begin
if (cwrd[24:23]==2'b10) abus = t2; end

always @ (*)
begin
if (cwrd[24:23]==2'b11) bbus = t2;
    //default t2 = t2;
end


   
//DI///////////////////////////////////////////////////////////////////////////////////////////////
always @ (*)
begin

if (cwrd[13:12]==2'b01) di = edb_in; end

always @ ( *)
begin
if (cwrd[13:12]==2'b10) bbus = di;
    //default di = di;
end

//DO/////////////////////////////////////////////////////////////////////////////////////////////
always @ (*)
begin

if (cwrd[11]==1'b0 ) do = do; end

always @ (*)
begin
if (cwrd[11]==1'b1 ) begin do = abus; edb_out = do; end
    //default do = do;
end

always @( *)
begin
//IRE////////////////////////////////////////////////////////////////////////////////////////
if (cwrd[10:9]==2'b01 ) ire = irf;
//ire = ire;
end


//IRF//////////////////////////////////////////////////////////////////////////////////////
always @(edb_in)
begin

if(cwrd[8:7]==2'b01)irf = edb_in; 
//irf = (cwrd[8:7]==2'b01) ? edb_in_temp: irf;
end


always @ (*)
begin
if(cwrd[8:7]==2'b10)ire = irf;
 //default irf = irf;
end


// ALU///////////////////////////////////////////////////////////////////////////////////

always @(*)
begin
if (cwrd[16:14]== 3'b001) t1 = abus + 16'd1; end
always @ (*)
begin
if (cwrd[16:14]== 3'b010) t1 = abus + bbus; end
always @ (*)
begin 
if (cwrd[16:14]== 3'b011)
                     begin t1 = abus + 16'd0; 
                            if(t1==16'd0)
                            cc=4'b0001;
                           else cc=4'b0000;
                        end
                      end
always @ (*)
begin
if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000000))
           begin 
           abus_temp = abus; bbus_temp = bbus; t1 = abus_temp + bbus_temp;
                           if(t1==16'd0)
                            cc=4'b0001;
                           else cc=4'b0000;
            end
           end
always @ (*)
begin
  if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000001))          
            begin 
            abus_temp = abus; bbus_temp = bbus; t1 = abus_temp - bbus_temp;
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
              end
           end
always @ (*)
begin
if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000010))           
                           begin  t1 = abus & bbus ;
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
                         end
                         end
always @ (*)
begin                         
if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000011))         
           begin 
           t1 = ~(abus & bbus) ;
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
                    end
                end
 always @ (*)
begin                   
 if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000100))                      
           begin
            t1 = abus | bbus ; 
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
                   end
              end
 always @ (*)
begin
 if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000101))                   
                    begin 
                        t1 = ~(abus | bbus) ;
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
                     end
                   end
always @ (*)
begin
if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000110))                      
            begin
                     t1 = abus ^ bbus ;
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
                    end
                   end 
always @ (*)
begin
if ((cwrd[16:14]== 3'b100)&& ( ire [15:10]==6'b000111)) 
                     begin 
                     t1 = ~(abus ^ bbus) ;
                            if(t1==16'd0)
                            cc=4'b0001;
                            else cc=4'b0000;
                       end
  end         
           //default t1 = t1;
always @ (*)
begin 
if (cwrd[16:14]==3'b101)      
         t1 = abus - 16'd1;        
   //default  t1 = t1;
  
end
endmodule
