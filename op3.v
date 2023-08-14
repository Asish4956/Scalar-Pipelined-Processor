`timescale 1ns/1ps

module op3(result,op_1,op_2);

	input wire [11:0] op_1,op_2;
    output wire [11:0] result;
	
	wire [7:0] A,B;
    wire [7:0] res;

	buf op3start1[7:0] (A[7:0],op_1[7:0]);
	buf op3start2[7:0] (B[7:0],op_2[7:0]);

	reg zzero=0;
	buf op3end1[11:8] (result[11:8],zzero);

    wire [15:0] pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;
    wire [15:0] S00,S01,S02,S03,S04,S05;
    wire [15:0] S10,S11,S12,S13;
    wire [15:0] S20,S21;
    wire [15:0] S30,S31;
	wire [15:0] ans;
	wire [9:0] arr1;

    reg _signed=0;

	op3pp op3uut1 (A,B,pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,_signed);

	op3csa op3uut2 (pp0,pp1,pp2,S00,S01);
	op3csa op3uut3 (pp3,pp4,pp5,S02,S03);
	op3csa op3uut4 (pp6,pp7,pp8,S04,S05);
	op3csa op3uut5 (S00,S01,S02,S10,S11);
	op3csa op3uut6 (S03,S04,S05,S12,S13);
	op3csa op3uut7 (S10,S11,S12,S20,S21);
	op3csa op3uut8 (S20,S21,S13,S30,S31);

	op3cla_tb op3uut9 (S30,S31,ans);
    buf op3[7:0] (res[7:0],ans[7:0]);
	
	buf op3end2[7:0] (result[7:0],res[7:0]);

endmodule

	
`timescale 1ns/1ps

module op3pp(A,B,pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,_signed);

    input wire [7:0] A,B;
    input wire _signed;
    output wire [15:0] pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;

    reg cons=0;
    wire [15:0]temp;
    
    and op3ab[7:0] (pp0[7:0],A[7:0],B[0]);
    and op3ac[7:0] (pp0[15:8],_signed,pp0[7]);

    buf op3ba[0:0] (pp1[0:0],cons);
    and op3bb[7:0] (pp1[8:1],A[7:0],B[1]);
    and op3bc[6:0] (pp1[15:9],_signed,pp1[8]);

    buf op3ca[1:0] (pp2[1:0],cons);
    and op3cb[7:0] (pp2[9:2],A[7:0],B[2]);
    and op3cc[5:0] (pp2[15:10],_signed,pp2[9]);

    buf op3da[2:0] (pp3[2:0],cons);
    and op3db[7:0] (pp3[10:3],A[7:0],B[3]);
    and op3dc[4:0] (pp3[15:11],_signed,pp3[10]);

    buf op3ea[3:0] (pp4[3:0],cons);
    and op3eb[7:0] (pp4[11:4],A[7:0],B[4]);
    and op3ec[3:0] (pp4[15:12],_signed,pp4[11]);

    buf op3fa[4:0] (pp5[4:0],cons);
    and op3fb[7:0] (pp5[12:5],A[7:0],B[5]);
    and op3fc[2:0] (pp5[15:13],_signed,pp5[12]);

    buf op3ga[5:0] (pp6[5:0],cons);
    and op3gb[7:0] (pp6[13:6],A[7:0],B[6]);
    and op3gc[1:0] (pp6[15:14],_signed,pp6[13]);

    buf op3ha[6:0] (pp7[6:0],cons);
    and op3hb[7:0] (temp[14:7],A[7:0],B[7]);
    xor op3hd[7:0](pp7[14:7],temp[14:7],_signed);
    buf (pp7[15],pp7[14]);

    buf op3ia[6:0](pp8[6:0],cons);
    buf op3ib[0:0] (pp8[7:7],_signed);
    buf op3ic[7:0](pp8[15:8],cons);
	

endmodule

	
`timescale 1ns/1ps

module op3csa(pp0,pp1,pp2,S00,S01);

	input wire [15:0] pp0,pp1,pp2;
	output wire [15:0] S00,S01;

	wire cons;
	reg cons2=0;

	op3fa op3aa[14:0] (pp0[14:0],pp1[14:0],pp2[14:0],S00[14:0],S01[15:1]);
	op3fa op3ab (pp0[15],pp1[15],pp2[15],S00[15],cons);
	buf op3uut4 (S01[0],cons2);
	

endmodule


`timescale 1ns/1ps

module op3cla_tb(A,B,sum);

	input wire [15:0] A,B;
	output wire [15:0] sum;
	
	wire [16:0] C;
	wire [15:0] G;
	wire [15:0] P;
	wire [3:0] Pi;
	wire [3:0] Gi;
	reg cons=0;

	buf (C[0],cons);

	and op3nd[15:0] (G[15:0],A[15:0],B[15:0]);
	xor op3ne[15:0] (P[15:0],A[15:0],B[15:0]);

	op3pg op3uu1(P[3:0],G[3:0],Pi[0],Gi[0]);
	op3pg op3uu2(P[7:4],G[7:4],Pi[1],Gi[1]);
	op3pg op3uu3(P[11:8],G[11:8],Pi[2],Gi[2]);
	op3pg op3uu4(P[15:12],G[15:12],Pi[3],Gi[3]);

	op3cpg op3u(Pi[3:0],Gi[3:0],C[0],C[4],C[8],C[12],C[16]);
	
	op3cla4 op3uut1(C[3:1],C[0],P[3:0],G[3:0],sum[3:0]);
	op3cla4 op3uut2(C[7:5],C[4],P[7:4],G[7:4],sum[7:4]);
	op3cla4 op3uut3(C[11:9],C[8],P[11:8],G[11:8],sum[11:8]);
	op3cla4 op3uut4(C[15:13],C[12],P[15:12],G[15:12],sum[15:12]);


endmodule

	
`timescale 1ns/1ps

module op3cla4(C[3:1],c_in,P[3:0],G[3:0],sum[3:0]);

	output wire [3:0] sum;
	output wire [3:1] C;
	input wire [3:0] P,G;
	input wire c_in;
	
	
	wire a1,a2,a3,a4,a5,a6;	
	
	and  (a1, P[0], c_in);
	and  (a2, P[1], P[0], c_in);
	and  (a3, P[1], G[0]);
	and  (a4, P[2], P[1], P[0], c_in);
	and  (a5, P[2], P[1], G[0]);
	and  (a6, P[2], G[1]);

	or   (C[1], a1, G[0]);
	or   (C[2], a2, a3, G[1]);
	or   (C[3], a4, a5, a6, G[2]);

	xor  (sum[0], P[0], c_in);
	xor  (sum[1], P[1], C[1]);
	xor  (sum[2], P[2], C[2]);
	xor  (sum[3], P[3], C[3]);


endmodule


`timescale 1ns/1ps

module op3fa(a,b,c,sum,carry);

    input wire a, b, c;
	output wire carry, sum;
	
	wire temp1, temp2, temp3;
	
	xor (temp1, a, b);
	and (temp2, a, b);
	
	xor (sum, temp1, c);
	and (temp3, temp1, c);
	
	or  (carry, temp2, temp3);
	

endmodule

	
`timescale 1ns/1ps

module op3pg(P[3:0],G[3:0],Pi,Gi);

    input wire [3:0] P,G;
    output wire Pi,Gi;

    wire a1,a2,a3;	

    and  (Pi, P[3], P[2], P[1] , P[0]);
    and  (a1, P[3], P[2], P[1] , G[0]);
    and  (a2, P[3], P[2], G[1]);
    and  (a3, P[3], G[2]);

    or   (Gi, a1, a2, a3, G[3]);

endmodule

`timescale 1ns/1ps

module op3cpg(Pi[3:0],Gi[3:0],c0,c4,c8,c12,c16);

	output wire c4,c8,c12,c16;
	input wire [3:0] Pi,Gi;
	input wire c0;
	
	
	wire a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11;	
	
	and  (a1, Pi[0], c0);
	and  (a2, Pi[1], Pi[0], c0);
	and  (a3, Pi[1], Gi[0]);
	and  (a4, Pi[2], Pi[1], Pi[0], c0);
	and  (a5, Pi[2], Pi[1], Gi[0]);
	and  (a6, Pi[2], Gi[1]);
	and  (a7, Pi[3], Pi[2], Pi[1] , Pi[0], c0);
	and  (a8, Pi[3], Pi[2], Pi[1] , Gi[0]);
	and  (a9, Pi[3], Pi[2], Gi[1]);
	and  (a10, Pi[3], Gi[2]);

	or   (c4, a1, Gi[0]);
	or   (c8, a2, a3, Gi[1]);
	or   (c12, a4, a5, a6, Gi[2]);
	or   (c16, a7, a8, a9, a10, Gi[3]);


endmodule
