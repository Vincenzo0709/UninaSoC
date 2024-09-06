// Author: Vincenzo Maisto <vincenzo.maisto2@unina.it>
// Author: Stefano Mercogliano <stefano.mercogliano@unina.it>
// Author: Zaira Abdel Majid <z.abdelmajid@studenti.unina.it>
// Description: Basic version of UninaSoC that allows to work with axi transactions to and from slaves (ToBeUpdated)
// NOTE: vio and rvm_socket are commented off in this version
                                                      

// System architecture:                                                                                      
//                                                                                    ________               
//   _________              ____________               __________                    |        |              
//  |  (tbd)  |            |    (tbd)   |             |          |                   |  Main  |              
//  |   vio   |----------->| rvm_socket |------------>|          |        /--------->| Memory |              
//  |_________|            |____________|             |   AXI    |        |          |________|              
//   __________                                       | crossbar |--------|           ________               
//  |          |                                      |          |        |          |        |              
//  | jtag_axi |------------------------------------->|          |        |--------->|  UART  |              
//  |__________|                                      |__________|        |          |________|              
//                                                                        |           __________      ______         
//                                                                        |          |          |    |      |              
//                                                                        \--------->| AXI4 to  |--->| GPIO |              
//                                                                                   | AXI-lite |    |______|
//                                                                                   |__________|              
//                       

import uninasoc_pkg::*;                                                                                      
import uninasoc_pkg_axi::*;                                                                                      
                                                                                                             
module uninasoc (                                                                                                          
     // interfaccia                                                                                          
    input sys_clock_i,                                                                                           
    input sys_reset_i,                                                                                           
  //  input  wire [NUM_GPIO_IN  -1 : 0]  gpio_in,                                                           
    output logic [NUM_GPIO_OUT -1 : 0]  gpio_out_o                                                             
);                                                                                                           

    /////////////////////                                                                                              
    // Local variables //
    /////////////////////                                                                                       

    ///////////////////////
    // Clocks and resets //
    ///////////////////////
    // Reset negative
    logic sys_resetn = ~sys_reset_i;
    // clkwiz -> all                                                                                         
    logic soc_clk;                                                                                           
    // vio -> all                                                                                            
    logic vio_reset_n;                                                                                       
    // vio -> rvm_socket                                                                                     
    logic [AXI_ADDR_WIDTH -1 : 0 ] vio_bootaddr;                                                             
    // logic [NUM_IRQ        -1 : 0 ] vio_irq;                                                                  
    // uart -> rvm_socket                        
    // logic uart_interrupt;                                                                                    

    /////////////////////////////                       
    // Modules interconnection //
    /////////////////////////////      
    // TODO: add for loops over NUM_AXI_AXI_MASTERS and NUM_AXI_AXI_SLAVES
    // AXI masters                                                                                           
    // jtag2axi -> crossbar                                                         
    `DEFINE_AXI_BUS(j2a_to_xbar);
    // AXI slaves                         
    // xbar -> GPIO out
    `DEFINE_AXI_BUS(xbar_to_gpio_out);
    // xbar -> main memory
    `DEFINE_AXI_BUS(xbar_to_main_mem);

    /////////////                                                                                            
    // Modules //
    /////////////                                                                                            
                                                                                                             
    // PLL                                                                                                   
    xlnx_clk_wiz clkwiz_inst (                                                                               
        .clk_in1  ( sys_clock_i  ),                                                                               
        .resetn   ( sys_resetn ),                                                                               
        .locked   ( ),                                                                                       
        .clk_100  ( ),                                                                                       
        .clk_50   ( soc_clk   ),                                                                              
        .clk_20   ( ),                                                                                       
        .clk_10   ( )                                                                                        
    );                                                                                                       
                                                                                                             
    // JTAG2AXI Master                                                                                       
    xlnx_jtag_axi jtag_axi_inst (                                                                            
        .aclk           ( soc_clk                   ), // input wire aclk                                            
        .aresetn        ( sys_resetn                ), // input wire aresetn                                              
        .m_axi_awid     ( j2a_to_xbar_axi_awid      ), // output wire [1 : 0] m_axi_awid                                    
        .m_axi_awaddr   ( j2a_to_xbar_axi_awaddr    ), // output wire [31 : 0] m_axi_awid                            
        .m_axi_awlen    ( j2a_to_xbar_axi_awlen     ), // output wire [7 : 0] m_axi_awlen                                   
        .m_axi_awsize   ( j2a_to_xbar_axi_awsize    ), // output wire [2 : 0] m_axi_awsize                                   
        .m_axi_awburst  ( j2a_to_xbar_axi_awburst   ), // output wire [1 : 0] m_axi_awburst                                   
        .m_axi_awlock   ( j2a_to_xbar_axi_awlock    ), // output wire m_axi_awlock                                           
        .m_axi_awcache  ( j2a_to_xbar_axi_awcache   ), // output wire [3 : 0] m_axi_awcache                                    
        .m_axi_awprot   ( j2a_to_xbar_axi_awprot    ), // output wire [2 : 0] m_axi_awprot                                    
        .m_axi_awqos    ( j2a_to_xbar_axi_awqos     ), // output wire [3 : 0] m_axi_awqos                                   
        .m_axi_awvalid  ( j2a_to_xbar_axi_awvalid   ), // output wire m_axi_awvalid                                  
        .m_axi_awready  ( j2a_to_xbar_axi_awready   ), // input wire m_axi_awready                                   
        .m_axi_wdata    ( j2a_to_xbar_axi_wdata     ), // output wire [31 : 0] m_axi_wdata                           
        .m_axi_wstrb    ( j2a_to_xbar_axi_wstrb     ), // output wire [3 : 0] m_axi_wstrb                            
        .m_axi_wlast    ( j2a_to_xbar_axi_wlast     ), // output wire m_axi_wlast                                           
        .m_axi_wvalid   ( j2a_to_xbar_axi_wvalid    ), // output wire m_axi_wvalid                                   
        .m_axi_wready   ( j2a_to_xbar_axi_wready    ), // input wire m_axi_wready                                    
        .m_axi_bid      ( j2a_to_xbar_axi_bid       ), // input wire [0 : 0] m_axi_bid                               
        .m_axi_bresp    ( j2a_to_xbar_axi_bresp     ), // input wire [1 : 0] m_axi_bresp                             
        .m_axi_bvalid   ( j2a_to_xbar_axi_bvalid    ), // input wire m_axi_bvalid                                    
        .m_axi_bready   ( j2a_to_xbar_axi_bready    ), // output wire m_axi_bready                                   
        .m_axi_arid     ( j2a_to_xbar_axi_arid      ), // output wire [0 : 0] m_axi_arid                                   
        .m_axi_araddr   ( j2a_to_xbar_axi_araddr    ), // output wire [31 : 0] m_axi_araddr                          
        .m_axi_arlen    ( j2a_to_xbar_axi_arlen     ), // output wire [7 : 0] m_axi_arlen                                   
        .m_axi_arsize   ( j2a_to_xbar_axi_arsize    ), // output wire [2 : 0] m_axi_arsize                                    
        .m_axi_arburst  ( j2a_to_xbar_axi_arburst   ), // output wire [1 : 0] m_axi_arburst                                   
        .m_axi_arlock   ( j2a_to_xbar_axi_arlock    ), // output wire m_axi_arlock                                           
        .m_axi_arcache  ( j2a_to_xbar_axi_arcache   ), // output wire [3 : 0] m_axi_arcache                                     
        .m_axi_arprot   ( j2a_to_xbar_axi_arprot    ), // output wire [2 : 0] m_axi_arprot                                   
        .m_axi_arqos    ( j2a_to_xbar_axi_arqos     ), // output wire [3 : 0] m_axi_arqos                                   
        .m_axi_arvalid  ( j2a_to_xbar_axi_arvalid   ), // output wire m_axi_arvalid                                  
        .m_axi_arready  ( j2a_to_xbar_axi_arready   ), // input wire m_axi_arready                                   
        .m_axi_rid      ( j2a_to_xbar_axi_rid       ), // input wire [1 : 0] m_axi_rid                               
        .m_axi_rdata    ( j2a_to_xbar_axi_rdata     ), // input wire [31 : 0] m_axi_rdata                            
        .m_axi_rresp    ( j2a_to_xbar_axi_rresp     ), // input wire [1 : 0] m_axi_rresp                             
        .m_axi_rlast    ( j2a_to_xbar_axi_rlast     ), // input wire m_axi_rlast                                     
        .m_axi_rvalid   ( j2a_to_xbar_axi_rvalid    ), // input wire m_axi_rvalid                                    
        .m_axi_rready   ( j2a_to_xbar_axi_rready    )  // output wire m_axi_rready                                   
    );          
                                                                                                 
    // Axi Crossbar 
    // TODO: concat axi signals with for loops over NUM_AXI_MASTERS and NUM_AXI_SLAVES
    //       Moreover, concat should also take the relative slave index in account
    xlnx_axi_crossbar axi_xbar_inst (
        .aclk           ( soc_clk                  ), // input wire aclk
        .aresetn        ( sys_resetn               ), // input wire aresetn
        .s_axi_awid     ( j2a_to_xbar_axi_awid     ), // input wire [1 : 0] s_axi_awid
        .s_axi_awaddr   ( j2a_to_xbar_axi_awaddr   ), // input wire [31 : 0] s_axi_awaddr
        .s_axi_awlen    ( j2a_to_xbar_axi_awlen    ), // input wire [7 : 0] s_axi_awlen
        .s_axi_awsize   ( j2a_to_xbar_axi_awsize   ), // input wire [2 : 0] s_axi_awsize
        .s_axi_awburst  ( j2a_to_xbar_axi_awburst  ), // input wire [1 : 0] s_axi_awburst
        .s_axi_awlock   ( j2a_to_xbar_axi_awlock   ), // input wire [0 : 0] s_axi_awlock
        .s_axi_awcache  ( j2a_to_xbar_axi_awcache  ), // input wire [3 : 0] s_axi_awcache
        .s_axi_awprot   ( j2a_to_xbar_axi_awprot   ), // input wire [2 : 0] s_axi_awprot
        .s_axi_awqos    ( j2a_to_xbar_axi_awqos    ), // input wire [3 : 0] s_axi_awqos
        .s_axi_awvalid  ( j2a_to_xbar_axi_awvalid  ), // input wire [0 : 0] s_axi_awvalid
        .s_axi_awready  ( j2a_to_xbar_axi_awready  ), // output wire [0 : 0] s_axi_awready
        .s_axi_wdata    ( j2a_to_xbar_axi_wdata    ), // input wire [31 : 0] s_axi_wdata
        .s_axi_wstrb    ( j2a_to_xbar_axi_wstrb    ), // input wire [3 : 0] s_axi_wstrb
        .s_axi_wlast    ( j2a_to_xbar_axi_wlast    ), // input wire [0 : 0] s_axi_wlast
        .s_axi_wvalid   ( j2a_to_xbar_axi_wvalid   ), // input wire [0 : 0] s_axi_wvalid
        .s_axi_wready   ( j2a_to_xbar_axi_wready   ), // output wire [0 : 0] s_axi_wready
        .s_axi_bid      ( j2a_to_xbar_axi_bid      ), // output wire [1 : 0] s_axi_bid
        .s_axi_bresp    ( j2a_to_xbar_axi_bresp    ), // output wire [1 : 0] s_axi_bresp
        .s_axi_bvalid   ( j2a_to_xbar_axi_bvalid   ), // output wire [0 : 0] s_axi_bvalid
        .s_axi_bready   ( j2a_to_xbar_axi_bready   ), // input wire [0 : 0] s_axi_bready
        .s_axi_arid     ( j2a_to_xbar_axi_arid     ), // output wire [1 : 0] s_axi_bid
        .s_axi_araddr   ( j2a_to_xbar_axi_araddr   ), // input wire [31 : 0] s_axi_araddr
        .s_axi_arlen    ( j2a_to_xbar_axi_arlen    ), // input wire [7 : 0] s_axi_arlen
        .s_axi_arsize   ( j2a_to_xbar_axi_arsize   ), // input wire [2 : 0] s_axi_arsize
        .s_axi_arburst  ( j2a_to_xbar_axi_arburst  ), // input wire [1 : 0] s_axi_arburst
        .s_axi_arlock   ( j2a_to_xbar_axi_arlock   ), // input wire [0 : 0] s_axi_arlock
        .s_axi_arcache  ( j2a_to_xbar_axi_arcache  ), // input wire [3 : 0] s_axi_arcache
        .s_axi_arprot   ( j2a_to_xbar_axi_arprot   ), // input wire [2 : 0] s_axi_arprot
        .s_axi_arqos    ( j2a_to_xbar_axi_arqos    ), // input wire [3 : 0] s_axi_arqos
        .s_axi_arvalid  ( j2a_to_xbar_axi_arvalid  ), // input wire [0 : 0] s_axi_arvalid
        .s_axi_arready  ( j2a_to_xbar_axi_arready  ), // output wire [0 : 0] s_axi_arready
        .s_axi_rid      ( j2a_to_xbar_axi_rid      ), // output wire [1 : 0] s_axi_rid
        .s_axi_rdata    ( j2a_to_xbar_axi_rdata    ), // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp    ( j2a_to_xbar_axi_rresp    ), // output wire [1 : 0] s_axi_rresp
        .s_axi_rlast    ( j2a_to_xbar_axi_rlast    ), // output wire [0 : 0] s_axi_rlast
        .s_axi_rvalid   ( j2a_to_xbar_axi_rvalid   ), // output wire [0 : 0] s_axi_rvalid
        .s_axi_rready   ( j2a_to_xbar_axi_rready   ), // input wire [0 : 0] s_axi_rready
        .m_axi_awid     ( { xbar_to_gpio_out_axi_awid    , xbar_to_main_mem_axi_awid     } ), // output wire [3 : 0] m_axi_awid
        .m_axi_awaddr   ( { xbar_to_gpio_out_axi_awaddr  , xbar_to_main_mem_axi_awaddr   } ), // output wire [63 : 0] m_axi_awaddr
        .m_axi_awlen    ( { xbar_to_gpio_out_axi_awlen   , xbar_to_main_mem_axi_awlen    } ), // output wire [15 : 0] m_axi_awlen
        .m_axi_awsize   ( { xbar_to_gpio_out_axi_awsize  , xbar_to_main_mem_axi_awsize   } ), // output wire [5 : 0] m_axi_awsize
        .m_axi_awburst  ( { xbar_to_gpio_out_axi_awburst , xbar_to_main_mem_axi_awburst  } ), // output wire [3 : 0] m_axi_awburst
        .m_axi_awlock   ( { xbar_to_gpio_out_axi_awlock  , xbar_to_main_mem_axi_awlock   } ), // output wire [1 : 0] m_axi_awlock
        .m_axi_awcache  ( { xbar_to_gpio_out_axi_awcache , xbar_to_main_mem_axi_awcache  } ), // output wire [7 : 0] m_axi_awcache
        .m_axi_awprot   ( { xbar_to_gpio_out_axi_awprot  , xbar_to_main_mem_axi_awprot   } ), // output wire [5 : 0] m_axi_awprot
        .m_axi_awregion ( { xbar_to_gpio_out_axi_awregion, xbar_to_main_mem_axi_awregion } ), // output wire [7 : 0] m_axi_awregion
        .m_axi_awqos    ( { xbar_to_gpio_out_axi_awqos   , xbar_to_main_mem_axi_awqos    } ), // output wire [7 : 0] m_axi_awqos
        .m_axi_awvalid  ( { xbar_to_gpio_out_axi_awvalid , xbar_to_main_mem_axi_awvalid  } ), // output wire [1 : 0] m_axi_awvalid
        .m_axi_awready  ( { xbar_to_gpio_out_axi_awready , xbar_to_main_mem_axi_awready  } ), // input wire [1 : 0] m_axi_awready
        .m_axi_wdata    ( { xbar_to_gpio_out_axi_wdata   , xbar_to_main_mem_axi_wdata    } ), // output wire [63 : 0] m_axi_wdata
        .m_axi_wstrb    ( { xbar_to_gpio_out_axi_wstrb   , xbar_to_main_mem_axi_wstrb    } ), // output wire [7 : 0] m_axi_wstrb
        .m_axi_wlast    ( { xbar_to_gpio_out_axi_wlast   , xbar_to_main_mem_axi_wlast    } ), // output wire [1 : 0] m_axi_wlast
        .m_axi_wvalid   ( { xbar_to_gpio_out_axi_wvalid  , xbar_to_main_mem_axi_wvalid   } ), // output wire [1 : 0] m_axi_wvalid
        .m_axi_wready   ( { xbar_to_gpio_out_axi_wready  , xbar_to_main_mem_axi_wready   } ), // input wire [1 : 0] m_axi_wready
        .m_axi_bid      ( { xbar_to_gpio_out_axi_bid     , xbar_to_main_mem_axi_bid      } ), // input wire [3 : 0] m_axi_bid
        .m_axi_bresp    ( { xbar_to_gpio_out_axi_bresp   , xbar_to_main_mem_axi_bresp    } ), // input wire [3 : 0] m_axi_bresp
        .m_axi_bvalid   ( { xbar_to_gpio_out_axi_bvalid  , xbar_to_main_mem_axi_bvalid   } ), // input wire [1 : 0] m_axi_bvalid
        .m_axi_bready   ( { xbar_to_gpio_out_axi_bready  , xbar_to_main_mem_axi_bready   } ), // output wire [1 : 0] m_axi_bready
        .m_axi_arid     ( { xbar_to_gpio_out_axi_arid    , xbar_to_main_mem_axi_arid     } ), // output wire [3 : 0] m_axi_arid
        .m_axi_araddr   ( { xbar_to_gpio_out_axi_araddr  , xbar_to_main_mem_axi_araddr   } ), // output wire [63 : 0] m_axi_araddr
        .m_axi_arlen    ( { xbar_to_gpio_out_axi_arlen   , xbar_to_main_mem_axi_arlen    } ), // output wire [15 : 0] m_axi_arlen
        .m_axi_arsize   ( { xbar_to_gpio_out_axi_arsize  , xbar_to_main_mem_axi_arsize   } ), // output wire [5 : 0] m_axi_arsize
        .m_axi_arburst  ( { xbar_to_gpio_out_axi_arburst , xbar_to_main_mem_axi_arburst  } ), // output wire [3 : 0] m_axi_arburst
        .m_axi_arlock   ( { xbar_to_gpio_out_axi_arlock  , xbar_to_main_mem_axi_arlock   } ), // output wire [1 : 0] m_axi_arlock
        .m_axi_arcache  ( { xbar_to_gpio_out_axi_arcache , xbar_to_main_mem_axi_arcache  } ), // output wire [7 : 0] m_axi_arcache
        .m_axi_arprot   ( { xbar_to_gpio_out_axi_arprot  , xbar_to_main_mem_axi_arprot   } ), // output wire [5 : 0] m_axi_arprot
        .m_axi_arregion ( { xbar_to_gpio_out_axi_arregion, xbar_to_main_mem_axi_arregion } ), // output wire [7 : 0] m_axi_arregion
        .m_axi_arqos    ( { xbar_to_gpio_out_axi_arqos   , xbar_to_main_mem_axi_arqos    } ), // output wire [7 : 0] m_axi_arqos
        .m_axi_arvalid  ( { xbar_to_gpio_out_axi_arvalid , xbar_to_main_mem_axi_arvalid  } ), // output wire [1 : 0] m_axi_arvalid
        .m_axi_arready  ( { xbar_to_gpio_out_axi_arready , xbar_to_main_mem_axi_arready  } ), // input wire [1 : 0] m_axi_arready
        .m_axi_rid      ( { xbar_to_gpio_out_axi_rid     , xbar_to_main_mem_axi_rid      } ), // input wire [3 : 0] m_axi_rid
        .m_axi_rdata    ( { xbar_to_gpio_out_axi_rdata   , xbar_to_main_mem_axi_rdata    } ), // input wire [63 : 0] m_axi_rdata
        .m_axi_rresp    ( { xbar_to_gpio_out_axi_rresp   , xbar_to_main_mem_axi_rresp    } ), // input wire [3 : 0] m_axi_rresp
        .m_axi_rlast    ( { xbar_to_gpio_out_axi_rlast   , xbar_to_main_mem_axi_rlast    } ), // input wire [1 : 0] m_axi_rlast
        .m_axi_rvalid   ( { xbar_to_gpio_out_axi_rvalid  , xbar_to_main_mem_axi_rvalid   } ), // input wire [1 : 0] m_axi_rvalid
        .m_axi_rready   ( { xbar_to_gpio_out_axi_rready  , xbar_to_main_mem_axi_rready   } )  // output wire [1 : 0] m_axi_rready
    );
    
    // Main memory
    xlnx_blk_mem_gen main_memory_inst (
        .rsta_busy      ( /* open */                   ), // output wire rsta_busy
        .rstb_busy      ( /* open */                   ), // output wire rstb_busy
        .s_aclk         ( soc_clk                      ), // input wire s_aclk
        .s_aresetn      ( sys_resetn                    ), // input wire s_aresetn
        .s_axi_awid     ( xbar_to_main_mem_axi_awid    ), // input wire [3 : 0] s_axi_awid
        .s_axi_awaddr   ( xbar_to_main_mem_axi_awaddr  ), // input wire [31 : 0] s_axi_awaddr
        .s_axi_awlen    ( xbar_to_main_mem_axi_awlen   ), // input wire [7 : 0] s_axi_awlen
        .s_axi_awsize   ( xbar_to_main_mem_axi_awsize  ), // input wire [2 : 0] s_axi_awsize
        .s_axi_awburst  ( xbar_to_main_mem_axi_awburst ), // input wire [1 : 0] s_axi_awburst
        .s_axi_awvalid  ( xbar_to_main_mem_axi_awvalid ), // input wire s_axi_awvalid
        .s_axi_awready  ( xbar_to_main_mem_axi_awready ), // output wire s_axi_awready
        .s_axi_wdata    ( xbar_to_main_mem_axi_wdata   ), // input wire [31 : 0] s_axi_wdata
        .s_axi_wstrb    ( xbar_to_main_mem_axi_wstrb   ), // input wire [3 : 0] s_axi_wstrb
        .s_axi_wlast    ( xbar_to_main_mem_axi_wlast   ), // input wire s_axi_wlast
        .s_axi_wvalid   ( xbar_to_main_mem_axi_wvalid  ), // input wire s_axi_wvalid
        .s_axi_wready   ( xbar_to_main_mem_axi_wready  ), // output wire s_axi_wready
        .s_axi_bid      ( xbar_to_main_mem_axi_bid     ), // output wire [3 : 0] s_axi_bid
        .s_axi_bresp    ( xbar_to_main_mem_axi_bresp   ), // output wire [1 : 0] s_axi_bresp
        .s_axi_bvalid   ( xbar_to_main_mem_axi_bvalid  ), // output wire s_axi_bvalid
        .s_axi_bready   ( xbar_to_main_mem_axi_bready  ), // input wire s_axi_bready
        .s_axi_arid     ( xbar_to_main_mem_axi_arid    ), // input wire [3 : 0] s_axi_arid
        .s_axi_araddr   ( xbar_to_main_mem_axi_araddr  ), // input wire [31 : 0] s_axi_araddr
        .s_axi_arlen    ( xbar_to_main_mem_axi_arlen   ), // input wire [7 : 0] s_axi_arlen
        .s_axi_arsize   ( xbar_to_main_mem_axi_arsize  ), // input wire [2 : 0] s_axi_arsize
        .s_axi_arburst  ( xbar_to_main_mem_axi_arburst ), // input wire [1 : 0] s_axi_arburst
        .s_axi_arvalid  ( xbar_to_main_mem_axi_arvalid ), // input wire s_axi_arvalid
        .s_axi_arready  ( xbar_to_main_mem_axi_arready ), // output wire s_axi_arready
        .s_axi_rid      ( xbar_to_main_mem_axi_rid     ), // output wire [3 : 0] s_axi_rid
        .s_axi_rdata    ( xbar_to_main_mem_axi_rdata   ), // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp    ( xbar_to_main_mem_axi_rresp   ), // output wire [1 : 0] s_axi_rresp
        .s_axi_rlast    ( xbar_to_main_mem_axi_rlast   ), // output wire s_axi_rlast
        .s_axi_rvalid   ( xbar_to_main_mem_axi_rvalid  ), // output wire s_axi_rvalid
        .s_axi_rready   ( xbar_to_main_mem_axi_rready  )  // input wire s_axi_rready
    );
                                                                                                             
    // GPIOs
    generate
        // GPIO in
        // for ( genvar i = 0; i < NUM_GPIO_IN; i++ ) begin
        //     axi_gpio_in gpio_in_isnt (
        //         .s_axi_aclk     ( s_axi_aclk    ), // input wire s_axi_aclk
        //         .s_axi_aresetn  ( s_axi_aresetn ), // input wire s_axi_aresetn
        //         .s_axi_awaddr   ( s_axi_awaddr  ), // input wire [8 : 0] s_axi_awaddr
        //         .s_axi_awvalid  ( s_axi_awvalid ), // input wire s_axi_awvalid
        //         .s_axi_awready  ( s_axi_awready ), // output wire s_axi_awready
        //         .s_axi_wdata    ( s_axi_wdata   ), // input wire [31 : 0] s_axi_wdata
        //         .s_axi_wstrb    ( s_axi_wstrb   ), // input wire [3 : 0] s_axi_wstrb
        //         .s_axi_wvalid   ( s_axi_wvalid  ), // input wire s_axi_wvalid
        //         .s_axi_wready   ( s_axi_wready  ), // output wire s_axi_wready
        //         .s_axi_bresp    ( s_axi_bresp   ), // output wire [1 : 0] s_axi_bresp
        //         .s_axi_bvalid   ( s_axi_bvalid  ), // output wire s_axi_bvalid
        //         .s_axi_bready   ( s_axi_bready  ), // input wire s_axi_bready
        //         .s_axi_araddr   ( s_axi_araddr  ), // input wire [8 : 0] s_axi_araddr
        //         .s_axi_arvalid  ( s_axi_arvalid ), // input wire s_axi_arvalid
        //         .s_axi_arready  ( s_axi_arready ), // output wire s_axi_arready
        //         .s_axi_rdata    ( s_axi_rdata   ), // output wire [31 : 0] s_axi_rdata
        //         .s_axi_rresp    ( s_axi_rresp   ), // output wire [1 : 0] s_axi_rresp
        //         .s_axi_rvalid   ( s_axi_rvalid  ), // output wire s_axi_rvalid
        //         .s_axi_rready   ( s_axi_rready  ), // input wire s_axi_rready
        //         .gpio_io_i      ( gpio_in [i]   )  // input wire [0 : 0] gpio_io_i
        //     );
        // end

        // GPIO out
        // NOTE: index i starting from 1 is a workaround for axi interconnection
        for ( genvar i = 1; i <= NUM_GPIO_OUT; i++ ) begin  
            // // // axi4_to_axilite to GPIO
            // wire [31 : 0] m_axilite_awaddr;
            // wire [2 : 0] m_axilite_awprot;
            // wire m_axilite_awvalid;
            // wire m_axilite_awready;
            // wire [31 : 0] m_axilite_wdata;
            // wire [3 : 0] m_axilite_wstrb;
            // wire m_axilite_wvalid;
            // wire m_axilite_wready;
            // wire [1 : 0] m_axilite_bresp;
            // wire m_axilite_bvalid;
            // wire m_axilite_bready;
            // wire [31 : 0] m_axilite_araddr;
            // wire [2 : 0] m_axilite_arprot;
            // wire m_axilite_arvalid;
            // wire m_axilite_arready;
            // wire [31 : 0] m_axilite_rdata;
            // wire [1 : 0] m_axilite_rresp;
            // wire m_axilite_rvalid;
            // wire m_axilite_rready;

            // axi4_to_axilite -> gpio_out
            `DEFINE_AXILITE_BUS(gpio_out);

            // AXI4 to AXI4-Lite protocol converter
            xlnx_axi4_to_axilite_converter axi4_to_axilite (
                .aclk           ( soc_clk                       ), // input wire s_axi_aclk
                .aresetn        ( sys_resetn                    ), // input wire s_axi_aresetn
                // AXI4 slave port (from xbar)
                .s_axi_awid     ( xbar_to_gpio_out_axi_awid     ), // input wire [1 : 0] s_axi_awid
                .s_axi_awaddr   ( xbar_to_gpio_out_axi_awaddr   ), // input wire [31 : 0] s_axi_awaddr
                .s_axi_awlen    ( xbar_to_gpio_out_axi_awlen    ), // input wire [7 : 0] s_axi_awlen
                .s_axi_awsize   ( xbar_to_gpio_out_axi_awsize   ), // input wire [2 : 0] s_axi_awsize
                .s_axi_awburst  ( xbar_to_gpio_out_axi_awburst  ), // input wire [1 : 0] s_axi_awburst
                .s_axi_awlock   ( xbar_to_gpio_out_axi_awlock   ), // input wire [0 : 0] s_axi_awlock
                .s_axi_awcache  ( xbar_to_gpio_out_axi_awcache  ), // input wire [3 : 0] s_axi_awcache
                .s_axi_awprot   ( xbar_to_gpio_out_axi_awprot   ), // input wire [2 : 0] s_axi_awprot
                .s_axi_awregion ( xbar_to_gpio_out_axi_awregion ), // input wire [3 : 0] s_axi_awregion
                .s_axi_awqos    ( xbar_to_gpio_out_axi_awqos    ), // input wire [3 : 0] s_axi_awqos
                .s_axi_awvalid  ( xbar_to_gpio_out_axi_awvalid  ), // input wire s_axi_awvalid
                .s_axi_awready  ( xbar_to_gpio_out_axi_awready  ), // output wire s_axi_awready
                .s_axi_wdata    ( xbar_to_gpio_out_axi_wdata    ), // input wire [31 : 0] s_axi_wdata
                .s_axi_wstrb    ( xbar_to_gpio_out_axi_wstrb    ), // input wire [3 : 0] s_axi_wstrb
                .s_axi_wlast    ( xbar_to_gpio_out_axi_wlast    ), // input wire s_axi_wlast
                .s_axi_wvalid   ( xbar_to_gpio_out_axi_wvalid   ), // input wire s_axi_wvalid
                .s_axi_wready   ( xbar_to_gpio_out_axi_wready   ), // output wire s_axi_wready
                .s_axi_bid      ( xbar_to_gpio_out_axi_bid      ), // output wire [1 : 0] s_axi_bid
                .s_axi_bresp    ( xbar_to_gpio_out_axi_bresp    ), // output wire [1 : 0] s_axi_bresp
                .s_axi_bvalid   ( xbar_to_gpio_out_axi_bvalid   ), // output wire s_axi_bvalid
                .s_axi_bready   ( xbar_to_gpio_out_axi_bready   ), // input wire s_axi_bready
                .s_axi_arid     ( xbar_to_gpio_out_axi_arid     ), // input wire [1 : 0] s_axi_arid
                .s_axi_araddr   ( xbar_to_gpio_out_axi_araddr   ), // input wire [31 : 0] s_axi_araddr
                .s_axi_arlen    ( xbar_to_gpio_out_axi_arlen    ), // input wire [7 : 0] s_axi_arlen
                .s_axi_arsize   ( xbar_to_gpio_out_axi_arsize   ), // input wire [2 : 0] s_axi_arsize
                .s_axi_arburst  ( xbar_to_gpio_out_axi_arburst  ), // input wire [1 : 0] s_axi_arburst
                .s_axi_arlock   ( xbar_to_gpio_out_axi_arlock   ), // input wire [0 : 0] s_axi_arlock
                .s_axi_arcache  ( xbar_to_gpio_out_axi_arcache  ), // input wire [3 : 0] s_axi_arcache
                .s_axi_arprot   ( xbar_to_gpio_out_axi_arprot   ), // input wire [2 : 0] s_axi_arprot
                .s_axi_arregion ( xbar_to_gpio_out_axi_arregion ), // input wire [3 : 0] s_axi_arregion
                .s_axi_arqos    ( xbar_to_gpio_out_axi_arqos    ), // input wire [3 : 0] s_axi_arqos
                .s_axi_arvalid  ( xbar_to_gpio_out_axi_arvalid  ), // input wire s_axi_arvalid
                .s_axi_arready  ( xbar_to_gpio_out_axi_arready  ), // output wire s_axi_arready
                .s_axi_rid      ( xbar_to_gpio_out_axi_rid      ), // output wire [1 : 0] s_axi_rid
                .s_axi_rdata    ( xbar_to_gpio_out_axi_rdata    ), // output wire [31 : 0] s_axi_rdata
                .s_axi_rresp    ( xbar_to_gpio_out_axi_rresp    ), // output wire [1 : 0] s_axi_rresp
                .s_axi_rlast    ( xbar_to_gpio_out_axi_rlast    ), // output wire s_axi_rlast
                .s_axi_rvalid   ( xbar_to_gpio_out_axi_rvalid   ), // output wire s_axi_rvalid
                .s_axi_rready   ( xbar_to_gpio_out_axi_rready   ), // input wire s_axi_rready
                // Master port (to GPIO)
                .m_axi_awaddr   ( gpio_out_axilite_awaddr       ), // output wire [31 : 0] m_axi_awaddr
                .m_axi_awprot   ( gpio_out_axilite_awprot       ), // output wire [2 : 0] m_axi_awprot
                .m_axi_awvalid  ( gpio_out_axilite_awvalid      ), // output wire m_axi_awvalid
                .m_axi_awready  ( gpio_out_axilite_awready      ), // input wire m_axi_awready
                .m_axi_wdata    ( gpio_out_axilite_wdata        ), // output wire [31 : 0] m_axi_wdata
                .m_axi_wstrb    ( gpio_out_axilite_wstrb        ), // output wire [3 : 0] m_axi_wstrb
                .m_axi_wvalid   ( gpio_out_axilite_wvalid       ), // output wire m_axi_wvalid
                .m_axi_wready   ( gpio_out_axilite_wready       ), // input wire m_axi_wready
                .m_axi_bresp    ( gpio_out_axilite_bresp        ), // input wire [1 : 0] m_axi_bresp
                .m_axi_bvalid   ( gpio_out_axilite_bvalid       ), // input wire m_axi_bvalid
                .m_axi_bready   ( gpio_out_axilite_bready       ), // output wire m_axi_bready
                .m_axi_araddr   ( gpio_out_axilite_araddr       ), // output wire [31 : 0] m_axi_araddr
                .m_axi_arprot   ( gpio_out_axilite_arprot       ), // output wire [2 : 0] m_axi_arprot
                .m_axi_arvalid  ( gpio_out_axilite_arvalid      ), // output wire m_axi_arvalid
                .m_axi_arready  ( gpio_out_axilite_arready      ), // input wire m_axi_arready
                .m_axi_rdata    ( gpio_out_axilite_rdata        ), // input wire [31 : 0] m_axi_rdata
                .m_axi_rresp    ( gpio_out_axilite_rresp        ), // input wire [1 : 0] m_axi_rresp
                .m_axi_rvalid   ( gpio_out_axilite_rvalid       ), // input wire m_axi_rvalid
                .m_axi_rready   ( gpio_out_axilite_rready       )  // output wire m_axi_rready
            );

            // GPIO instance
            xlnx_axi_gpio_out gpio_out_inst (
                .s_axi_aclk     ( soc_clk                       ), // input wire s_axi_aclk
                .s_axi_aresetn  ( sys_resetn                     ), // input wire s_axi_aresetn
                .s_axi_awaddr   ( gpio_out_axilite_awaddr [8:0] ), // input wire [8 : 0] s_axi_awaddr
                .s_axi_awvalid  ( gpio_out_axilite_awvalid      ), // input wire s_axi_awvalid
                .s_axi_awready  ( gpio_out_axilite_awready      ), // output wire s_axi_awready
                .s_axi_wdata    ( gpio_out_axilite_wdata        ), // input wire [31 : 0] s_axi_wdata
                .s_axi_wstrb    ( gpio_out_axilite_wstrb        ), // input wire [3 : 0] s_axi_wstrb
                .s_axi_wvalid   ( gpio_out_axilite_wvalid       ), // input wire s_axi_wvalid
                .s_axi_wready   ( gpio_out_axilite_wready       ), // output wire s_axi_wready
                .s_axi_bresp    ( gpio_out_axilite_bresp        ), // output wire [1 : 0] s_axi_bresp
                .s_axi_bvalid   ( gpio_out_axilite_bvalid       ), // output wire s_axi_bvalid
                .s_axi_bready   ( gpio_out_axilite_bready       ), // input wire s_axi_bready
                .s_axi_araddr   ( gpio_out_axilite_araddr [8:0] ), // input wire [8 : 0] s_axi_araddr
                .s_axi_arvalid  ( gpio_out_axilite_arvalid      ), // input wire s_axi_arvalid
                .s_axi_arready  ( gpio_out_axilite_arready      ), // output wire s_axi_arready
                .s_axi_rdata    ( gpio_out_axilite_rdata        ), // output wire [31 : 0] s_axi_rdata
                .s_axi_rresp    ( gpio_out_axilite_rresp        ), // output wire [1 : 0] s_axi_rresp
                .s_axi_rvalid   ( gpio_out_axilite_rvalid       ), // output wire s_axi_rvalid
                .s_axi_rready   ( gpio_out_axilite_rready       ), // input wire s_axi_rready
                .gpio_io_o      ( gpio_out_o [0]                )  // input wire [0 : 0] gpio_io_o
            );                                                                                           
        end                                                                                                                                                                            
    endgenerate                                                                                            
                                                                                                                                    
                                                                                                             
endmodule : uninasoc                                                                                         
                                                                                                             
