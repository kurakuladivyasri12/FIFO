`timescale 1ns/1ps

module fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter FIFO_DEPTH = 8;

    reg clk;
    reg rst;

    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;
    wire full;
    wire empty;

    // Instantiate FIFO
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Write task
    task write_data(input [7:0] data);
    begin
        @(negedge clk);
        wr_en = 1'b1;
        rd_en = 1'b0;
        data_in = data;

        @(negedge clk);
        wr_en = 1'b0;

        $display("WRITE: Data = %h | Full = %b | Empty = %b",
                 data, full, empty);
    end
    endtask

    // Read task
    task read_data;
    begin
        @(negedge clk);
        wr_en = 1'b0;
        rd_en = 1'b1;

        @(negedge clk);
        rd_en = 1'b0;

        $display("READ : Data = %h | Full = %b | Empty = %b",
                 data_out, full, empty);
    end
    endtask

    initial begin

        // Initialize signals
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        // Reset
        #10;
        rst = 0;

        $display("-------------------------------------");
        $display("       FIFO SIMULATION START");
        $display("-------------------------------------");

        // Write data
        write_data(8'hA1);
        write_data(8'hB2);
        write_data(8'hC3);
        write_data(8'hD4);

        // Read data
        read_data;
        read_data;
        read_data;
        read_data;

        // Check empty condition
        $display("-------------------------------------");
        $display("FIFO Empty = %b", empty);

        // Write more data
        write_data(8'h11);
        write_data(8'h22);
        write_data(8'h33);

        // Read data
        read_data;
        read_data;
        read_data;

        $display("-------------------------------------");
        $display("       FIFO SIMULATION END");
        $display("-------------------------------------");

        #20;
        $finish;
    end

endmodule