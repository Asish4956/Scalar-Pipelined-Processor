`timescale 1ns/1ps

module test();


    reg [2:0] adr1,adr2,adr3,opcode;
    reg write,read2,read3,select;

    wire [11:0] datain;
    reg [11:0] dat;
    wire [11:0] op1,op2,op3;

    m21 testm (op3,dat,select,datain);

    alu alu1 (opcode,op1,op2,op3);

    regfile rf (datain,op1,op2,write,read2,read3,adr1,adr2,adr3);


    initial begin
    
    $dumpfile("test.vcd");
    $dumpvars(0,test);

    opcode=3'b000; dat=12'b000000000101; write=1; read2=0; read3=0; adr1=3'b000; adr2=3'b000; adr3=3'b000; select=1;#10;

    opcode=3'b000; dat=12'b000000000011; write=1; read2=0; read3=0; adr1=3'b001; adr2=3'b000; adr3=3'b000; select=1;#10;

    // ADD R2, R0, R1
    opcode=3'b001; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b010; adr2=3'b000; adr3=3'b001; select=0;#10;

    // SUB R3, R0, R1
    opcode=3'b010; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b011; adr2=3'b000; adr3=3'b001; select=0;#10;

    // MUL R4, R0, R1
    opcode=3'b011; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b100; adr2=3'b000; adr3=3'b001; select=0;#10;

    // IMUL R4, R0, R1
    opcode=3'b100; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b101; adr2=3'b000; adr3=3'b001; select=0;#10;

    // FADD R7, R5, R6
    opcode=3'b101; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b110; adr2=3'b000; adr3=3'b001; select=0;#10;

    // FMUL R7, R5, R6
    opcode=3'b110; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b111; adr2=3'b000; adr3=3'b001; select=0;#10;

    // CMP R2, R0, R
    opcode=3'b111; dat=12'b000000000001; write=1; read2=1; read3=1; adr1=3'b010; adr2=3'b000; adr3=3'b001; select=0;#10;






    $finish;

    end



endmodule

