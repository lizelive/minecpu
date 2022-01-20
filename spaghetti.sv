// a functional version
`define ROM_SIZE 8
`define WORD_SIZE 8
typedef bit [`WORD_SIZE-1:0] word;

typedef enum bit [1:0]  { OP_ADD, OP_SUB, OP_XOR, OP_MOV } alu_op;

typedef enum bit [1:0] { WB_NON, WB_ACC, WB_REG  } writeback_mode;


typedef enum bit [2:0] {
    V0, 
    V1,
    RA,
    R1,
    P1,
    P2,
    P3,
    P4  } register_name;


typedef struct packed {
    bit clk;
    word data;
} io_bus;

typedef struct packed {
    bit if_flag;
    bit if_not_flag;
    bit set_flag;
} exec_opts;

typedef struct packed {
    exec_opts exec; //3
    alu_op op; // 2
    register_name r; //3
    register_name write_to; //3
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


module register (
    input word data_in,
    input bit write, read,
    output bit read_ready, write_done,
    output word data_out,
);

    word data;// = write ? data_in : data;
    assign data_out = read ? data_out : 0;
    assign read_ready = read;
    assign write_done = write;
    always @(posedge write ) begin
        data = data_in;
    end
endmodule

module port (
    input clk,
    input word a_data_in,
    input bit a_write, a_read,
    output bit a_read_ready, a_write_done,
    output word a_data_out,

    input word a_data_in,
    input bit a_write, read,
    output bit a_read_ready, a_write_done,
    output word a_data_out,
);
    register a(
        .data_in(a_data_in),
        .write(a_write),
        .read(b_read),
        .read_ready(b_read_ready),
    );
    register b();
    assign a_data_out= a_data_in;
    assign b_data_out = b_data_in;
endmodule

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
        op == OP_ADD ? a + b :
        op == OP_SUB ? a - b :
        op == OP_XOR ? {a == b, a ^ b} :
        op == OP_MOV ? { b != 0 , b} :
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

module cpu (
    input clk,
    input io_bus i1, i2, i3, i4,
    output io_bus i1, i2, i3, i4,
);
    reg flag;


always @(posedge clk ) begin
    
end

    reg step = clk;

    bit read_ready;
    bit stall = !read_ready;
    
    register acc(
        .data_in(result),
        .read(b_ready),
        .write(write_to_acc),
        .read_ready(alu_start),
        .write_done(write_done_a),
        .data_out(a_value)
    );

    // input word data_in,
    // input bit write, read,
    // output bit read_ready, write_done,
    // output word data_out,


    register r1(
        .data_in(result),
        );

    word a_value;
    
    word b_value;

    word result;
    
    bit flag_output;

    bit writeback;
    
    bit writeback_done = write_done_a | write_done_r1;

    bit write_done_a;
    bit write_done_r1;

    word write_to_acc = current_instruction.write_to == WB_ACC && writeback;
    word write_to_reg = current_instruction.write_to == WB_REG && writeback;

    bit alu_start;
    alu alu(
        .start(alu_start),
        .a(a_value), 
        .b(b_value),
        .op(current_instruction.op),
        .o(result),
        .flag(flag_output),
        .outputing(writeback));



    word write_out;





    rom rom(.clk(step), .out(current_instruction));
    instruction last_instruction;
    instruction current_instruction;
    always @(posedge clk ) begin
        last_instruction = current_instruction;
        // case (current_instruction.wb_reg)
        //      : 
        //     default: 
        // endcase
    end
endmodule

// this is not making the code cleaer
module register_file (
    input register_name reg_write, reg_read,
    input word data_in,
    input bit write, read,
    output bit read_ready, write_done,
    output word data_out
);

    bit [7: 0] do_write = write < reg_write;
    bit [7:0] do_read = (read < reg_read1) | (read < reg_read2);
    assign data_out = read ? (
        reg_read == V0 ? 0 :
        reg_read == V1 ? 1 :
        reg_read == VI ? :
        reg_read == R1 ? :
        reg_read == P1 ? :
        reg_read == P2 ? :
        reg_read == P3 ? :
        reg_read == P4 ? : 0
    )  : 0;
endmodule