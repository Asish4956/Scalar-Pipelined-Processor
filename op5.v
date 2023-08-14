`timescale 1ns/1ps

module op5(Z,A,B);
    
    input wire [11:0] A,B;
    output wire [11:0] Z;
    wire [3:0] k;


    reg [7:0] zero=8'b00000000;
    wire [7:0] qm,qi,sm1,sm2,zm;
    wire [8:0] sm;
    wire [3:0] temp;


    reg add=0;
    reg sub=1;
    reg [3:0] one=4'b0001;

    op5cla4 op5uut1  (A[10:7],B[10:7],sub,k[3:0]);

    op5mux_8 op5uut2 (B[6:0],k[2:0],qm[7:0]);

    op5mux_2 op5uut3 (qm,zero,k[3],qi);

    op5cla8 op5uut4 (A[6:0],qi,sm);

    buf (Z[11],zero);
    buf op5fpa1[7:1](sm1[7:1],sm[7:1]);
    buf op5fpa2[7:1](sm2[7:1],sm[6:0]);
    buf (sm1[0],zero);
    buf (sm2[0],zero);

    op5mux_2 op5uut5 (sm2,sm1,sm[8],zm);

    buf op5fpa3[7:1](Z[6:0],zm[7:1]);

    op5cla4 op5uut6 (A[10:7],one,add,temp);

    op5mux_4 op5uut7 (temp,A[10:7],sm[8],Z[10:7]);



endmodule




`timescale 1ns/1ps

module op5cla4(A,temp,c_in,sum);

	input wire [3:0] A, temp;
	input wire c_in;
	output wire [3:0] sum;

	wire [4:0]C;
	wire [3:0] G;
	wire [3:0] P;
	wire [3:0] B;

	xor op5nf[3:0] (B[3:0],temp[3:0],c_in);

	and op5nd[3:0] (G[3:0],A[3:0],B[3:0]);
	xor op5ne[3:0] (P[3:0],A[3:0],B[3:0]);

	buf (C[0],c_in);

	cla op5uut1(C[4:1],C[0],P[3:0],G[3:0],sum[3:0]);


endmodule

	
`timescale 1ns/1ps

module op5mux_8 (input wire [6:0] b,
            input wire [2:0] s,
            output wire [7:0] r);

    wire [2:0] ns;

    not nt[2:0] (ns[2:0], s[2:0]);
    reg zero = 0;
    reg one=1;

    wire [7:0] b0;

    buf (b0[7],one);
    buf op5mux_8[6:0] (b0[6:0],b[6:0]);

    wire [7:0] selec;

    and (selec[7],s[2],s[1],s[0]);
    and (selec[6],s[2],s[1],ns[0]);
    and (selec[5],s[2],ns[1],s[0]);
    and (selec[4],s[2],ns[1],ns[0]);
    and (selec[3],ns[2],s[1],s[0]);
    and (selec[2],ns[2],s[1],ns[0]);
    and (selec[1],ns[2],ns[1],s[0]);
    and (selec[0],ns[2],ns[1],ns[0]);

    
    wire [7:0] b1, b2, b3, b4, b5, b6, b7;
    //wire [7:0] b3, [7:0] b4, [7:0] b5, [7:0] b6, [7:0] b7;
    
    buf op5bf1[7:7] (b1[7:7], zero);
    buf op5bff1[6:0] (b1[6:0], b0[7:1]);
    
    buf op5bf2[7:6] (b2[7:6], zero);
    buf op5bff2[5:0] (b2[5:0], b0[7:2]);
    
    buf op5bf3[7:5] (b3[7:5], zero);
    buf op5bff3[4:0] (b3[4:0], b0[7:3]);
    
    buf op5bf4[7:4] (b4[7:4], zero);
    buf op5bff4[3:0] (b4[3:0], b0[7:4]);
    
    buf op5bf5[7:3] (b5[7:3], zero);
    buf op5bff5[2:0] (b5[2:0], b0[7:5]);
    
    buf op5bf6[7:2] (b6[7:2], zero);
    buf op5bff6[1:0] (b6[1:0], b0[7:6]);
    
    buf op5bf7[7:1] (b7[7:1], zero);
    buf op5bff7[0:0] (b7[0:0], b0[7:7]);

    wire [7:0] pr0, pr1, pr2, pr3, pr4, pr5, pr6, pr7;
    //wire [7:0] pr0, [7:0] pr1, [7:0] pr2, [7:0] pr3, [7:0] pr4, [7:0] pr5, [7:0] pr6, [7:0] pr7;

    and op5nd0[7:0] (pr0[7:0], b0[7:0], selec[0]);
    and op5nd1[7:0] (pr1[7:0], b1[7:0], selec[1]);
    and op5nd2[7:0] (pr2[7:0], b2[7:0], selec[2]);
    and op5nd3[7:0] (pr3[7:0], b3[7:0], selec[3]);
    and op5nd4[7:0] (pr4[7:0], b4[7:0], selec[4]);
    and op5nd5[7:0] (pr5[7:0], b5[7:0], selec[5]);
    and op5nd6[7:0] (pr6[7:0], b6[7:0], selec[6]);
    and op5nd7[7:0] (pr7[7:0], b7[7:0], selec[7]);

    or orr[7:0] (r[7:0], pr0[7:0], pr1[7:0], pr2[7:0], pr3[7:0], pr4[7:0], pr5[7:0], pr6[7:0], pr7[7:0]);
    
endmodule




module op5mux_2 (input wire [7:0] b0,
                input wire [7:0] b1,
                input wire s,
                output wire [7:0] r);

    wire ns;

    not (ns, s);

    wire [7:0] pr0, pr1;

    and op5nd0[7:0] (pr0[7:0], b0[7:0], ns);
    and op5nd1[7:0] (pr1[7:0], b1[7:0], s);

    or op5orrr[7:0] (r[7:0], pr0[7:0], pr1[7:0]);
    
endmodule






module op5mux_4 (input wire [3:0] xe1,
                input wire [3:0] xe,
                input wire sm0,
                output wire [3:0] ze);
    wire n_sm0;
    not (n_sm0, sm0);

    wire [3:0] p, q;

    and op5dnn[3:0] (p[3:0], xe1[3:0], sm0);
    and op5ddn[3:0] (q[3:0], xe[3:0], n_sm0);

    or op5rrr[3:0] (ze[3:0], p[3:0], q[3:0]);
    
endmodule

`timescale 1ns/1ps

module cla(C[4:1],c_in,P[3:0],G[3:0],sum[3:0]);

	output wire [3:0] sum;
	output wire [4:1] C;
	input wire [3:0] P,G;
	input wire c_in;
	
	
	wire a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11;	
	
	and  (a1, P[0], c_in);
	and  (a2, P[1], P[0], c_in);
	and  (a3, P[1], G[0]);
	and  (a4, P[2], P[1], P[0], c_in);
	and  (a5, P[2], P[1], G[0]);
	and  (a6, P[2], G[1]);
	and  (a7, P[3], P[2], P[1] , P[0], c_in);
	and  (a8, P[3], P[2], P[1] , G[0]);
	and  (a9, P[3], P[2], G[1]);
	and  (a10, P[3], G[2]);

	or   (C[1], a1, G[0]);
	or   (C[2], a2, a3, G[1]);
	or   (C[3], a4, a5, a6, G[2]);
	or   (C[4], a7, a8, a9, a10, G[3]);

	xor  (sum[0], P[0], c_in);
	xor  (sum[1], P[1], C[1]);
	xor  (sum[2], P[2], C[2]);
	xor  (sum[3], P[3], C[3]);


endmodule


`timescale 1ns/1ps

module op5cla8(A1,B,sum);

	input wire [6:0] A1;
	input wire [7:0] B;
	wire [8:0] C;
	output wire [8:0] sum;
	wire [7:0] A;
	wire [7:0] G;
	wire [7:0] P;
	reg zero=0;
	reg one=1;

	buf (C[0],zero);
	buf (A[7],one);
	buf op5cla8[6:0] (A[6:0],A1[6:0]);

	and op5nd[7:0] (G[7:0],A[7:0],B[7:0]);
	xor op5ne[7:0] (P[7:0],A[7:0],B[7:0]);

	buf (C[0],c_in);

	cla op5uut1(C[4:1],C[0],P[3:0],G[3:0],sum[3:0]);
	cla op5uut2(C[8:5],C[4],P[7:4],G[7:4],sum[7:4]);

	buf (sum[8],C[8]);

endmodule

	
