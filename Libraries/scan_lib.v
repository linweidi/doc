/////////////////////////////////////////////////////////////////
// Generated for Scan_Lib.lib
// Includes the Scan Cells for DFT
//
// Designed by Biraja Dash, Akash Jain, Harpreet Bhatia
// Date: 12/5/2012
/////////////////////////////////////////////////////////////////
`timescale 1ns/10ps
`celldefine
module SDFCND0HVT (CP, D, CDN, SI, SE, Q, QN);
input  CP ;
input  D ;
input  CDN ; 
input  SI, SE;
output Q,QN ;

reg NOTIFIER ;
   
   udp_mux2 (D_, D, SI, SE);
   not (I0_CLEAR, CDN);
   udp_dff (P0003, D_, CP, 1'b0, I0_CLEAR, NOTIFIER);
   buf (Q, P0003);
   not (QN, P0003); 
 //  and (\D&S , D, S);
 //  not (I7_out, D);
 // and (\~D&R , I7_out, R);
 //  and (\S&R , S, R);

 /*  specify
     // delay parameters
     specparam
       tphlh$S$Q = 0.34:0.34:0.35,
       tpllh$R$Q = 0.26:0.26:0.26,
       tphhl$R$Q = 0.26:0.26:0.27,
       tpllh$CLK$Q = 0.39:0.39:0.39,
       tplhl$CLK$Q = 0.38:0.38:0.38,
       tminpwl$S = 0.053:0.2:0.35,
       tminpwl$R = 0.037:0.15:0.27,
       tminpwh$CLK = 0.18:0.28:0.39,
       tminpwl$CLK = 0.18:0.21:0.24,
       tsetup_negedge$D$CLK = 0.094:0.094:0.094,
       thold_negedge$D$CLK = 0.000000058:0.000000058:0.000000058,
       tsetup_posedge$D$CLK = 0.094:0.094:0.094,
       thold_posedge$D$CLK = 0.00000006:0.00000006:0.00000006,
       trec$R$CLK = -0.094:-0.094:-0.094,
       trem$R$CLK = 0.19:0.19:0.19,
       trec$R$S = 0.00000006:0.00000006:0.00000006,
       trec$S$CLK = 0:0:0,
       trem$S$CLK = 0.094:0.094:0.094,
       trec$S$R = 0.094:0.094:0.094;

     // path delays
     (CLK *> Q) = (tpllh$CLK$Q, tplhl$CLK$Q);
     (R *> Q) = (tpllh$R$Q, tphhl$R$Q);
     (S *> Q) = (tphlh$S$Q, 0);
     $setup(negedge D, posedge CLK &&& \S&R , tsetup_negedge$D$CLK, NOTIFIER);
     $hold (negedge D, posedge CLK &&& \S&R , thold_negedge$D$CLK,  NOTIFIER);
     $setup(posedge D, posedge CLK &&& \S&R , tsetup_posedge$D$CLK, NOTIFIER);
     $hold (posedge D, posedge CLK &&& \S&R , thold_posedge$D$CLK,  NOTIFIER);
     $recovery(posedge R, posedge CLK &&& \D&S , trec$R$CLK, NOTIFIER);
     $removal (posedge R, posedge CLK &&& \D&S , trem$R$CLK, NOTIFIER);
     $recovery(posedge R, posedge S, trec$R$S, NOTIFIER);
     $recovery(posedge S, posedge CLK &&& \~D&R , trec$S$CLK, NOTIFIER);
     $removal (posedge S, posedge CLK &&& \~D&R , trem$S$CLK, NOTIFIER);
     $recovery(posedge S, posedge R, trec$S$R, NOTIFIER);
     $width(negedge S, tminpwl$S, 0, NOTIFIER);
     $width(negedge R, tminpwl$R, 0, NOTIFIER);
     $width(posedge CLK, tminpwh$CLK, 0, NOTIFIER);
     $width(negedge CLK, tminpwl$CLK, 0, NOTIFIER);

   endspecify */

endmodule
`endcelldefine
/*

primitive udp_dff (out, in, clk, clr, set, NOTIFIER);
   output out;
   input  in, clk, clr, set, NOTIFIER;
   reg    out;

   table

// in  clk  clr   set  NOT  : Qt : Qt+1
//
   0  r   ?   0   ?   : ?  :  0  ; // clock in 0
   1  r   0   ?   ?   : ?  :  1  ; // clock in 1
   1  *   0   ?   ?   : 1  :  1  ; // reduce pessimism
   0  *   ?   0   ?   : 0  :  0  ; // reduce pessimism
   ?  f   ?   ?   ?   : ?  :  -  ; // no changes on negedge clk
   *  b   ?   ?   ?   : ?  :  -  ; // no changes when in switches
   ?  ?   ?   1   ?   : ?  :  1  ; // set output
   ?  b   0   *   ?   : 1  :  1  ; // cover all transistions on set
   1  x   0   *   ?   : 1  :  1  ; // cover all transistions on set
   ?  ?   1   0   ?   : ?  :  0  ; // reset output
   ?  b   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   0  x   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   ?  ?   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_dff 

primitive udp_mux2 (out, in0, in1, sel);
   output out;
   input  in0, in1, sel;

   table

// in0 in1 sel :  out
//
    1  ?  0 :  1 ;
    0  ?  0 :  0 ;
    ?  1  1 :  1 ;
    ?  0  1 :  0 ;
    0  0  x :  0 ;
    1  1  x :  1 ;

   endtable
endprimitive // udp_mux2

*/
