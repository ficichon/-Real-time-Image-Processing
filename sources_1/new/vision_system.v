`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 23:57:01
// Design Name: 
// Module Name: vision_system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vision_system(
    input clk,
    input [3:0]sw,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0] pixel_in,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0] pixel_out
    );
    wire [23:0]rgb_mux[15:0];
    wire de_mux[15:0];
    wire hsync_mux[15:0];
    wire vsync_mux[15:0];
    assign rgb_mux[0] = pixel_in;
    rgb2ycbcr_0 dut(
          .clk(clk),
          .de_in(de_in),
          .hsync_in(hsync_in),
          .vsync_in(vsync_in),
          .pixel_in(pixel_in),
          .de_out(de_mux[1]),
          .hsync_out(hsync_mux[1]),
          .vsync_out(vsync_mux[1]),
          .pixel_out(rgb_mux[1])
    );
    localparam Ta = 8'd70;
    localparam Tb = 8'd130;
    localparam Tc = 8'd140;
    localparam Td = 8'd190;
    wire [7:0] bin;
    
    assign bin = (rgb_mux[1][15:8] > Ta && rgb_mux[1][15:8] < Tb && rgb_mux[1][7:0] > Tc && rgb_mux[1][7:0] < Td) ? 8'd255 : 0;
    assign rgb_mux[2] = {bin, bin, bin};
    assign de_mux[2] = de_mux[1];
    assign hsync_mux[2] = hsync_mux[1];
    assign vsync_mux[2] = vsync_mux[1];
   
    
    
    assign pixel_out = rgb_mux[sw];
    assign de_out = de_mux[sw];
    assign hsync_out = hsync_mux[sw];
    assign vsync_out = vsync_mux[sw];
/*
    reg r_de = 0;
    reg r_hsync = 0;
    reg r_vsync = 0;
    wire [7:0] red, green, blue;
    
    always @(posedge clk) begin
        r_de <= de_in;
        r_hsync <= hsync_in;
        r_vsync <= vsync_in;
    end
    dist_mem_gen_0 find_red(
        .a(pixel_in[23:16]),
        .clk(clk),
        .qspo(red)
    );

    dist_mem_gen_0 find_green(
        .a(pixel_in[15:8]),
        .clk(clk),
        .qspo(green)
    );

    dist_mem_gen_0 find_blue(
        .a(pixel_in[7:0]),
        .clk(clk),
        .qspo(blue)
    );
    wire white = (red == 8'd255) & (green == 8'd255) & (blue == 8'd255);
    wire [7:0] binaryVal = white ? 8'd255 : 8'd0;

    assign pixel_out = {binaryVal, binaryVal, binaryVal};

    assign de_out = r_de;
    assign hsync_out = r_hsync;
    assign vsync_out = r_vsync;
    */
    
    
endmodule
