// a functional version
`define ROM_SIZE 8
`define WORD_SIZE 8
typedef bit [`WORD_SIZE-1:0] word;

typedef enum bit [1:0]  { OP_ADD, OP_SUB, OP_XOR } alu_op;

typedef enum bit [1:0] { WB_NON, WB_ACC, WB_ANS, WB_REG  } writeback;

typedef struct packed {
    bit exec_if_flag;
    bit exec_if_not_flag;
    bit exe_flag_set;
    alu_op op;
    writeback wb_reg;
    writeback wb_acc;
} instruction;

module rom (
    input clk,
    output instruction out
);
    instruction rom [`ROM_SIZE-1:0];
    bit [$clog2(`ROM_SIZE)-1:0] counter;
    //assign counter = counter + next;
    always @(posedge clk ) begin
        counter = counter + 1;
    end
    assign out = rom[counter];
endmodule


module port (
    input clk,
    input word a_data_in, b_data_in,
    input bit a_write, a_read, b_write, b_read,
    output bit read_start, write_finish,
    output word a_data_out, b_data_out,
);
    assign a_data_out= a_data_in;
    assign b_data_out = b_data_in;
endmodule

module alu (
    //input bit clk,
    input word a, b,
    input alu_op op,
    output word o,
    output bit flag
);
    //reg [`WORD_SIZE:0] result;
    //reg carry;
    
    assign {flag, o} =
        op == OP_ADD ? a + b :
        op == OP_SUB ? a - b :
        op == OP_XOR ? {a == b, a ^ b} :
        0;
    //op == OP_ADD 
    //1'b1: result <= a + b;
            //o = a+b;
        // OP_SUB:
        //     {flag, o} <= a-b;
        // OP_XOR:
        //     {flag, o} <= {a==b, a^b}
    //endcase
endmodule

module cpu (
    input clk
);
    reg flag;
    reg step = clk;

    bit read_ready;
    bit stall = !read_ready;
    word acc;
    rom rom(.clk(step), .out(current_instruction));
    instruction last_instruction;
    instruction current_instruction;
    always @(posedge clk ) begin
        last_instruction = current_instruction;
        case (current_instruction.wb_reg)
             : 
            default: 
        endcase
    end
endmodule