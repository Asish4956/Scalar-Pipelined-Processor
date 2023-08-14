`timescale 1ns/1ps

module alu(opcode,op_1,op_2,result);
// module alu();

    input wire [2:0] opcode;
    input wire [11:0] op_1,op_2;
    output wire [11:0] result;

    // reg [2:0]opcode;
    // reg [11:0]op_1;
    // reg [11:0]op_2;
    // wire [11:0]result;
    

    wire [11:0] res0;
    wire [11:0] res1;
    wire [11:0] res2;
    wire [11:0] res3;
    wire [11:0] res4;
    wire [11:0] res5;
    wire [11:0] res6;
    wire [11:0] res7;


    op0 alu0(res0[11:0],op_1[11:0],op_2[11:0]);
    op1 alu1(res1[11:0],op_1[11:0],op_2[11:0]);
    op2 alu2(res2[11:0],op_1[11:0],op_2[11:0]);
    op3 alu3(res3[11:0],op_1[11:0],op_2[11:0]);
    op4 alu4(res4[11:0],op_1[11:0],op_2[11:0]);
    op5 alu5(res5[11:0],op_1[11:0],op_2[11:0]);
    op6 alu6(res6[11:0],op_1[11:0],op_2[11:0]);
    op7 alu7(res7[11:0],op_1[11:0],op_2[11:0]);

    m81 alu8(res0,res1,res2,res3,res4,res5,res6,res7,opcode,result);

    // initial begin
    
    // $dumpfile("alu.vcd");
    // $dumpvars(0,alu);

    // op_1=12'b000000000100;
    // op_2=12'b000000000001;

    // #10 op_1=12'b001100100000; 
    //     op_2=12'b001111100000;

    // opcode=3'b000;#10;
    // opcode=3'b001;#10;
    // opcode=3'b010;#10;
    // opcode=3'b011;#10;
    // opcode=3'b100;#10;
    // opcode=3'b101;#10;
    // opcode=3'b110;#10;
    // opcode=3'b111;#10;

    // $finish;

    // end



endmodule

