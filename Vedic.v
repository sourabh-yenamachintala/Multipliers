`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:57 07/21/2017 
// Design Name: 
// Module Name:    multiplier 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module multiplier #(

parameter INPUT_SIZE=160

)

(
	output reg [2*INPUT_SIZE-1:0] product,
	input  [INPUT_SIZE-1:0] op1,op2
    );


integer i,j;


reg [2*INPUT_SIZE-1:0] sum;
reg  [2*INPUT_SIZE-1:0] c;


always @(op1 or op2) 

begin
    c=0;
    sum=0;
	 
	for(i=0;i<INPUT_SIZE;i=i+1) begin
		for(j=0;j<=i;j=j+1)begin
		   sum=sum+(op1[i-j] & op2[j]);
		end
		 
		      sum=sum+c;
			   
		  
		       c[2*INPUT_SIZE-2:0]=sum[2*INPUT_SIZE-1:1];
		     
		  
		  product[i]=sum[0];
		  
		  sum=0;
		  
	end
   
	 for (i=1;i<INPUT_SIZE;i=i+1) begin
		for(j=INPUT_SIZE-1;j>=i;j=j-1) begin
			sum=sum+(op1[INPUT_SIZE-1-(j-i)]& op2[j]);
			

		end
		
		      sum=sum+c;
				     
		 
						c[2*INPUT_SIZE-2:0]=sum[INPUT_SIZE-1:1];
						
		 
		product[INPUT_SIZE-1+i]=sum[0];
		
		sum=0;
	 end
	 
	product[2*INPUT_SIZE-1]=c[0];
end




endmodule
