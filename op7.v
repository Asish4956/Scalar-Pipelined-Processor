`timescale 1ns/1ps

module op7(result,op_1,op_2);

    input wire [11:0] op_1,op_2;
    output wire [11:0] result;

    reg zero=0;

    buf op7[11:8] (result[11:8],zero);
    xor op7xor[7:0](result[7:0],op_1[7:0],op_2[7:0]);


endmodule

