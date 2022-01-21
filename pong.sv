module nibble7segment(
    input [3:0] x,
    output [6:0] z
    );
    assign z =
        x == 4'h0 ? 7'b1111110:
        x == 4'h1 ? 7'b0110000:
        x == 4'h2 ? 7'b1101101:
        x == 4'h3 ? 7'b1111001:
        x == 4'h4 ? 7'b0110011:
        x == 4'h5 ? 7'b1011011:
        x == 4'h6 ? 7'b1011111:
        x == 4'h7 ? 7'b1110000:
        x == 4'h8 ? 7'b1111111:
        x == 4'h9 ? 7'b1111011:
        x == 4'hA ? 7'b1110111:
        x == 4'hB ? 7'b0011111:
        x == 4'hC ? 7'b1001110:
        x == 4'hD ? 7'b0111101:
        x == 4'hE ? 7'b1001111:
        x == 4'hF ? 7'b1000111:
        0;
endmodule

`define PLAY_SIZE 64

module abs (
    input signed [7:0] x,
    output signed [7:0] y,
);
    assign y = x >= 0 ? x : -x;
    //assign y = $max(x, -x);
endmodule

module bouncer (
    input signed [7:0] in_pos,
    input signed [3:0] in_vel,
    output bounce,
    output signed [7:0] out_pos,
    output signed [3:0] out_vel
);
    wire signed [7:0] new_pos= in_pos + in_vel;
    wire sign = in_pos>=0;
    wire new_sign = new_pos>=0;
    assign bounce = sign != new_sign;

    wire [7:0] near_bound = sign ? 1 : -1;

    wire vel_sign = in_vel >= 0;

    //assign bounce = in_pos >> 6 != 0;
    assign out_vel = bounce && (sign == vel_sign)  ? -in_vel: in_vel;
    assign out_pos = bounce ? near_bound: new_pos;
endmodule

module paddle (
    input signed [1:0] in_control,
    input signed [7:0] in_pos,
    output signed [7:0] out_pos
);
    wire signed [3:0] in_vel = 4 * in_control_1;
    bouncer bouncer_paddle(
        .in_pos(in_pos),
        .in_vel(in_vel),
        .out_pos(out_pos)
    );
endmodule

module pong (
    input clk, reset,
    input signed [1:0] in_control_1, in_control_2,
    input signed [7:0] in_paddle_1_pos, in_paddle_2_pos,
    output signed [7:0] out_paddle_1_pos, out_paddle_2_pos,
    input [3:0] in_score_p1, in_score_p2,
    input [3:0] in_ball_vel_y, in_ball_vel_x,
    output [3:0] out_score_p1, out_score_p2,
  	input signed [7:0] in_ball_pos_x, in_ball_pos_y,
    output signed [7:0] out_ball_pos_x, out_ball_pos_y,
    output wire bounce
);
    wire signed [7:0] bounce_ball_pos_x, bounce_ball_pos_y;
    wire signed [3:0] bounce_ball_vel_x, bounce_ball_vel_y;

    // \$_MUX_ pm(in_paddle_1_pos, in_paddle_2_pos, reset, out_paddle_2_pos);
    
    paddle paddle1(
        .in_control(in_control_1),
        .in_pos(in_paddle_1_pos),
        .out_pos(out_paddle_1_pos)
        );

    bouncer bouncer_ball_y(
        .in_pos(in_ball_pos_y),
        .in_vel(in_ball_vel_y),
        .bounce(bounce_ball_y),
        .out_pos(bounce_ball_pos_y),
        .out_vel(bounce_ball_vel_y)
    );
    
    bouncer bouncer_ball_x(
        .in_pos(in_ball_pos_x),
        .in_vel(in_ball_vel_x),
        .bounce(bounce_ball_x),
        .out_pos(bounce_ball_pos_x),
        .out_vel(bounce_ball_vel_x)
    );
    
    assign bounce = bounce_ball_y | bounce_ball_x;

    wire near_paddle_1 = in_ball_pos_x < 0;
    wire [7:0] near_paddle_pos = near_paddle_1 ? in_paddle_1_pos : in_paddle_2_pos;
    wire ball_diff_paddle = in_ball_pos_y - near_paddle_pos;
    wire ball_bounce_paddle = ball_diff_paddle / 4 == 0;
    
    wire gutter_ball = bounce_ball_x && ! ball_bounce_paddle; 
    assign out_score_p1 = gutter_ball && !near_paddle_1 ? in_score_p1 + 1 : in_score_p1;
    assign out_score_p2 = gutter_ball && near_paddle_1 ? in_score_p2 + 1 : in_score_p2;

    assign out_ball_pos_x = gutter_ball ? 0 : bounce_ball_pos_x;
    assign out_ball_pos_y = gutter_ball ? 0 : bounce_ball_pos_y;
    
endmodule

// module bouncer_tb ();
//     reg signed [3:0] v;
//     reg signed [7:0] x;
//     wire signed [7:0] y;
//     wire signed [3:0] m;
//     wire  b;
//     bouncer bb(x, v, b, y, m);
//     initial begin
//         $monitor("t = %g, x1=%d, v1=%d, x2=%d, v2=%d, b=%b", $time,v,x,y,m,b);
//         v = 0; x = 0; #10
        
//         v = 0; x = 10; #10
//         v = 0; x = -10; #10
//         v = 6; x = 10; #10
//         v = -6; x = -10; #10

//         v = 7; x = 60; #10
//         v = -7; x = -60; #10

//         v = 0; x = 100; #10
//         v = 0; x = -100;
//     end
// endmodule