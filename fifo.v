module fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 8
)(
    input  wire                  clk,
    input  wire                  rst,

    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] data_in,

    output reg  [DATA_WIDTH-1:0] data_out,
    output wire                  full,
    output wire                  empty
);

    // Memory array
    reg [DATA_WIDTH-1:0] memory [0:FIFO_DEPTH-1];

    // Read and write pointers
    reg [2:0] wr_ptr;
    reg [2:0] rd_ptr;

    // Counter to store number of data items
    reg [3:0] count;

    // Full and empty conditions
    assign full  = (count == FIFO_DEPTH);
    assign empty = (count == 0);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr   <= 3'b000;
            rd_ptr   <= 3'b000;
            count    <= 4'b0000;
            data_out <= 8'b00000000;
        end
        else begin

            // Write operation
            if (wr_en && !full) begin
                memory[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1'b1;
            end

            // Read operation
            if (rd_en && !empty) begin
                data_out <= memory[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
            end

            // Counter update
            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;
            endcase
        end
    end

endmodule