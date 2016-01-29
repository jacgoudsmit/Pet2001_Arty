`timescale 1ns / 1ps
//
// simtop.v
//
//      Simulate top module for Pet2001_Arty.
//
module testPet2001_Arty;

    reg [2:0]  SW;
    reg        BTN;
    wire       PET_VID_DATA_N;
    wire       PET_VID_HORZ_N;
    wire       PET_VID_VERT_N;
    wire       LED;
    wire [9:0] KEYROW;
    reg [7:0]  KEYCOL;
    reg        CLK100;

    initial begin
        SW = 3'b000;
        BTN = 1'b0;
        KEYCOL = 8'h00;
        CLK100 = 1'b0;
    end

    always #5.0 CLK100 = ~CLK100; // outboard clock 100Mhz

    // DUT
    Pet2001_Arty dut(.SW(SW),
                     .BTN(BTN),
                     .LED(LED),
                     .PET_VID_DATA_N(PET_VID_DATA_N),
                     .PET_VID_HORZ_N(PET_VID_HORZ_N),
                     .PET_VID_VERT_N(PET_VID_VERT_N),
                     .KEYROW(KEYROW),
                     .KEYCOL(KEYCOL),
                     .CLK(CLK100)
                  );
    
endmodule // testPet2001_Arty
