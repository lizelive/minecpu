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


module bouncer (
    input signed [7:0] in_pos,
    input signed [3:0] in_vel,
    output bounce,
    output signed [7:0] out_pos,
    output signed [3:0] out_vel
);
    wire signed [7:0] new_pos = in_pos + in_vel;
    assign bounce = new_pos >> 6 != 0;
    assign out_vel = bounce ? -in_vel : in_vel;
    assign out_pos = bounce ? in_pos: new_pos;
endmodule

module pong (
    input clk, reset,
    input signed [1:0] in_p1, in_p2,
    output reg [3:0] score_p1, score_p2,
    output reg signed [7:0] paddle_p1, paddle_p2,
  	output reg signed [7:0] ball_pos_x, ball_pos_y,
);
    bouncer bouncer_ball_y(
            .in_pos,
            .in_vel,
            .bounce,
            .out_pos,
            .out_vel
    )
    reg signed [3:0] ball_vel_x;
    reg signed [3:0] ball_vel_y;
    reg reset_ball = 0;

    reg [7:0] ball_pos_next_y;
    always @(posedge clk ) begin
        if (reset) begin
            score_p1 = 0;
            score_p2 = 0;
            paddle_p1 = 0;
            paddle_p2 = 0;
            reset_ball = 1;
        end

        if (ball_pos_x > PLAY_SIZE) begin
            score_p1 = score_p1 + 1;
            reset_ball = 1;
        end else if (ball_pos_x < -PLAY_SIZE) begin
            score_p2 = score_p2 + 1;
            reset_ball = 1;
        end else begin
            ball_pos_x <= ball_pos_x + ball_vel_x;
        end
        
        paddle_p1 <= paddle_p1 + in_p1;
        paddle_p2 <= paddle_p2 + in_p2;

        if (reset_ball) begin
            ball_pos_x = 0;
            ball_pos_y = 0;
            ball_vel_x = 1;
            ball_vel_y = 1;
        end else begin
            // move the ball in y direction
            // assert the velocity is less then 20
            ball_pos_next_y = ball_pos_y + ball_vel_y;
            if (ball_pos_next_y >=  PLAY_SIZE || ball_pos_next_y <= -PLAY_SIZE) begin
                ball_vel_y = - ball_vel_y;
            end else begin
                ball_pos_y = ball_pos_next_y;
            end
        end
    end
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