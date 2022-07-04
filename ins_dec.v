`timescale 1ns / 1ps
module in_dec(
    input [15:0] ins,
    input rst, 
    output reg [4:0] ib,
    output reg [4:0] sb
    );
    parameter   ar = 2'b00, ai = 2'b01, ab= 2'b10,  add=6'b000000,subtract=6'b000001, and1 = 6'b000010, 
                nand1= 6'b000011,or1= 6'b000100, nor1=6'b000101,xor1= 6'b000110, 
                xnor1 = 6'b000111, pop= 6'b001000 , push= 6'b001001, load= 6'b010000, store = 6'b010001,
                bz= 6'b011000 ,test= 6'b011001;
                
   //IB             
    always @ (ins or rst or sb)
    begin
        if(rst)
            begin ib = 5'd0;  end
     
        else 
            begin 
            /*ib = ins[5] ? (ins[4] ? 5'b00000 : 5'b00001 ) : (ins[4] ? 5'b00101 : sb );*/
            case ( ins [5:4] )
                    ar :  ib = sb; 
                    ai :  ib = 5'b00101;
                    ab :  ib = 5'b00001;
                    default ib = 5'b00000;
                   
                  endcase
                   $display("ar is: %2b",ar);
            end
    end
    
      
      //SB
      always @(ins or rst)
      begin     
      if(rst)
         begin ib =5'd0; sb = 5'd0; end  
       else 
       begin   
           case ( ins[15:10] )
                pop         : sb = 5'b10101;
                push        : sb = 5'b10001;
                load        : sb = 5'b01111;
                store       : sb = 5'b01011;
                bz          : sb = 5'b00110;
                test        : sb = 5'b01100;
                add         : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                subtract    : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                and1        : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                or1         : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                nor1        : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                xor1        : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                xnor1       : sb = ins[5] ?    (ins[4] ?  5'b00000 : 5'b01101) : (ins[4] ?   5'b01101 : 5'b10011) ;
                endcase
                
               /* ib = ins[5] ? (ins[4] ? 5'b00000 : 5'b00001 ) : (ins[4] ? 5'b00101 : sb );*/
         end 
         end
           
endmodule
