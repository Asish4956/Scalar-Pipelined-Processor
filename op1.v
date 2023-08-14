`timescale 1ns/1ps

module op1(result,op_1,op_2);

    input wire [11:0] op_1,op_2;
    output wire [11:0] result;

	wire [7:0] A,B;
	wire [7:0] sum;

	buf op1start1[7:0] (A[7:0],op_1[7:0]);
	buf op1start2[7:0] (B[7:0],op_2[7:0]);

	reg zzero=0;
	buf op1end1[11:8] (result[11:8],zzero);
    
	wire [8:0]C;
	wire [7:0] G;
	wire [7:0] P;
    reg zero=0;


	and op1nd[7:0] (G[7:0],A[7:0],B[7:0]);
	xor op1ne[7:0] (P[7:0],A[7:0],B[7:0]);

	buf (C[0],zero);

	op1cla4 op1uut1 (C[4:1],C[0],P[3:0],G[3:0],sum[3:0]);
	op1cla4 op1uut2 (C[8:5],C[4],P[7:4],G[7:4],sum[7:4]);

	buf op1end2[7:0] (result[7:0],sum[7:0]);

endmodule




module op1cla4(C[4:1],C0,P[3:0],G[3:0],sum[3:0]);

	output wire [3:0] sum;
	output wire [4:1] C;
	input wire [3:0] P,G;
	input wire C0;
	
	
	wire a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11;	
	
	and  (a1, P[0], C0);
	and  (a2, P[1], P[0], C0);
	and  (a3, P[1], G[0]);
	and  (a4, P[2], P[1], P[0], C0);
	and  (a5, P[2], P[1], G[0]);
	and  (a6, P[2], G[1]);
	and  (a7, P[3], P[2], P[1] , P[0], C0);
	and  (a8, P[3], P[2], P[1] , G[0]);
	and  (a9, P[3], P[2], G[1]);
	and  (a10, P[3], G[2]);

	or   (C[1], a1, G[0]);
	or   (C[2], a2, a3, G[1]);
	or   (C[3], a4, a5, a6, G[2]);
	or   (C[4], a7, a8, a9, a10, G[3]);

	xor  (sum[0], P[0], C0);
	xor  (sum[1], P[1], C[1]);
	xor  (sum[2], P[2], C[2]);
	xor  (sum[3], P[3], C[3]);


endmodule
