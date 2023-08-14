`timescale 1ns/1ps

module op0(result,op_1,op_2);

    input wire [11:0] op_1,op_2;
    output wire [11:0] result;

    reg zero=0;

    buf op0[11:0] (result[11:0],zero);


endmodule

`timescale 1ns/1ps
module m81(input wire [11:0]D0, D1, D2, D3, D4, D5, D6, D7,
           input wire [2:0] S, output wire [11:0]out);
wire T0, T1, T2;
wire [11:0] T4,T5,T6,T7,T8,T9,T10,T11;
  not(T0, S[0]);
  not(T1, S[1]);
  not(T2, S[2]);
  
and nn1[11:0] (T4[11:0],D0[11:0],T2,T1,T0);
and nn2[11:0] (T5[11:0],D1[11:0],T2,T1,S[0]);
and nn3[11:0] (T6[11:0],D2[11:0],T2,S[1],T0);
and nn4[11:0] (T7[11:0],D3[11:0],T2,S[1],S[0]);
and nn5[11:0] (T8[11:0],D4[11:0],S[2],T1,T0);
and nn6[11:0] (T9[11:0],D5[11:0],S[2],T1,S[0]);
and nn7[11:0] (T10[11:0],D6[11:0],S[2],S[1],T0);
and nn8[11:0] (T11[11:0],D7[11:0],S[2],S[1],S[0]);

or nn9[11:0] (out[11:0],T4[11:0],T5[11:0],T6[11:0],T7[11:0],T8[11:0],T9[11:0],T10[11:0],T11[11:0]);
endmodule