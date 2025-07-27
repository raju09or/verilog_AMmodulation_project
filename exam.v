module exam(
    input wire clk,           
    input wire rst,           
    output reg signed [15:0] sin_carrier, 
    output reg signed [15:0] sin_env,    
    output reg signed [31:0] am_out      
);

    reg [15:0] phase_carrier = 0;
    reg [15:0] phase_env = 0;
    
    parameter FCW_CARRIER = 16'd410; 
    parameter FCW_ENV = 16'd50;      

    function signed [15:0] sine_lut;
        input [15:0] phase;
        begin
            case (phase[15:12])
                4'd0:  sine_lut =  0;
                4'd1:  sine_lut =  8192;
                4'd2:  sine_lut =  16384;
                4'd3:  sine_lut =  24576;
                4'd4:  sine_lut =  32767;
                4'd5:  sine_lut =  24576;
                4'd6:  sine_lut =  16384;
                4'd7:  sine_lut =  8192;
                4'd8:  sine_lut =  0;
                4'd9:  sine_lut = -8192;
                4'd10: sine_lut = -16384;
                4'd11: sine_lut = -24576;
                4'd12: sine_lut = -32767;
                4'd13: sine_lut = -24576;
                4'd14: sine_lut = -16384;
                4'd15: sine_lut = -8192;
            endcase
        end
    endfunction

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            phase_carrier <= 0;
            phase_env <= 0;
            sin_carrier <= 0;
            sin_env <= 0;
            am_out <= 0;
        end 
        else begin
            phase_carrier <= phase_carrier + FCW_CARRIER;
            phase_env <= phase_env + FCW_ENV;

            sin_carrier <= sine_lut(phase_carrier);
            sin_env <= sine_lut(phase_env);

            am_out <= (sin_carrier * (sin_env + 32767)) >>> 15;
        end
    end
endmodule
