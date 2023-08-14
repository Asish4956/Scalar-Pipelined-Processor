`timescale 1ns/1ps

module op6(Z,X,Y);

input wire [11:0] X,Y;
output wire [11:0] Z;


wire [7:0] Xm1,Ym1;
wire [15:0] Zm1;
wire [4:0] Ze1;
wire [3:0] Ze2,Ze3;
reg [4:0]bi=5'b00111, bi1=5'b00110;
wire of1,of2,of;

reg zero=0,one=1;

buf op6fpm1[6:0] (Xm1[6:0],X[6:0]);
buf (Xm1[7],one);

buf op6fpm2[6:0] (Ym1[6:0],Y[6:0]);
buf (Ym1[7],one);

op6csa_tb op6fpm3 (Xm1,Ym1,Zm1);
op6mux_7 op6fpm8 (Zm1[14:8],Zm1[13:7],Zm1[15],Z[6:0]);

op6add4 op6fpm4 (X[10:7],Y[10:7],Ze1);
op6add5 op6fpm5 (Ze1,bi,Ze2,of1);
op6add5 op6fpm6 (Ze1,bi1,Ze3,of2);
op6mux_2 op6fpm7 (Ze3,Ze2,Zm1[15],Z[10:7]);

xor (Z[11],X[11],Y[11]);

op6mux_1 op6fpm9(of1,of2,Zm1[15],of);



endmodule



`timescale 1ns/1ps

module op6csa_tb(A,B,ans);

	input wire [7:0] A,B;
	output wire [15:0] ans;

    wire [15:0] pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;
    wire [15:0] S00,S01,S02,S03,S04,S05;
    wire [15:0] S10,S11,S12,S13;
    wire [15:0] S20,S21;
    wire [15:0] S30,S31;
	
	wire [9:0] arr1;

    reg _signed=0;
	wire of;

	op6pp op6csa1 (A,B,pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,_signed);

	op6csa op6csa2 (pp0,pp1,pp2,S00,S01);
	op6csa op6csa3 (pp3,pp4,pp5,S02,S03);
	op6csa op6csa4 (pp6,pp7,pp8,S04,S05);
	op6csa op6csa5 (S00,S01,S02,S10,S11);
	op6csa op6csa6 (S03,S04,S05,S12,S13);
	op6csa op6csa7 (S10,S11,S12,S20,S21);
	op6csa op6csa8 (S20,S21,S13,S30,S31);

	op6cla_tb op6csa9 (S30,S31,ans);


endmodule

	
`timescale 1ns/1ps

module op6pp(A,B,pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,_signed);

    input wire [7:0] A,B;
    input wire _signed;
    output wire [15:0] pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;

    reg cons=0;
    wire [15:0]temp;
    
    and op6ab[7:0] (pp0[7:0],A[7:0],B[0]);
    and op6ac[7:0] (pp0[15:8],_signed,pp0[7]);

    buf op6ba[0:0] (pp1[0:0],cons);
    and op6bb[7:0] (pp1[8:1],A[7:0],B[1]);
    and op6bc[6:0] (pp1[15:9],_signed,pp1[8]);

    buf op6ca[1:0] (pp2[1:0],cons);
    and op6cb[7:0] (pp2[9:2],A[7:0],B[2]);
    and op6cc[5:0] (pp2[15:10],_signed,pp2[9]);

    buf op6da[2:0] (pp3[2:0],cons);
    and op6db[7:0] (pp3[10:3],A[7:0],B[3]);
    and op6dc[4:0] (pp3[15:11],_signed,pp3[10]);

    buf op6ea[3:0] (pp4[3:0],cons);
    and op6eb[7:0] (pp4[11:4],A[7:0],B[4]);
    and op6ec[3:0] (pp4[15:12],_signed,pp4[11]);

    buf op6fa[4:0] (pp5[4:0],cons);
    and op6fb[7:0] (pp5[12:5],A[7:0],B[5]);
    and op6fc[2:0] (pp5[15:13],_signed,pp5[12]);

    buf op6ga[5:0] (pp6[5:0],cons);
    and op6gb[7:0] (pp6[13:6],A[7:0],B[6]);
    and op6gc[1:0] (pp6[15:14],_signed,pp6[13]);

    buf op6ha[6:0] (pp7[6:0],cons);
    and op6hb[7:0] (temp[14:7],A[7:0],B[7]);
    xor op6hd[7:0](pp7[14:7],temp[14:7],_signed);
    buf (pp7[15],pp7[14]);

    buf op6ia[6:0](pp8[6:0],cons);
    buf op6ib[0:0] (pp8[7:7],_signed);
    buf op6ic[7:0](pp8[15:8],cons);
	

endmodule

	

`timescale 1ns/1ps

module op6csa(pp0,pp1,pp2,S00,S01);

	input wire [15:0] pp0,pp1,pp2;
	output wire [15:0] S00,S01;

	wire cons;
	reg cons2=0;

	op6fa op6fa1[14:0] (pp0[14:0],pp1[14:0],pp2[14:0],S00[14:0],S01[15:1]);
	op6fa op6fa2 (pp0[15],pp1[15],pp2[15],S00[15],cons);
	buf op6fa3 (S01[0],cons2);
	

endmodule

`timescale 1ns/1ps

module op6fa(a,b,c,sum,carry);

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

module op6cla_tb(A,B,sum);

	input wire [15:0] A,B;
	output wire [15:0] sum;
	
	wire [16:0] C;
	wire [15:0] G;
	wire [15:0] P;
	wire [3:0] Pi;
	wire [3:0] Gi;
	reg cons=0;

	buf (C[0],cons);

	and op6nd[15:0] (G[15:0],A[15:0],B[15:0]);
	xor op6ne[15:0] (P[15:0],A[15:0],B[15:0]);

	op6pg op6cla1(P[3:0],G[3:0],Pi[0],Gi[0]);
	op6pg op6cla2(P[7:4],G[7:4],Pi[1],Gi[1]);
	op6pg op6cla3(P[11:8],G[11:8],Pi[2],Gi[2]);
	op6pg op6cla4(P[15:12],G[15:12],Pi[3],Gi[3]);

	op6cpg u(Pi[3:0],Gi[3:0],C[0],C[4],C[8],C[12],C[16]);
	
	op6cla4 op6clat1(C[3:1],C[0],P[3:0],G[3:0],sum[3:0]);
	op6cla4 op6clat2(C[7:5],C[4],P[7:4],G[7:4],sum[7:4]);
	op6cla4 op6clat3(C[11:9],C[8],P[11:8],G[11:8],sum[11:8]);
	op6cla4 op6clat4(C[15:13],C[12],P[15:12],G[15:12],sum[15:12]);


endmodule

	

`timescale 1ns/1ps

module op6pg(P[3:0],G[3:0],Pi,Gi);

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

module op6cpg(Pi[3:0],Gi[3:0],c0,c4,c8,c12,c16);

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



`timescale 1ns/1ps

module op6cla4(C[3:1],c_in,P[3:0],G[3:0],sum[3:0]);

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



module op6mux_7 (input wire [13:7] px0,
                input wire [14:8] px1,
                input wire p15,
                output wire [6:0] zm);
    wire n_p15;
    not (n_p15, p15);

    wire [6:0] p, q;

    and op6gog[6:0] (p[6:0], px1[14:8], p15);
    and op6got[6:0] (q[6:0], px0[13:7], n_p15);

    or op6bvs[6:0] (zm[6:0], p[6:0], q[6:0]);
    
endmodule

module op6mux_2 (input wire [3:0] b0,
                input wire [3:0] b1,
                input wire s,
                output wire [3:0] r);

    wire ns;

    not (ns, s);

    wire [3:0] pr0, pr1;

    and op6nd0[3:0] (pr0[3:0], b0[3:0], ns);
    and op6nd1[3:0] (pr1[3:0], b1[3:0], s);

    or op6orrr[3:0] (r[3:0], pr0[3:0], pr1[3:0]);
    
endmodule

module op6mux_1 (input wire  b0,
                input wire  b1,
                input wire s,
                output wire  r);

    wire ns;

    not (ns, s);

    wire  pr0, pr1;

    and op6nd0 (pr0, b0, ns);
    and op6nd1 (pr1, b1, s);

    or op6orrr (r, pr0, pr1);
    
endmodule

`timescale 1ns/1ps

module op6add4(A,B,C);

input wire [3:0] A,B;
output wire [4:0] C;

wire [4:0] Carry;
reg zero=0;

buf (Carry[0],zero);

op6fa op6add[3:0](A[3:0],B[3:0],Carry[3:0],C[3:0],Carry[4:1]);
buf (C[4],Carry[4]);

endmodule

module op6add5(A,temp,C,of);

input wire [4:0] A,temp;
output wire [3:0] C;
output wire of;

wire [5:0] Carry;
wire [4:0] B;

reg zero=0,one=1;

xor op6add1[4:0] (B[4:0],temp[4:0],one);
buf (Carry[0],one);

op6fa op6add2[3:0](A[3:0],B[3:0],Carry[3:0],C[3:0],Carry[4:1]);
op6fa op6add3(A[4],B[4],Carry[4],of,Carry[5]);

endmodule

