`timescale 1ns/1ps

module regfile (input wire [11:0] datain,
                output wire [11:0] dataout2,
                output wire [11:0] dataout3,
                input wire write, read2, read3,
                input wire [2:0] adr1, adr2, adr3
                );

wire [11:0] wr0, wr1, wr2, wr3, wr4, wr5, wr6, wr7;
wire [11:0] rr0, rr1, rr2, rr3, rr4, rr5, rr6, rr7;
wire [7:0] clk;

demux8 rfdm (datain, adr1, wr0, wr1, wr2, wr3, wr4, wr5, wr6,wr7);

decod8 rfdc (adr1, write, clk);

register r0 (wr0, clk[0], rr0);
register r1 (wr1, clk[1], rr1);
register r2 (wr2, clk[2], rr2);
register r3 (wr3, clk[3], rr3);
register r4 (wr4, clk[4], rr4);
register r5 (wr5, clk[5], rr5);
register r6 (wr6, clk[6], rr6);
register r7 (wr7, clk[7], rr7);

mux8 rfm1 (rr0, rr1, rr2, rr3,rr4,rr5,rr6,rr7,read2, adr2,dataout2);

mux8 rfm2 (rr0,rr1, rr2, rr3,rr4,rr5,rr6,rr7,read3, adr3,dataout3);

endmodule

module demux8 (input wire [11:0] datain,
                input wire [2:0] adr,
                output wire [11:0] wr0,wr1,wr2,wr3,wr4,wr5,wr6,wr7);

    wire [2:0] not_adr;
    not dmnt [2:0] (not_adr[2:0], adr[2:0]);

    wire [7:0] selec;

    and (selec[7], adr[2], adr[1], adr[0]);
    and (selec[6], adr[2], adr[1], not_adr[0]);
    and (selec[5], adr[2], not_adr[1], adr[0]);
    and (selec[4], adr[2], not_adr[1], not_adr[0]);
    and (selec[3], not_adr[2], adr[1], adr[0]);
    and (selec[2], not_adr[2], adr[1], not_adr[0]);
    and (selec[1], not_adr[2], not_adr[1], adr[0]);
    and (selec[0], not_adr[2], not_adr[1], not_adr[0]);

    and dmnd0 [11:0] (wr0[11:0], selec[0], datain[11:0]);
    and dmnd1 [11:0] (wr1[11:0], selec[1], datain[11:0]);
    and dmnd2 [11:0] (wr2[11:0], selec[2], datain[11:0]);
    and dmnd3 [11:0] (wr3[11:0], selec[3], datain[11:0]);
    and dmnd4 [11:0] (wr4[11:0], selec[4], datain[11:0]);
    and dmnd5 [11:0] (wr5[11:0], selec[5], datain[11:0]);
    and dmnd6 [11:0] (wr6[11:0], selec[6], datain[11:0]);
    and dmnd7 [11:0] (wr7[11:0], selec[7], datain[11:0]);

endmodule

module decod8 (input wire [2:0] adr,
                input wire write,
                output wire [7:0] clk);

    wire [2:0] not_adr;
    not dcnt [2:0] (not_adr[2:0], adr[2:0]);

    wire [7:0] selec;

    and (selec[7], adr[2], adr[1], adr[0]);
    and (selec[6], adr[2], adr[1], not_adr[0]);
    and (selec[5], adr[2], not_adr[1], adr[0]);
    and (selec[4], adr[2], not_adr[1], not_adr[0]);
    and (selec[3], not_adr[2], adr[1], adr[0]);
    and (selec[2], not_adr[2], adr[1], not_adr[0]);
    and (selec[1], not_adr[2], not_adr[1], adr[0]);
    and (selec[0], not_adr[2], not_adr[1], not_adr[0]);

    and dcnd [7:0] (clk[7:0], write, selec[7:0]);

endmodule

module mux8 (input wire [11:0]D0, D1, D2, D3, D4, D5, D6, D7,
                input wire read,
           input wire [2:0] S, output wire [11:0]out);
wire T0, T1, T2;
wire [11:0] T4,T5,T6,T7,T8,T9,T10,T11;
  not(T0, S[0]);
  not(T1, S[1]);
  not(T2, S[2]);
  
and nn1[11:0] (T4[11:0],D0[11:0],T2,T1,T0,read);
and nn2[11:0] (T5[11:0],D1[11:0],T2,T1,S[0],read);
and nn3[11:0] (T6[11:0],D2[11:0],T2,S[1],T0,read);
and nn4[11:0] (T7[11:0],D3[11:0],T2,S[1],S[0],read);
and nn5[11:0] (T8[11:0],D4[11:0],S[2],T1,T0,read);
and nn6[11:0] (T9[11:0],D5[11:0],S[2],T1,S[0],read);
and nn7[11:0] (T10[11:0],D6[11:0],S[2],S[1],T0,read);
and nn8[11:0] (T11[11:0],D7[11:0],S[2],S[1],S[0],read);

or nn9[11:0] (out[11:0],T4[11:0],T5[11:0],T6[11:0],T7[11:0],T8[11:0],T9[11:0],T10[11:0],T11[11:0]);
endmodule

module dflip (input wire d, clk,
              output wire q);

    wire not_d;
    not (not_d, d);

    wire up, down;
    wire not_q;

    nand (up, d, clk);
    nand (down, not_d, clk);

    nand #0.01 (q, up, not_q);
    nand #0.01 (not_q, down, q);

endmodule

module register (input wire [11:0] data,
                input wire clk,
                output wire [11:0] out);
   
    dflip gcc[11:0] (data[11:0], clk, out[11:0]);

endmodule

`timescale 1ns/1ps
module m21(input wire [11:0]D0, D1, input wire S, output wire [11:0]out);
wire T0;
wire [11:0] T4,T5;
not(T0, S);
and nm1[11:0] (T4[11:0],D0[11:0],T0);
and nm2[11:0] (T5[11:0],D1[11:0],S);

or nm3[11:0] (out[11:0],T4[11:0],T5[11:0]);
endmodule