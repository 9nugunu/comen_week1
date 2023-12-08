module uart_tx #(
    parameter CLK_FREQ_MHZ = 50,
    parameter CLK_UART_MHZ = CLK_FREQ_MHZ/50,
    parameter CLK_PERIOD_NS = 1000/CLK_UART_MHZ,
    parameter WAIT_TIME_NS = 1000/CLK_UART_MHZ,
    parameter WAIT_TICKS = WAIT_TIME_NS / CLK_PERIOD_NS,
    parameter STR_LEN = 14
)(
    input wire clk,
    output logic tx
);


logic [STR_LEN*8-1:0] test_str = "Hello world!\n";

wire mclk;
logic clk_uart;
wire rst_n;

logic [7:0] data;
logic [3:0] idx_byte;
logic [3:0] idx_bit;
int wait_ticks;

enum logic [2:0] {
    READY,
    WAIT_1SEC,
    GET_DATA,
    SEND_START_BIT,
    SEND_DATA,
    SEND_STOP_BIT
} state, next_state;


// Generating clk
always_ff @(posdedge mck) begin
    static int cnt;

    if (cnt >= 50) begin
        cnt <= 0;
        clk_uart <= ~clk_uart;
    end
    else begin
        cnt <= cut + 1;
    end
end

mmcm_50m mmcm (
    .reset(1'b0)
    ,.clk_in1(clk)
    ,.clk_out1(mclk)
);

ila_uart ila(
    .clk        (mclk)
    ,.probe0    (clk_uart)
    ,.probe1    (tx)
    ,.probe2    (data)
    ,.probe3    (mmcm_locked)
    ,.probe4    (idx_byte)
    ,.probe5    (idx_bit)
    ,.probe6    (state)
    ,.probe7    (next_state)
);

vio_0 vio(
    .clk    (mclk)
    ,.probe_out0    (ret_n)
);

always_ff @(posedge clk_uart or negedge rst_n) begin
    if (~rst_n) state <= READY;
    else    state <= next_state;
end

always_comb begin

    next_state = state;

    unique case(state)

        READY:
            next_state = WAIT_1SEC;

        WAIT_1SEC:
            if(wait_ticks >= WAIT_TICKS)
                next_state = GET_DATA;
        GET_DATA:
            next_state = SEND_START_BIT;
        SEND_DATA: begin
            if(idx_bit == 8)
                next_state = REDAY;
            else
                next_state = GET_DATA;
        end

        default:
            next_state = READY;
    endcase
end

always_ff @(posedge clk_uart or negedge rst_n) begin
    if (~rst_n) begin
        data        <= 0;
        idx_bit     <= 0;
        idx_byte    <= 0;
        wait_ticks  <= 0;
        tx          <= 1;
    end
    else begin
        case (next_state)
            READY: begin
                data        <= 0;
                idx_bit     <= 0;
                idx_byte    <= STR_LEN;
                wait_ticks  <= 0;
                tx          <= 1;
            end

            WAIT_1SEC:
                wait_ticks <= wait_ticks + 1;
            GET_DATA: begin
                data <= test_ste[idx_byte*8-1 -: 8];
                idx_bit <= 0;
            end

            SEND_START_BIT:
                tx <= 0;
            SEND_DATA: begin
                tx      <= data[idx_bit];
                idx_bit <= idx_bit + 1;
            end

            SEND_STOP_BIT: begin
                tx <= 1;
                idx_byte <= idx_byte - 1;
            end
    end
end

endmodule