typedef bit [7:0] word;

typedef enum bit [2:0]  {
    OP_NUL,
    OP_ADD,
    OP_SUB,
    OP_XOR,
    OP_MVB,
    OP_MAX,
    OP_MIN
} alu_op;


module alu (
    //input bit clk,
    input start,
    input word a, b,
    input alu_op op,
    output word o,
    output bit flag,
    output outputing,
);
    //reg [`WORD_SIZE:0] result;
    //reg carry;
    
    assign {flag, o} =
        op == OP_NUL ? 0 :
        op == OP_ADD ? a + b :
        op == OP_SUB ? a - b :
        op == OP_XOR ? {a == b, a ^ b} :
        op == OP_MVB ? { b != 0 , b} :
        op == OP_MAX ? { a > b , a > b? a : b} :
        op == OP_MIN ? { a < b , a < b? a : b} :
        0;
    assign finished = start;
    //op == OP_ADD 
    //1'b1: result <= a + b;
            //o = a+b;
        // OP_SUB:
        //     {flag, o} <= a-b;
        // OP_XOR:
        //     {flag, o} <= {a==b, a^b}
    //endcase
endmodule
