module Lab1Tut(x1,x2,f);

input x1;
input x2;
output f;

assign f = (x1 & ~x2)|(~x1 & x2);


endmodule
