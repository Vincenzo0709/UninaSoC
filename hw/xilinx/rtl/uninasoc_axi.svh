// Author: Vincenzo Maisto      <vincenzo.maisto2@unina.it>
// Author: Stefano Mercogliano  <stefano.mercogliano@unina.it>
// Author: Manuel Maddaluno     <manuel.maddaluno@unina.it>
// Description: Utility variables and macros for AXI interconnections in UninaSoC
// Note: The main rationale behind this macro is to avoid the usage of structs and
//       macros for the widest possible syntax compatibility.


`ifndef UNINASOC_AXI_SVH__
`define UNINASOC_AXI_SVH__

//////////////////////////////////////////////////////
//    ___                         _                 //
//   | _ \__ _ _ _ __ _ _ __  ___| |_ ___ _ _ ___   //
//   |  _/ _` | '_/ _` | '  \/ -_)  _/ -_) '_(_-<   //
//   |_| \__,_|_| \__,_|_|_|_\___|\__\___|_| /__/   //
//                                                  //
//////////////////////////////////////////////////////

// AXI4 bus parameters
localparam int unsigned AXI_DATA_WIDTH   = 32;
localparam int unsigned AXI_ADDR_WIDTH   = 32;
localparam int unsigned AXI_STRB_WIDTH   = 4;
localparam int unsigned AXI_ID_WIDTH     = 2;
localparam int unsigned AXI_LEN_WIDTH    = 8;
localparam int unsigned AXI_SIZE_WIDTH   = 3;
localparam int unsigned AXI_BURST_WIDTH  = 2;
localparam int unsigned AXI_LOCK_WIDTH   = 1;
localparam int unsigned AXI_CACHE_WIDTH  = 4;
localparam int unsigned AXI_PROT_WIDTH   = 3;
localparam int unsigned AXI_QOS_WIDTH    = 4;
localparam int unsigned AXI_VALID_WIDTH  = 1;
localparam int unsigned AXI_READY_WIDTH  = 1;
localparam int unsigned AXI_LAST_WIDTH   = 1;
localparam int unsigned AXI_RESP_WIDTH   = 2;
localparam int unsigned AXI_REGION_WIDTH = 4;

//////////////////////////////////
//    _____                     //
//   |_   _|  _ _ __  ___ ___   //
//     | || || | '_ \/ -_|_-<   //
//     |_| \_, | .__/\___/__/   //
//         |__/|_|              //
//////////////////////////////////

// AXI signal types
typedef logic [AXI_DATA_WIDTH   -1 : 0] axi_data_t;
typedef logic [AXI_ADDR_WIDTH   -1 : 0] axi_addr_t;
typedef logic [AXI_STRB_WIDTH   -1 : 0] axi_strb_t;
typedef logic [AXI_ID_WIDTH     -1 : 0] axi_id_t;
typedef logic [AXI_LEN_WIDTH    -1 : 0] axi_len_t;
typedef logic [AXI_SIZE_WIDTH   -1 : 0] axi_size_t;
typedef logic [AXI_BURST_WIDTH  -1 : 0] axi_burst_t;
typedef logic [AXI_LOCK_WIDTH   -1 : 0] axi_lock_t;
typedef logic [AXI_CACHE_WIDTH  -1 : 0] axi_cache_t;
typedef logic [AXI_PROT_WIDTH   -1 : 0] axi_prot_t;
typedef logic [AXI_QOS_WIDTH    -1 : 0] axi_qos_t;
typedef logic [AXI_VALID_WIDTH  -1 : 0] axi_valid_t;
typedef logic [AXI_READY_WIDTH  -1 : 0] axi_ready_t;
typedef logic [AXI_LAST_WIDTH   -1 : 0] axi_last_t;
typedef logic [AXI_RESP_WIDTH   -1 : 0] axi_resp_t;
typedef logic [AXI_REGION_WIDTH -1 : 0] axi_region_t;

////////////////////////////////////////
//    __  __   _   ___ ___  ___       //
//   |  \/  | /_\ / __| _ \/ _ \ ___  //
//   | |\/| |/ _ \ (__|   / (_) (_-<  //
//   |_|  |_/_/ \_\___|_|_\\___//__/  //
//                                    //
////////////////////////////////////////

////////////////////////
//  Bus Declaration   //
////////////////////////

// Declare AXI bus specifying the DATA_WIDTH
`define DECLARE_AXI_BUS(bus_name, DATA_WIDTH) \
    // AW channel                                            \
    axi_id_t                      ``bus_name``_axi_awid;     \
    axi_addr_t                    ``bus_name``_axi_awaddr;   \
    axi_len_t                     ``bus_name``_axi_awlen;    \
    axi_size_t                    ``bus_name``_axi_awsize;   \
    axi_burst_t                   ``bus_name``_axi_awburst;  \
    axi_lock_t                    ``bus_name``_axi_awlock;   \
    axi_cache_t                   ``bus_name``_axi_awcache;  \
    axi_prot_t                    ``bus_name``_axi_awprot;   \
    axi_qos_t                     ``bus_name``_axi_awqos;    \
    axi_valid_t                   ``bus_name``_axi_awvalid;  \
    axi_ready_t                   ``bus_name``_axi_awready;  \
    axi_region_t                  ``bus_name``_axi_awregion; \
    // W channel                                             \
    logic [DATA_WIDTH-1 : 0]      ``bus_name``_axi_wdata;    \
    logic [(DATA_WIDTH/8)-1 : 0]  ``bus_name``_axi_wstrb;    \
    axi_last_t                    ``bus_name``_axi_wlast;    \
    axi_valid_t                   ``bus_name``_axi_wvalid;   \
    axi_ready_t                   ``bus_name``_axi_wready;   \
    // B channel                                             \
    axi_id_t                      ``bus_name``_axi_bid;      \
    axi_resp_t                    ``bus_name``_axi_bresp;    \
    axi_valid_t                   ``bus_name``_axi_bvalid;   \
    axi_ready_t                   ``bus_name``_axi_bready;   \
    // AR channel                                            \
    axi_addr_t                    ``bus_name``_axi_araddr;   \
    axi_len_t                     ``bus_name``_axi_arlen;    \
    axi_size_t                    ``bus_name``_axi_arsize;   \
    axi_burst_t                   ``bus_name``_axi_arburst;  \
    axi_lock_t                    ``bus_name``_axi_arlock;   \
    axi_cache_t                   ``bus_name``_axi_arcache;  \
    axi_prot_t                    ``bus_name``_axi_arprot;   \
    axi_qos_t                     ``bus_name``_axi_arqos;    \
    axi_valid_t                   ``bus_name``_axi_arvalid;  \
    axi_ready_t                   ``bus_name``_axi_arready;  \
    axi_id_t                      ``bus_name``_axi_arid;     \
    axi_region_t                  ``bus_name``_axi_arregion; \
    // R channel                                             \
    axi_id_t                      ``bus_name``_axi_rid;      \
    logic [DATA_WIDTH-1 : 0]      ``bus_name``_axi_rdata;    \
    axi_resp_t                    ``bus_name``_axi_rresp;    \
    axi_last_t                    ``bus_name``_axi_rlast;    \
    axi_valid_t                   ``bus_name``_axi_rvalid;   \
    axi_ready_t                   ``bus_name``_axi_rready;

// Single define for whole AXI4-LITE bus
`define DECLARE_AXILITE_BUS(bus_name) \
    // AW channel                               \
    axi_addr_t  ``bus_name``_axilite_awaddr;    \
    axi_prot_t  ``bus_name``_axilite_awprot;    \
    axi_valid_t ``bus_name``_axilite_awvalid;    \
    axi_ready_t ``bus_name``_axilite_awready;   \
    // W channel                                \
    axi_data_t  ``bus_name``_axilite_wdata;     \
    axi_strb_t  ``bus_name``_axilite_wstrb;     \
    axi_valid_t ``bus_name``_axilite_wvalid;    \
    axi_ready_t ``bus_name``_axilite_wready;    \
    // B channel                                \
    axi_resp_t  ``bus_name``_axilite_bresp;     \
    axi_valid_t ``bus_name``_axilite_bvalid;    \
    axi_ready_t ``bus_name``_axilite_bready;    \
    // AR channel                               \
    axi_addr_t  ``bus_name``_axilite_araddr;    \
    axi_prot_t  ``bus_name``_axilite_arprot;    \
    axi_valid_t ``bus_name``_axilite_arvalid;   \
    axi_ready_t ``bus_name``_axilite_arready;   \
    // R channel                                \
    axi_data_t  ``bus_name``_axilite_rdata;     \
    axi_resp_t  ``bus_name``_axilite_rresp;     \
    axi_valid_t ``bus_name``_axilite_rvalid;    \
    axi_ready_t ``bus_name``_axilite_rready;

// Declare AXI array
`define DECLARE_AXI_BUS_ARRAY(array_name, size) \
    axi_id_t     [``size`` -1 : 0] ``array_name``_axi_awid     ; \
    axi_addr_t   [``size`` -1 : 0] ``array_name``_axi_awaddr   ; \
    axi_len_t    [``size`` -1 : 0] ``array_name``_axi_awlen    ; \
    axi_size_t   [``size`` -1 : 0] ``array_name``_axi_awsize   ; \
    axi_burst_t  [``size`` -1 : 0] ``array_name``_axi_awburst  ; \
    axi_lock_t   [``size`` -1 : 0] ``array_name``_axi_awlock   ; \
    axi_cache_t  [``size`` -1 : 0] ``array_name``_axi_awcache  ; \
    axi_prot_t   [``size`` -1 : 0] ``array_name``_axi_awprot   ; \
    axi_qos_t    [``size`` -1 : 0] ``array_name``_axi_awqos    ; \
    axi_valid_t  [``size`` -1 : 0] ``array_name``_axi_awvalid  ; \
    axi_ready_t  [``size`` -1 : 0] ``array_name``_axi_awready  ; \
    axi_region_t [``size`` -1 : 0] ``array_name``_axi_awregion ; \
    axi_data_t   [``size`` -1 : 0] ``array_name``_axi_wdata    ; \
    axi_strb_t   [``size`` -1 : 0] ``array_name``_axi_wstrb    ; \
    axi_last_t   [``size`` -1 : 0] ``array_name``_axi_wlast    ; \
    axi_valid_t  [``size`` -1 : 0] ``array_name``_axi_wvalid   ; \
    axi_ready_t  [``size`` -1 : 0] ``array_name``_axi_wready   ; \
    axi_id_t     [``size`` -1 : 0] ``array_name``_axi_bid      ; \
    axi_resp_t   [``size`` -1 : 0] ``array_name``_axi_bresp    ; \
    axi_valid_t  [``size`` -1 : 0] ``array_name``_axi_bvalid   ; \
    axi_ready_t  [``size`` -1 : 0] ``array_name``_axi_bready   ; \
    axi_addr_t   [``size`` -1 : 0] ``array_name``_axi_araddr   ; \
    axi_len_t    [``size`` -1 : 0] ``array_name``_axi_arlen    ; \
    axi_size_t   [``size`` -1 : 0] ``array_name``_axi_arsize   ; \
    axi_burst_t  [``size`` -1 : 0] ``array_name``_axi_arburst  ; \
    axi_lock_t   [``size`` -1 : 0] ``array_name``_axi_arlock   ; \
    axi_cache_t  [``size`` -1 : 0] ``array_name``_axi_arcache  ; \
    axi_prot_t   [``size`` -1 : 0] ``array_name``_axi_arprot   ; \
    axi_qos_t    [``size`` -1 : 0] ``array_name``_axi_arqos    ; \
    axi_valid_t  [``size`` -1 : 0] ``array_name``_axi_arvalid  ; \
    axi_ready_t  [``size`` -1 : 0] ``array_name``_axi_arready  ; \
    axi_id_t     [``size`` -1 : 0] ``array_name``_axi_arid     ; \
    axi_region_t [``size`` -1 : 0] ``array_name``_axi_arregion ; \
    axi_id_t     [``size`` -1 : 0] ``array_name``_axi_rid      ; \
    axi_data_t   [``size`` -1 : 0] ``array_name``_axi_rdata    ; \
    axi_resp_t   [``size`` -1 : 0] ``array_name``_axi_rresp    ; \
    axi_last_t   [``size`` -1 : 0] ``array_name``_axi_rlast    ; \
    axi_valid_t  [``size`` -1 : 0] ``array_name``_axi_rvalid   ; \
    axi_ready_t  [``size`` -1 : 0] ``array_name``_axi_rready   ;

///////////////////////
//  Bus Assignment   //
///////////////////////

// Assign srce to dest signals
`define ASSIGN_AXI_BUS(dest, src) \
    assign ``dest``_axi_awid     = ``src``_axi_awid      ; \
    assign ``dest``_axi_awaddr   = ``src``_axi_awaddr    ; \
    assign ``dest``_axi_awlen    = ``src``_axi_awlen     ; \
    assign ``dest``_axi_awsize   = ``src``_axi_awsize    ; \
    assign ``dest``_axi_awburst  = ``src``_axi_awburst   ; \
    assign ``dest``_axi_awlock   = ``src``_axi_awlock    ; \
    assign ``dest``_axi_awcache  = ``src``_axi_awcache   ; \
    assign ``dest``_axi_awprot   = ``src``_axi_awprot    ; \
    assign ``dest``_axi_awqos    = ``src``_axi_awqos     ; \
    assign ``dest``_axi_awvalid  = ``src``_axi_awvalid   ; \
    assign ``dest``_axi_awregion = ``src``_axi_awregion  ; \
    assign ``dest``_axi_wdata    = ``src``_axi_wdata     ; \
    assign ``dest``_axi_wstrb    = ``src``_axi_wstrb     ; \
    assign ``dest``_axi_wlast    = ``src``_axi_wlast     ; \
    assign ``dest``_axi_wvalid   = ``src``_axi_wvalid    ; \
    assign ``dest``_axi_araddr   = ``src``_axi_araddr    ; \
    assign ``dest``_axi_arlen    = ``src``_axi_arlen     ; \
    assign ``dest``_axi_arsize   = ``src``_axi_arsize    ; \
    assign ``dest``_axi_arburst  = ``src``_axi_arburst   ; \
    assign ``dest``_axi_arlock   = ``src``_axi_arlock    ; \
    assign ``dest``_axi_arcache  = ``src``_axi_arcache   ; \
    assign ``dest``_axi_arprot   = ``src``_axi_arprot    ; \
    assign ``dest``_axi_arqos    = ``src``_axi_arqos     ; \
    assign ``dest``_axi_arvalid  = ``src``_axi_arvalid   ; \
    assign ``dest``_axi_arid     = ``src``_axi_arid      ; \
    assign ``dest``_axi_arregion = ``src``_axi_arregion  ; \
    assign ``dest``_axi_rready   = ``src``_axi_rready    ; \
    assign ``dest``_axi_bready   = ``src``_axi_bready    ; \
    assign ``src``_axi_awready   = ``dest``_axi_awready  ; \
    assign ``src``_axi_wready    = ``dest``_axi_wready   ; \
    assign ``src``_axi_bid       = ``dest``_axi_bid      ; \
    assign ``src``_axi_bresp     = ``dest``_axi_bresp    ; \
    assign ``src``_axi_bvalid    = ``dest``_axi_bvalid   ; \
    assign ``src``_axi_arready   = ``dest``_axi_arready  ; \
    assign ``src``_axi_rid       = ``dest``_axi_rid      ; \
    assign ``src``_axi_rdata     = ``dest``_axi_rdata    ; \
    assign ``src``_axi_rresp     = ``dest``_axi_rresp    ; \
    assign ``src``_axi_rlast     = ``dest``_axi_rlast    ; \
    assign ``src``_axi_rvalid    = ``dest``_axi_rvalid   ;

////////////////////////
//  Bus Concatenation //
////////////////////////

// NOTE: these macro are just enumerating, without variadic args
//       I don't see a better way to do this, for now

// Mock macro for one bus for compatibility
// Effectively, just renaming the signals
`define CONCAT_AXI_MASTERS_ARRAY1(array_name, bus_name0) \
    `ASSIGN_AXI_BUS(``array_name``, ``bus_name0``)

`define CONCAT_AXI_SLAVES_ARRAY1(array_name, bus_name0) \
    `ASSIGN_AXI_BUS(``bus_name0``, ``array_name``)

// Concatenate 2 master buses
`define CONCAT_AXI_MASTERS_ARRAY2(array_name, bus_name1, bus_name0) \
    assign ``array_name``_axi_awid     = {``bus_name1``_axi_awid       , ``bus_name0``_axi_awid     }; \
    assign ``array_name``_axi_awaddr   = {``bus_name1``_axi_awaddr     , ``bus_name0``_axi_awaddr   }; \
    assign ``array_name``_axi_awlen    = {``bus_name1``_axi_awlen      , ``bus_name0``_axi_awlen    }; \
    assign ``array_name``_axi_awsize   = {``bus_name1``_axi_awsize     , ``bus_name0``_axi_awsize   }; \
    assign ``array_name``_axi_awburst  = {``bus_name1``_axi_awburst    , ``bus_name0``_axi_awburst  }; \
    assign ``array_name``_axi_awlock   = {``bus_name1``_axi_awlock     , ``bus_name0``_axi_awlock   }; \
    assign ``array_name``_axi_awcache  = {``bus_name1``_axi_awcache    , ``bus_name0``_axi_awcache  }; \
    assign ``array_name``_axi_awprot   = {``bus_name1``_axi_awprot     , ``bus_name0``_axi_awprot   }; \
    assign ``array_name``_axi_awqos    = {``bus_name1``_axi_awqos      , ``bus_name0``_axi_awqos    }; \
    assign ``array_name``_axi_awvalid  = {``bus_name1``_axi_awvalid    , ``bus_name0``_axi_awvalid  }; \
    assign ``array_name``_axi_awregion = {``bus_name1``_axi_awregion   , ``bus_name0``_axi_awregion }; \
    assign ``array_name``_axi_wdata    = {``bus_name1``_axi_wdata      , ``bus_name0``_axi_wdata    }; \
    assign ``array_name``_axi_wstrb    = {``bus_name1``_axi_wstrb      , ``bus_name0``_axi_wstrb    }; \
    assign ``array_name``_axi_wlast    = {``bus_name1``_axi_wlast      , ``bus_name0``_axi_wlast    }; \
    assign ``array_name``_axi_wvalid   = {``bus_name1``_axi_wvalid     , ``bus_name0``_axi_wvalid   }; \
    assign ``array_name``_axi_bready   = {``bus_name1``_axi_bready     , ``bus_name0``_axi_bready   }; \
    assign ``array_name``_axi_araddr   = {``bus_name1``_axi_araddr     , ``bus_name0``_axi_araddr   }; \
    assign ``array_name``_axi_arlen    = {``bus_name1``_axi_arlen      , ``bus_name0``_axi_arlen    }; \
    assign ``array_name``_axi_arsize   = {``bus_name1``_axi_arsize     , ``bus_name0``_axi_arsize   }; \
    assign ``array_name``_axi_arburst  = {``bus_name1``_axi_arburst    , ``bus_name0``_axi_arburst  }; \
    assign ``array_name``_axi_arlock   = {``bus_name1``_axi_arlock     , ``bus_name0``_axi_arlock   }; \
    assign ``array_name``_axi_arcache  = {``bus_name1``_axi_arcache    , ``bus_name0``_axi_arcache  }; \
    assign ``array_name``_axi_arprot   = {``bus_name1``_axi_arprot     , ``bus_name0``_axi_arprot   }; \
    assign ``array_name``_axi_arqos    = {``bus_name1``_axi_arqos      , ``bus_name0``_axi_arqos    }; \
    assign ``array_name``_axi_arvalid  = {``bus_name1``_axi_arvalid    , ``bus_name0``_axi_arvalid  }; \
    assign ``array_name``_axi_arid     = {``bus_name1``_axi_arid       , ``bus_name0``_axi_arid     }; \
    assign ``array_name``_axi_arregion = {``bus_name1``_axi_arregion   , ``bus_name0``_axi_arregion }; \
    assign ``array_name``_axi_rready   = {``bus_name1``_axi_rready     , ``bus_name0``_axi_rready   }; \
    assign {``bus_name1``_axi_awready    , ``bus_name0``_axi_awready  } = ``array_name``_axi_awready ; \
    assign {``bus_name1``_axi_wready     , ``bus_name0``_axi_wready   } = ``array_name``_axi_wready  ; \
    assign {``bus_name1``_axi_bid        , ``bus_name0``_axi_bid      } = ``array_name``_axi_bid     ; \
    assign {``bus_name1``_axi_bresp      , ``bus_name0``_axi_bresp    } = ``array_name``_axi_bresp   ; \
    assign {``bus_name1``_axi_bvalid     , ``bus_name0``_axi_bvalid   } = ``array_name``_axi_bvalid  ; \
    assign {``bus_name1``_axi_arready    , ``bus_name0``_axi_arready  } = ``array_name``_axi_arready ; \
    assign {``bus_name1``_axi_rid        , ``bus_name0``_axi_rid      } = ``array_name``_axi_rid     ; \
    assign {``bus_name1``_axi_rdata      , ``bus_name0``_axi_rdata    } = ``array_name``_axi_rdata   ; \
    assign {``bus_name1``_axi_rresp      , ``bus_name0``_axi_rresp    } = ``array_name``_axi_rresp   ; \
    assign {``bus_name1``_axi_rlast      , ``bus_name0``_axi_rlast    } = ``array_name``_axi_rlast   ; \
    assign {``bus_name1``_axi_rvalid     , ``bus_name0``_axi_rvalid   } = ``array_name``_axi_rvalid  ;

// Concatenate 2 slave buses
`define CONCAT_AXI_SLAVES_ARRAY2(array_name, bus_name1, bus_name0) \
    assign {``bus_name1``_axi_awid       , ``bus_name0``_axi_awid     } = ``array_name``_axi_awid    ; \
    assign {``bus_name1``_axi_awaddr     , ``bus_name0``_axi_awaddr   } = ``array_name``_axi_awaddr  ; \
    assign {``bus_name1``_axi_awlen      , ``bus_name0``_axi_awlen    } = ``array_name``_axi_awlen   ; \
    assign {``bus_name1``_axi_awsize     , ``bus_name0``_axi_awsize   } = ``array_name``_axi_awsize  ; \
    assign {``bus_name1``_axi_awburst    , ``bus_name0``_axi_awburst  } = ``array_name``_axi_awburst ; \
    assign {``bus_name1``_axi_awlock     , ``bus_name0``_axi_awlock   } = ``array_name``_axi_awlock  ; \
    assign {``bus_name1``_axi_awcache    , ``bus_name0``_axi_awcache  } = ``array_name``_axi_awcache ; \
    assign {``bus_name1``_axi_awprot     , ``bus_name0``_axi_awprot   } = ``array_name``_axi_awprot  ; \
    assign {``bus_name1``_axi_awqos      , ``bus_name0``_axi_awqos    } = ``array_name``_axi_awqos   ; \
    assign {``bus_name1``_axi_awvalid    , ``bus_name0``_axi_awvalid  } = ``array_name``_axi_awvalid ; \
    assign {``bus_name1``_axi_awregion   , ``bus_name0``_axi_awregion } = ``array_name``_axi_awregion; \
    assign {``bus_name1``_axi_wdata      , ``bus_name0``_axi_wdata    } = ``array_name``_axi_wdata   ; \
    assign {``bus_name1``_axi_wstrb      , ``bus_name0``_axi_wstrb    } = ``array_name``_axi_wstrb   ; \
    assign {``bus_name1``_axi_wlast      , ``bus_name0``_axi_wlast    } = ``array_name``_axi_wlast   ; \
    assign {``bus_name1``_axi_wvalid     , ``bus_name0``_axi_wvalid   } = ``array_name``_axi_wvalid  ; \
    assign {``bus_name1``_axi_bready     , ``bus_name0``_axi_bready   } = ``array_name``_axi_bready  ; \
    assign {``bus_name1``_axi_araddr     , ``bus_name0``_axi_araddr   } = ``array_name``_axi_araddr  ; \
    assign {``bus_name1``_axi_arlen      , ``bus_name0``_axi_arlen    } = ``array_name``_axi_arlen   ; \
    assign {``bus_name1``_axi_arsize     , ``bus_name0``_axi_arsize   } = ``array_name``_axi_arsize  ; \
    assign {``bus_name1``_axi_arburst    , ``bus_name0``_axi_arburst  } = ``array_name``_axi_arburst ; \
    assign {``bus_name1``_axi_arlock     , ``bus_name0``_axi_arlock   } = ``array_name``_axi_arlock  ; \
    assign {``bus_name1``_axi_arcache    , ``bus_name0``_axi_arcache  } = ``array_name``_axi_arcache ; \
    assign {``bus_name1``_axi_arprot     , ``bus_name0``_axi_arprot   } = ``array_name``_axi_arprot  ; \
    assign {``bus_name1``_axi_arqos      , ``bus_name0``_axi_arqos    } = ``array_name``_axi_arqos   ; \
    assign {``bus_name1``_axi_arvalid    , ``bus_name0``_axi_arvalid  } = ``array_name``_axi_arvalid ; \
    assign {``bus_name1``_axi_arid       , ``bus_name0``_axi_arid     } = ``array_name``_axi_arid    ; \
    assign {``bus_name1``_axi_arregion   , ``bus_name0``_axi_arregion } = ``array_name``_axi_arregion; \
    assign {``bus_name1``_axi_rready     , ``bus_name0``_axi_rready   } = ``array_name``_axi_rready  ; \
    assign ``array_name``_axi_awready = {``bus_name1``_axi_awready    , ``bus_name0``_axi_awready  }; \
    assign ``array_name``_axi_wready  = {``bus_name1``_axi_wready     , ``bus_name0``_axi_wready   }; \
    assign ``array_name``_axi_bid     = {``bus_name1``_axi_bid        , ``bus_name0``_axi_bid      }; \
    assign ``array_name``_axi_bresp   = {``bus_name1``_axi_bresp      , ``bus_name0``_axi_bresp    }; \
    assign ``array_name``_axi_bvalid  = {``bus_name1``_axi_bvalid     , ``bus_name0``_axi_bvalid   }; \
    assign ``array_name``_axi_arready = {``bus_name1``_axi_arready    , ``bus_name0``_axi_arready  }; \
    assign ``array_name``_axi_rid     = {``bus_name1``_axi_rid        , ``bus_name0``_axi_rid      }; \
    assign ``array_name``_axi_rdata   = {``bus_name1``_axi_rdata      , ``bus_name0``_axi_rdata    }; \
    assign ``array_name``_axi_rresp   = {``bus_name1``_axi_rresp      , ``bus_name0``_axi_rresp    }; \
    assign ``array_name``_axi_rlast   = {``bus_name1``_axi_rlast      , ``bus_name0``_axi_rlast    }; \
    assign ``array_name``_axi_rvalid  = {``bus_name1``_axi_rvalid     , ``bus_name0``_axi_rvalid   };

// Concatenate 3 master buses
`define CONCAT_AXI_MASTERS_ARRAY3(array_name, bus_name2, bus_name1, bus_name0) \
    assign ``array_name``_axi_awid     = {``bus_name2``_axi_awid      , ``bus_name1``_axi_awid      , ``bus_name0``_axi_awid     }; \
    assign ``array_name``_axi_awaddr   = {``bus_name2``_axi_awaddr    , ``bus_name1``_axi_awaddr    , ``bus_name0``_axi_awaddr   }; \
    assign ``array_name``_axi_awlen    = {``bus_name2``_axi_awlen     , ``bus_name1``_axi_awlen     , ``bus_name0``_axi_awlen    }; \
    assign ``array_name``_axi_awsize   = {``bus_name2``_axi_awsize    , ``bus_name1``_axi_awsize    , ``bus_name0``_axi_awsize   }; \
    assign ``array_name``_axi_awburst  = {``bus_name2``_axi_awburst   , ``bus_name1``_axi_awburst   , ``bus_name0``_axi_awburst  }; \
    assign ``array_name``_axi_awlock   = {``bus_name2``_axi_awlock    , ``bus_name1``_axi_awlock    , ``bus_name0``_axi_awlock   }; \
    assign ``array_name``_axi_awcache  = {``bus_name2``_axi_awcache   , ``bus_name1``_axi_awcache   , ``bus_name0``_axi_awcache  }; \
    assign ``array_name``_axi_awprot   = {``bus_name2``_axi_awprot    , ``bus_name1``_axi_awprot    , ``bus_name0``_axi_awprot   }; \
    assign ``array_name``_axi_awqos    = {``bus_name2``_axi_awqos     , ``bus_name1``_axi_awqos     , ``bus_name0``_axi_awqos    }; \
    assign ``array_name``_axi_awvalid  = {``bus_name2``_axi_awvalid   , ``bus_name1``_axi_awvalid   , ``bus_name0``_axi_awvalid  }; \
    assign ``array_name``_axi_awregion = {``bus_name2``_axi_awregion  , ``bus_name1``_axi_awregion  , ``bus_name0``_axi_awregion }; \
    assign ``array_name``_axi_wdata    = {``bus_name2``_axi_wdata     , ``bus_name1``_axi_wdata     , ``bus_name0``_axi_wdata    }; \
    assign ``array_name``_axi_wstrb    = {``bus_name2``_axi_wstrb     , ``bus_name1``_axi_wstrb     , ``bus_name0``_axi_wstrb    }; \
    assign ``array_name``_axi_wlast    = {``bus_name2``_axi_wlast     , ``bus_name1``_axi_wlast     , ``bus_name0``_axi_wlast    }; \
    assign ``array_name``_axi_wvalid   = {``bus_name2``_axi_wvalid    , ``bus_name1``_axi_wvalid    , ``bus_name0``_axi_wvalid   }; \
    assign ``array_name``_axi_bready   = {``bus_name2``_axi_bready    , ``bus_name1``_axi_bready    , ``bus_name0``_axi_bready   }; \
    assign ``array_name``_axi_araddr   = {``bus_name2``_axi_araddr    , ``bus_name1``_axi_araddr    , ``bus_name0``_axi_araddr   }; \
    assign ``array_name``_axi_arlen    = {``bus_name2``_axi_arlen     , ``bus_name1``_axi_arlen     , ``bus_name0``_axi_arlen    }; \
    assign ``array_name``_axi_arsize   = {``bus_name2``_axi_arsize    , ``bus_name1``_axi_arsize    , ``bus_name0``_axi_arsize   }; \
    assign ``array_name``_axi_arburst  = {``bus_name2``_axi_arburst   , ``bus_name1``_axi_arburst   , ``bus_name0``_axi_arburst  }; \
    assign ``array_name``_axi_arlock   = {``bus_name2``_axi_arlock    , ``bus_name1``_axi_arlock    , ``bus_name0``_axi_arlock   }; \
    assign ``array_name``_axi_arcache  = {``bus_name2``_axi_arcache   , ``bus_name1``_axi_arcache   , ``bus_name0``_axi_arcache  }; \
    assign ``array_name``_axi_arprot   = {``bus_name2``_axi_arprot    , ``bus_name1``_axi_arprot    , ``bus_name0``_axi_arprot   }; \
    assign ``array_name``_axi_arqos    = {``bus_name2``_axi_arqos     , ``bus_name1``_axi_arqos     , ``bus_name0``_axi_arqos    }; \
    assign ``array_name``_axi_arvalid  = {``bus_name2``_axi_arvalid   , ``bus_name1``_axi_arvalid   , ``bus_name0``_axi_arvalid  }; \
    assign ``array_name``_axi_arid     = {``bus_name2``_axi_arid      , ``bus_name1``_axi_arid      , ``bus_name0``_axi_arid     }; \
    assign ``array_name``_axi_arregion = {``bus_name2``_axi_arregion  , ``bus_name1``_axi_arregion  , ``bus_name0``_axi_arregion }; \
    assign ``array_name``_axi_rready   = {``bus_name2``_axi_rready    , ``bus_name1``_axi_rready    , ``bus_name0``_axi_rready   }; \
    assign {``bus_name2``_axi_awready    , ``bus_name1``_axi_awready   , ``bus_name0``_axi_awready  } = ``array_name``_axi_awready ; \
    assign {``bus_name2``_axi_wready     , ``bus_name1``_axi_wready    , ``bus_name0``_axi_wready   } = ``array_name``_axi_wready  ; \
    assign {``bus_name2``_axi_bid        , ``bus_name1``_axi_bid       , ``bus_name0``_axi_bid      } = ``array_name``_axi_bid     ; \
    assign {``bus_name2``_axi_bresp      , ``bus_name1``_axi_bresp     , ``bus_name0``_axi_bresp    } = ``array_name``_axi_bresp   ; \
    assign {``bus_name2``_axi_bvalid     , ``bus_name1``_axi_bvalid    , ``bus_name0``_axi_bvalid   } = ``array_name``_axi_bvalid  ; \
    assign {``bus_name2``_axi_arready    , ``bus_name1``_axi_arready   , ``bus_name0``_axi_arready  } = ``array_name``_axi_arready ; \
    assign {``bus_name2``_axi_rid        , ``bus_name1``_axi_rid       , ``bus_name0``_axi_rid      } = ``array_name``_axi_rid     ; \
    assign {``bus_name2``_axi_rdata      , ``bus_name1``_axi_rdata     , ``bus_name0``_axi_rdata    } = ``array_name``_axi_rdata   ; \
    assign {``bus_name2``_axi_rresp      , ``bus_name1``_axi_rresp     , ``bus_name0``_axi_rresp    } = ``array_name``_axi_rresp   ; \
    assign {``bus_name2``_axi_rlast      , ``bus_name1``_axi_rlast     , ``bus_name0``_axi_rlast    } = ``array_name``_axi_rlast   ; \
    assign {``bus_name2``_axi_rvalid     , ``bus_name1``_axi_rvalid    , ``bus_name0``_axi_rvalid   } = ``array_name``_axi_rvalid  ;

// Concatenate 3 slave buses
`define CONCAT_AXI_SLAVES_ARRAY3(array_name, bus_name2, bus_name1, bus_name0) \
    assign {``bus_name2``_axi_awid       , ``bus_name1``_axi_awid       , ``bus_name0``_axi_awid     } = ``array_name``_axi_awid    ; \
    assign {``bus_name2``_axi_awaddr     , ``bus_name1``_axi_awaddr     , ``bus_name0``_axi_awaddr   } = ``array_name``_axi_awaddr  ; \
    assign {``bus_name2``_axi_awlen      , ``bus_name1``_axi_awlen      , ``bus_name0``_axi_awlen    } = ``array_name``_axi_awlen   ; \
    assign {``bus_name2``_axi_awsize     , ``bus_name1``_axi_awsize     , ``bus_name0``_axi_awsize   } = ``array_name``_axi_awsize  ; \
    assign {``bus_name2``_axi_awburst    , ``bus_name1``_axi_awburst    , ``bus_name0``_axi_awburst  } = ``array_name``_axi_awburst ; \
    assign {``bus_name2``_axi_awlock     , ``bus_name1``_axi_awlock     , ``bus_name0``_axi_awlock   } = ``array_name``_axi_awlock  ; \
    assign {``bus_name2``_axi_awcache    , ``bus_name1``_axi_awcache    , ``bus_name0``_axi_awcache  } = ``array_name``_axi_awcache ; \
    assign {``bus_name2``_axi_awprot     , ``bus_name1``_axi_awprot     , ``bus_name0``_axi_awprot   } = ``array_name``_axi_awprot  ; \
    assign {``bus_name2``_axi_awqos      , ``bus_name1``_axi_awqos      , ``bus_name0``_axi_awqos    } = ``array_name``_axi_awqos   ; \
    assign {``bus_name2``_axi_awvalid    , ``bus_name1``_axi_awvalid    , ``bus_name0``_axi_awvalid  } = ``array_name``_axi_awvalid ; \
    assign {``bus_name2``_axi_awregion   , ``bus_name1``_axi_awregion   , ``bus_name0``_axi_awregion } = ``array_name``_axi_awregion; \
    assign {``bus_name2``_axi_wdata      , ``bus_name1``_axi_wdata      , ``bus_name0``_axi_wdata    } = ``array_name``_axi_wdata   ; \
    assign {``bus_name2``_axi_wstrb      , ``bus_name1``_axi_wstrb      , ``bus_name0``_axi_wstrb    } = ``array_name``_axi_wstrb   ; \
    assign {``bus_name2``_axi_wlast      , ``bus_name1``_axi_wlast      , ``bus_name0``_axi_wlast    } = ``array_name``_axi_wlast   ; \
    assign {``bus_name2``_axi_wvalid     , ``bus_name1``_axi_wvalid     , ``bus_name0``_axi_wvalid   } = ``array_name``_axi_wvalid  ; \
    assign {``bus_name2``_axi_bready     , ``bus_name1``_axi_bready     , ``bus_name0``_axi_bready   } = ``array_name``_axi_bready  ; \
    assign {``bus_name2``_axi_araddr     , ``bus_name1``_axi_araddr     , ``bus_name0``_axi_araddr   } = ``array_name``_axi_araddr  ; \
    assign {``bus_name2``_axi_arlen      , ``bus_name1``_axi_arlen      , ``bus_name0``_axi_arlen    } = ``array_name``_axi_arlen   ; \
    assign {``bus_name2``_axi_arsize     , ``bus_name1``_axi_arsize     , ``bus_name0``_axi_arsize   } = ``array_name``_axi_arsize  ; \
    assign {``bus_name2``_axi_arburst    , ``bus_name1``_axi_arburst    , ``bus_name0``_axi_arburst  } = ``array_name``_axi_arburst ; \
    assign {``bus_name2``_axi_arlock     , ``bus_name1``_axi_arlock     , ``bus_name0``_axi_arlock   } = ``array_name``_axi_arlock  ; \
    assign {``bus_name2``_axi_arcache    , ``bus_name1``_axi_arcache    , ``bus_name0``_axi_arcache  } = ``array_name``_axi_arcache ; \
    assign {``bus_name2``_axi_arprot     , ``bus_name1``_axi_arprot     , ``bus_name0``_axi_arprot   } = ``array_name``_axi_arprot  ; \
    assign {``bus_name2``_axi_arqos      , ``bus_name1``_axi_arqos      , ``bus_name0``_axi_arqos    } = ``array_name``_axi_arqos   ; \
    assign {``bus_name2``_axi_arvalid    , ``bus_name1``_axi_arvalid    , ``bus_name0``_axi_arvalid  } = ``array_name``_axi_arvalid ; \
    assign {``bus_name2``_axi_arid       , ``bus_name1``_axi_arid       , ``bus_name0``_axi_arid     } = ``array_name``_axi_arid    ; \
    assign {``bus_name2``_axi_arregion   , ``bus_name1``_axi_arregion   , ``bus_name0``_axi_arregion } = ``array_name``_axi_arregion; \
    assign {``bus_name2``_axi_rready     , ``bus_name1``_axi_rready     , ``bus_name0``_axi_rready   } = ``array_name``_axi_rready  ; \
    assign ``array_name``_axi_awready = {``bus_name2``_axi_awready    , ``bus_name1``_axi_awready    , ``bus_name0``_axi_awready  }; \
    assign ``array_name``_axi_wready  = {``bus_name2``_axi_wready     , ``bus_name1``_axi_wready     , ``bus_name0``_axi_wready   }; \
    assign ``array_name``_axi_bid     = {``bus_name2``_axi_bid        , ``bus_name1``_axi_bid        , ``bus_name0``_axi_bid      }; \
    assign ``array_name``_axi_bresp   = {``bus_name2``_axi_bresp      , ``bus_name1``_axi_bresp      , ``bus_name0``_axi_bresp    }; \
    assign ``array_name``_axi_bvalid  = {``bus_name2``_axi_bvalid     , ``bus_name1``_axi_bvalid     , ``bus_name0``_axi_bvalid   }; \
    assign ``array_name``_axi_arready = {``bus_name2``_axi_arready    , ``bus_name1``_axi_arready    , ``bus_name0``_axi_arready  }; \
    assign ``array_name``_axi_rid     = {``bus_name2``_axi_rid        , ``bus_name1``_axi_rid        , ``bus_name0``_axi_rid      }; \
    assign ``array_name``_axi_rdata   = {``bus_name2``_axi_rdata      , ``bus_name1``_axi_rdata      , ``bus_name0``_axi_rdata    }; \
    assign ``array_name``_axi_rresp   = {``bus_name2``_axi_rresp      , ``bus_name1``_axi_rresp      , ``bus_name0``_axi_rresp    }; \
    assign ``array_name``_axi_rlast   = {``bus_name2``_axi_rlast      , ``bus_name1``_axi_rlast      , ``bus_name0``_axi_rlast    }; \
    assign ``array_name``_axi_rvalid  = {``bus_name2``_axi_rvalid     , ``bus_name1``_axi_rvalid     , ``bus_name0``_axi_rvalid   };

// Concatenate 4 master buses
`define CONCAT_AXI_MASTERS_ARRAY4(array_name, bus_name3, bus_name2, bus_name1, bus_name0) \
    assign ``array_name``_axi_awid     = {``bus_name3``_axi_awid      , ``bus_name2``_axi_awid      , ``bus_name1``_axi_awid      , ``bus_name0``_axi_awid     }; \
    assign ``array_name``_axi_awaddr   = {``bus_name3``_axi_awaddr    , ``bus_name2``_axi_awaddr    , ``bus_name1``_axi_awaddr    , ``bus_name0``_axi_awaddr   }; \
    assign ``array_name``_axi_awlen    = {``bus_name3``_axi_awlen     , ``bus_name2``_axi_awlen     , ``bus_name1``_axi_awlen     , ``bus_name0``_axi_awlen    }; \
    assign ``array_name``_axi_awsize   = {``bus_name3``_axi_awsize    , ``bus_name2``_axi_awsize    , ``bus_name1``_axi_awsize    , ``bus_name0``_axi_awsize   }; \
    assign ``array_name``_axi_awburst  = {``bus_name3``_axi_awburst   , ``bus_name2``_axi_awburst   , ``bus_name1``_axi_awburst   , ``bus_name0``_axi_awburst  }; \
    assign ``array_name``_axi_awlock   = {``bus_name3``_axi_awlock    , ``bus_name2``_axi_awlock    , ``bus_name1``_axi_awlock    , ``bus_name0``_axi_awlock   }; \
    assign ``array_name``_axi_awcache  = {``bus_name3``_axi_awcache   , ``bus_name2``_axi_awcache   , ``bus_name1``_axi_awcache   , ``bus_name0``_axi_awcache  }; \
    assign ``array_name``_axi_awprot   = {``bus_name3``_axi_awprot    , ``bus_name2``_axi_awprot    , ``bus_name1``_axi_awprot    , ``bus_name0``_axi_awprot   }; \
    assign ``array_name``_axi_awqos    = {``bus_name3``_axi_awqos     , ``bus_name2``_axi_awqos     , ``bus_name1``_axi_awqos     , ``bus_name0``_axi_awqos    }; \
    assign ``array_name``_axi_awvalid  = {``bus_name3``_axi_awvalid   , ``bus_name2``_axi_awvalid   , ``bus_name1``_axi_awvalid   , ``bus_name0``_axi_awvalid  }; \
    assign ``array_name``_axi_awregion = {``bus_name3``_axi_awregion  , ``bus_name2``_axi_awregion  , ``bus_name1``_axi_awregion  , ``bus_name0``_axi_awregion }; \
    assign ``array_name``_axi_wdata    = {``bus_name3``_axi_wdata     , ``bus_name2``_axi_wdata     , ``bus_name1``_axi_wdata     , ``bus_name0``_axi_wdata    }; \
    assign ``array_name``_axi_wstrb    = {``bus_name3``_axi_wstrb     , ``bus_name2``_axi_wstrb     , ``bus_name1``_axi_wstrb     , ``bus_name0``_axi_wstrb    }; \
    assign ``array_name``_axi_wlast    = {``bus_name3``_axi_wlast     , ``bus_name2``_axi_wlast     , ``bus_name1``_axi_wlast     , ``bus_name0``_axi_wlast    }; \
    assign ``array_name``_axi_wvalid   = {``bus_name3``_axi_wvalid    , ``bus_name2``_axi_wvalid    , ``bus_name1``_axi_wvalid    , ``bus_name0``_axi_wvalid   }; \
    assign ``array_name``_axi_bready   = {``bus_name3``_axi_bready    , ``bus_name2``_axi_bready    , ``bus_name1``_axi_bready    , ``bus_name0``_axi_bready   }; \
    assign ``array_name``_axi_araddr   = {``bus_name3``_axi_araddr    , ``bus_name2``_axi_araddr    , ``bus_name1``_axi_araddr    , ``bus_name0``_axi_araddr   }; \
    assign ``array_name``_axi_arlen    = {``bus_name3``_axi_arlen     , ``bus_name2``_axi_arlen     , ``bus_name1``_axi_arlen     , ``bus_name0``_axi_arlen    }; \
    assign ``array_name``_axi_arsize   = {``bus_name3``_axi_arsize    , ``bus_name2``_axi_arsize    , ``bus_name1``_axi_arsize    , ``bus_name0``_axi_arsize   }; \
    assign ``array_name``_axi_arburst  = {``bus_name3``_axi_arburst   , ``bus_name2``_axi_arburst   , ``bus_name1``_axi_arburst   , ``bus_name0``_axi_arburst  }; \
    assign ``array_name``_axi_arlock   = {``bus_name3``_axi_arlock    , ``bus_name2``_axi_arlock    , ``bus_name1``_axi_arlock    , ``bus_name0``_axi_arlock   }; \
    assign ``array_name``_axi_arcache  = {``bus_name3``_axi_arcache   , ``bus_name2``_axi_arcache   , ``bus_name1``_axi_arcache   , ``bus_name0``_axi_arcache  }; \
    assign ``array_name``_axi_arprot   = {``bus_name3``_axi_arprot    , ``bus_name2``_axi_arprot    , ``bus_name1``_axi_arprot    , ``bus_name0``_axi_arprot   }; \
    assign ``array_name``_axi_arqos    = {``bus_name3``_axi_arqos     , ``bus_name2``_axi_arqos     , ``bus_name1``_axi_arqos     , ``bus_name0``_axi_arqos    }; \
    assign ``array_name``_axi_arvalid  = {``bus_name3``_axi_arvalid   , ``bus_name2``_axi_arvalid   , ``bus_name1``_axi_arvalid   , ``bus_name0``_axi_arvalid  }; \
    assign ``array_name``_axi_arid     = {``bus_name3``_axi_arid      , ``bus_name2``_axi_arid      , ``bus_name1``_axi_arid      , ``bus_name0``_axi_arid     }; \
    assign ``array_name``_axi_arregion = {``bus_name3``_axi_arregion  , ``bus_name2``_axi_arregion  , ``bus_name1``_axi_arregion  , ``bus_name0``_axi_arregion }; \
    assign ``array_name``_axi_rready   = {``bus_name3``_axi_rready    , ``bus_name2``_axi_rready    , ``bus_name1``_axi_rready    , ``bus_name0``_axi_rready   }; \
    assign {``bus_name3``_axi_awready    , ``bus_name2``_axi_awready    , ``bus_name1``_axi_awready   , ``bus_name0``_axi_awready  } = ``array_name``_axi_awready ; \
    assign {``bus_name3``_axi_wready     , ``bus_name2``_axi_wready     , ``bus_name1``_axi_wready    , ``bus_name0``_axi_wready   } = ``array_name``_axi_wready  ; \
    assign {``bus_name3``_axi_bid        , ``bus_name2``_axi_bid        , ``bus_name1``_axi_bid       , ``bus_name0``_axi_bid      } = ``array_name``_axi_bid     ; \
    assign {``bus_name3``_axi_bresp      , ``bus_name2``_axi_bresp      , ``bus_name1``_axi_bresp     , ``bus_name0``_axi_bresp    } = ``array_name``_axi_bresp   ; \
    assign {``bus_name3``_axi_bvalid     , ``bus_name2``_axi_bvalid     , ``bus_name1``_axi_bvalid    , ``bus_name0``_axi_bvalid   } = ``array_name``_axi_bvalid  ; \
    assign {``bus_name3``_axi_arready    , ``bus_name2``_axi_arready    , ``bus_name1``_axi_arready   , ``bus_name0``_axi_arready  } = ``array_name``_axi_arready ; \
    assign {``bus_name3``_axi_rid        , ``bus_name2``_axi_rid        , ``bus_name1``_axi_rid       , ``bus_name0``_axi_rid      } = ``array_name``_axi_rid     ; \
    assign {``bus_name3``_axi_rdata      , ``bus_name2``_axi_rdata      , ``bus_name1``_axi_rdata     , ``bus_name0``_axi_rdata    } = ``array_name``_axi_rdata   ; \
    assign {``bus_name3``_axi_rresp      , ``bus_name2``_axi_rresp      , ``bus_name1``_axi_rresp     , ``bus_name0``_axi_rresp    } = ``array_name``_axi_rresp   ; \
    assign {``bus_name3``_axi_rlast      , ``bus_name2``_axi_rlast      , ``bus_name1``_axi_rlast     , ``bus_name0``_axi_rlast    } = ``array_name``_axi_rlast   ; \
    assign {``bus_name3``_axi_rvalid     , ``bus_name2``_axi_rvalid     , ``bus_name1``_axi_rvalid    , ``bus_name0``_axi_rvalid   } = ``array_name``_axi_rvalid  ;

// Concatenate 4 slave buses
`define CONCAT_AXI_SLAVES_ARRAY4(array_name, bus_name3, bus_name2, bus_name1, bus_name0) \
    assign {``bus_name3``_axi_awid       ,``bus_name2``_axi_awid       , ``bus_name1``_axi_awid       , ``bus_name0``_axi_awid     } = ``array_name``_axi_awid    ; \
    assign {``bus_name3``_axi_awaddr     ,``bus_name2``_axi_awaddr     , ``bus_name1``_axi_awaddr     , ``bus_name0``_axi_awaddr   } = ``array_name``_axi_awaddr  ; \
    assign {``bus_name3``_axi_awlen      ,``bus_name2``_axi_awlen      , ``bus_name1``_axi_awlen      , ``bus_name0``_axi_awlen    } = ``array_name``_axi_awlen   ; \
    assign {``bus_name3``_axi_awsize     ,``bus_name2``_axi_awsize     , ``bus_name1``_axi_awsize     , ``bus_name0``_axi_awsize   } = ``array_name``_axi_awsize  ; \
    assign {``bus_name3``_axi_awburst    ,``bus_name2``_axi_awburst    , ``bus_name1``_axi_awburst    , ``bus_name0``_axi_awburst  } = ``array_name``_axi_awburst ; \
    assign {``bus_name3``_axi_awlock     ,``bus_name2``_axi_awlock     , ``bus_name1``_axi_awlock     , ``bus_name0``_axi_awlock   } = ``array_name``_axi_awlock  ; \
    assign {``bus_name3``_axi_awcache    ,``bus_name2``_axi_awcache    , ``bus_name1``_axi_awcache    , ``bus_name0``_axi_awcache  } = ``array_name``_axi_awcache ; \
    assign {``bus_name3``_axi_awprot     ,``bus_name2``_axi_awprot     , ``bus_name1``_axi_awprot     , ``bus_name0``_axi_awprot   } = ``array_name``_axi_awprot  ; \
    assign {``bus_name3``_axi_awqos      ,``bus_name2``_axi_awqos      , ``bus_name1``_axi_awqos      , ``bus_name0``_axi_awqos    } = ``array_name``_axi_awqos   ; \
    assign {``bus_name3``_axi_awvalid    ,``bus_name2``_axi_awvalid    , ``bus_name1``_axi_awvalid    , ``bus_name0``_axi_awvalid  } = ``array_name``_axi_awvalid ; \
    assign {``bus_name3``_axi_awregion   ,``bus_name2``_axi_awregion   , ``bus_name1``_axi_awregion   , ``bus_name0``_axi_awregion } = ``array_name``_axi_awregion; \
    assign {``bus_name3``_axi_wdata      ,``bus_name2``_axi_wdata      , ``bus_name1``_axi_wdata      , ``bus_name0``_axi_wdata    } = ``array_name``_axi_wdata   ; \
    assign {``bus_name3``_axi_wstrb      ,``bus_name2``_axi_wstrb      , ``bus_name1``_axi_wstrb      , ``bus_name0``_axi_wstrb    } = ``array_name``_axi_wstrb   ; \
    assign {``bus_name3``_axi_wlast      ,``bus_name2``_axi_wlast      , ``bus_name1``_axi_wlast      , ``bus_name0``_axi_wlast    } = ``array_name``_axi_wlast   ; \
    assign {``bus_name3``_axi_wvalid     ,``bus_name2``_axi_wvalid     , ``bus_name1``_axi_wvalid     , ``bus_name0``_axi_wvalid   } = ``array_name``_axi_wvalid  ; \
    assign {``bus_name3``_axi_bready     ,``bus_name2``_axi_bready     , ``bus_name1``_axi_bready     , ``bus_name0``_axi_bready   } = ``array_name``_axi_bready  ; \
    assign {``bus_name3``_axi_araddr     ,``bus_name2``_axi_araddr     , ``bus_name1``_axi_araddr     , ``bus_name0``_axi_araddr   } = ``array_name``_axi_araddr  ; \
    assign {``bus_name3``_axi_arlen      ,``bus_name2``_axi_arlen      , ``bus_name1``_axi_arlen      , ``bus_name0``_axi_arlen    } = ``array_name``_axi_arlen   ; \
    assign {``bus_name3``_axi_arsize     ,``bus_name2``_axi_arsize     , ``bus_name1``_axi_arsize     , ``bus_name0``_axi_arsize   } = ``array_name``_axi_arsize  ; \
    assign {``bus_name3``_axi_arburst    ,``bus_name2``_axi_arburst    , ``bus_name1``_axi_arburst    , ``bus_name0``_axi_arburst  } = ``array_name``_axi_arburst ; \
    assign {``bus_name3``_axi_arlock     ,``bus_name2``_axi_arlock     , ``bus_name1``_axi_arlock     , ``bus_name0``_axi_arlock   } = ``array_name``_axi_arlock  ; \
    assign {``bus_name3``_axi_arcache    ,``bus_name2``_axi_arcache    , ``bus_name1``_axi_arcache    , ``bus_name0``_axi_arcache  } = ``array_name``_axi_arcache ; \
    assign {``bus_name3``_axi_arprot     ,``bus_name2``_axi_arprot     , ``bus_name1``_axi_arprot     , ``bus_name0``_axi_arprot   } = ``array_name``_axi_arprot  ; \
    assign {``bus_name3``_axi_arqos      ,``bus_name2``_axi_arqos      , ``bus_name1``_axi_arqos      , ``bus_name0``_axi_arqos    } = ``array_name``_axi_arqos   ; \
    assign {``bus_name3``_axi_arvalid    ,``bus_name2``_axi_arvalid    , ``bus_name1``_axi_arvalid    , ``bus_name0``_axi_arvalid  } = ``array_name``_axi_arvalid ; \
    assign {``bus_name3``_axi_arid       ,``bus_name2``_axi_arid       , ``bus_name1``_axi_arid       , ``bus_name0``_axi_arid     } = ``array_name``_axi_arid    ; \
    assign {``bus_name3``_axi_arregion   ,``bus_name2``_axi_arregion   , ``bus_name1``_axi_arregion   , ``bus_name0``_axi_arregion } = ``array_name``_axi_arregion; \
    assign {``bus_name3``_axi_rready     ,``bus_name2``_axi_rready     , ``bus_name1``_axi_rready     , ``bus_name0``_axi_rready   } = ``array_name``_axi_rready  ; \
    assign ``array_name``_axi_awready = {``bus_name3``_axi_awready    ,``bus_name2``_axi_awready    , ``bus_name1``_axi_awready    , ``bus_name0``_axi_awready  }; \
    assign ``array_name``_axi_wready  = {``bus_name3``_axi_wready     ,``bus_name2``_axi_wready     , ``bus_name1``_axi_wready     , ``bus_name0``_axi_wready   }; \
    assign ``array_name``_axi_bid     = {``bus_name3``_axi_bid        ,``bus_name2``_axi_bid        , ``bus_name1``_axi_bid        , ``bus_name0``_axi_bid      }; \
    assign ``array_name``_axi_bresp   = {``bus_name3``_axi_bresp      ,``bus_name2``_axi_bresp      , ``bus_name1``_axi_bresp      , ``bus_name0``_axi_bresp    }; \
    assign ``array_name``_axi_bvalid  = {``bus_name3``_axi_bvalid     ,``bus_name2``_axi_bvalid     , ``bus_name1``_axi_bvalid     , ``bus_name0``_axi_bvalid   }; \
    assign ``array_name``_axi_arready = {``bus_name3``_axi_arready    ,``bus_name2``_axi_arready    , ``bus_name1``_axi_arready    , ``bus_name0``_axi_arready  }; \
    assign ``array_name``_axi_rid     = {``bus_name3``_axi_rid        ,``bus_name2``_axi_rid        , ``bus_name1``_axi_rid        , ``bus_name0``_axi_rid      }; \
    assign ``array_name``_axi_rdata   = {``bus_name3``_axi_rdata      ,``bus_name2``_axi_rdata      , ``bus_name1``_axi_rdata      , ``bus_name0``_axi_rdata    }; \
    assign ``array_name``_axi_rresp   = {``bus_name3``_axi_rresp      ,``bus_name2``_axi_rresp      , ``bus_name1``_axi_rresp      , ``bus_name0``_axi_rresp    }; \
    assign ``array_name``_axi_rlast   = {``bus_name3``_axi_rlast      ,``bus_name2``_axi_rlast      , ``bus_name1``_axi_rlast      , ``bus_name0``_axi_rlast    }; \
    assign ``array_name``_axi_rvalid  = {``bus_name3``_axi_rvalid     ,``bus_name2``_axi_rvalid     , ``bus_name1``_axi_rvalid     , ``bus_name0``_axi_rvalid   };

// Concatenate 5 slave buses
`define CONCAT_AXI_SLAVES_ARRAY5(array_name, bus_name4, bus_name3, bus_name2, bus_name1, bus_name0) \
    assign {``bus_name4``_axi_awid       ,``bus_name3``_axi_awid       , ``bus_name2``_axi_awid       , ``bus_name1``_axi_awid       , ``bus_name0``_axi_awid     } = ``array_name``_axi_awid    ; \
    assign {``bus_name4``_axi_awaddr     ,``bus_name3``_axi_awaddr     , ``bus_name2``_axi_awaddr     , ``bus_name1``_axi_awaddr     , ``bus_name0``_axi_awaddr   } = ``array_name``_axi_awaddr  ; \
    assign {``bus_name4``_axi_awlen      ,``bus_name3``_axi_awlen      , ``bus_name2``_axi_awlen      , ``bus_name1``_axi_awlen      , ``bus_name0``_axi_awlen    } = ``array_name``_axi_awlen   ; \
    assign {``bus_name4``_axi_awsize     ,``bus_name3``_axi_awsize     , ``bus_name2``_axi_awsize     , ``bus_name1``_axi_awsize     , ``bus_name0``_axi_awsize   } = ``array_name``_axi_awsize  ; \
    assign {``bus_name4``_axi_awburst    ,``bus_name3``_axi_awburst    , ``bus_name2``_axi_awburst    , ``bus_name1``_axi_awburst    , ``bus_name0``_axi_awburst  } = ``array_name``_axi_awburst ; \
    assign {``bus_name4``_axi_awlock     ,``bus_name3``_axi_awlock     , ``bus_name2``_axi_awlock     , ``bus_name1``_axi_awlock     , ``bus_name0``_axi_awlock   } = ``array_name``_axi_awlock  ; \
    assign {``bus_name4``_axi_awcache    ,``bus_name3``_axi_awcache    , ``bus_name2``_axi_awcache    , ``bus_name1``_axi_awcache    , ``bus_name0``_axi_awcache  } = ``array_name``_axi_awcache ; \
    assign {``bus_name4``_axi_awprot     ,``bus_name3``_axi_awprot     , ``bus_name2``_axi_awprot     , ``bus_name1``_axi_awprot     , ``bus_name0``_axi_awprot   } = ``array_name``_axi_awprot  ; \
    assign {``bus_name4``_axi_awqos      ,``bus_name3``_axi_awqos      , ``bus_name2``_axi_awqos      , ``bus_name1``_axi_awqos      , ``bus_name0``_axi_awqos    } = ``array_name``_axi_awqos   ; \
    assign {``bus_name4``_axi_awvalid    ,``bus_name3``_axi_awvalid    , ``bus_name2``_axi_awvalid    , ``bus_name1``_axi_awvalid    , ``bus_name0``_axi_awvalid  } = ``array_name``_axi_awvalid ; \
    assign {``bus_name4``_axi_awregion   ,``bus_name3``_axi_awregion   , ``bus_name2``_axi_awregion   , ``bus_name1``_axi_awregion   , ``bus_name0``_axi_awregion } = ``array_name``_axi_awregion; \
    assign {``bus_name4``_axi_wdata      ,``bus_name3``_axi_wdata      , ``bus_name2``_axi_wdata      , ``bus_name1``_axi_wdata      , ``bus_name0``_axi_wdata    } = ``array_name``_axi_wdata   ; \
    assign {``bus_name4``_axi_wstrb      ,``bus_name3``_axi_wstrb      , ``bus_name2``_axi_wstrb      , ``bus_name1``_axi_wstrb      , ``bus_name0``_axi_wstrb    } = ``array_name``_axi_wstrb   ; \
    assign {``bus_name4``_axi_wlast      ,``bus_name3``_axi_wlast      , ``bus_name2``_axi_wlast      , ``bus_name1``_axi_wlast      , ``bus_name0``_axi_wlast    } = ``array_name``_axi_wlast   ; \
    assign {``bus_name4``_axi_wvalid     ,``bus_name3``_axi_wvalid     , ``bus_name2``_axi_wvalid     , ``bus_name1``_axi_wvalid     , ``bus_name0``_axi_wvalid   } = ``array_name``_axi_wvalid  ; \
    assign {``bus_name4``_axi_bready     ,``bus_name3``_axi_bready     , ``bus_name2``_axi_bready     , ``bus_name1``_axi_bready     , ``bus_name0``_axi_bready   } = ``array_name``_axi_bready  ; \
    assign {``bus_name4``_axi_araddr     ,``bus_name3``_axi_araddr     , ``bus_name2``_axi_araddr     , ``bus_name1``_axi_araddr     , ``bus_name0``_axi_araddr   } = ``array_name``_axi_araddr  ; \
    assign {``bus_name4``_axi_arlen      ,``bus_name3``_axi_arlen      , ``bus_name2``_axi_arlen      , ``bus_name1``_axi_arlen      , ``bus_name0``_axi_arlen    } = ``array_name``_axi_arlen   ; \
    assign {``bus_name4``_axi_arsize     ,``bus_name3``_axi_arsize     , ``bus_name2``_axi_arsize     , ``bus_name1``_axi_arsize     , ``bus_name0``_axi_arsize   } = ``array_name``_axi_arsize  ; \
    assign {``bus_name4``_axi_arburst    ,``bus_name3``_axi_arburst    , ``bus_name2``_axi_arburst    , ``bus_name1``_axi_arburst    , ``bus_name0``_axi_arburst  } = ``array_name``_axi_arburst ; \
    assign {``bus_name4``_axi_arlock     ,``bus_name3``_axi_arlock     , ``bus_name2``_axi_arlock     , ``bus_name1``_axi_arlock     , ``bus_name0``_axi_arlock   } = ``array_name``_axi_arlock  ; \
    assign {``bus_name4``_axi_arcache    ,``bus_name3``_axi_arcache    , ``bus_name2``_axi_arcache    , ``bus_name1``_axi_arcache    , ``bus_name0``_axi_arcache  } = ``array_name``_axi_arcache ; \
    assign {``bus_name4``_axi_arprot     ,``bus_name3``_axi_arprot     , ``bus_name2``_axi_arprot     , ``bus_name1``_axi_arprot     , ``bus_name0``_axi_arprot   } = ``array_name``_axi_arprot  ; \
    assign {``bus_name4``_axi_arqos      ,``bus_name3``_axi_arqos      , ``bus_name2``_axi_arqos      , ``bus_name1``_axi_arqos      , ``bus_name0``_axi_arqos    } = ``array_name``_axi_arqos   ; \
    assign {``bus_name4``_axi_arvalid    ,``bus_name3``_axi_arvalid    , ``bus_name2``_axi_arvalid    , ``bus_name1``_axi_arvalid    , ``bus_name0``_axi_arvalid  } = ``array_name``_axi_arvalid ; \
    assign {``bus_name4``_axi_arid       ,``bus_name3``_axi_arid       , ``bus_name2``_axi_arid       , ``bus_name1``_axi_arid       , ``bus_name0``_axi_arid     } = ``array_name``_axi_arid    ; \
    assign {``bus_name4``_axi_arregion   ,``bus_name3``_axi_arregion   , ``bus_name2``_axi_arregion   , ``bus_name1``_axi_arregion   , ``bus_name0``_axi_arregion } = ``array_name``_axi_arregion; \
    assign {``bus_name4``_axi_rready     ,``bus_name3``_axi_rready     , ``bus_name2``_axi_rready     , ``bus_name1``_axi_rready     , ``bus_name0``_axi_rready   } = ``array_name``_axi_rready  ; \
    assign ``array_name``_axi_awready = {``bus_name4``_axi_awready    ,``bus_name3``_axi_awready    ,``bus_name2``_axi_awready    , ``bus_name1``_axi_awready    , ``bus_name0``_axi_awready  }; \
    assign ``array_name``_axi_wready  = {``bus_name4``_axi_wready     ,``bus_name3``_axi_wready     ,``bus_name2``_axi_wready     , ``bus_name1``_axi_wready     , ``bus_name0``_axi_wready   }; \
    assign ``array_name``_axi_bid     = {``bus_name4``_axi_bid        ,``bus_name3``_axi_bid        ,``bus_name2``_axi_bid        , ``bus_name1``_axi_bid        , ``bus_name0``_axi_bid      }; \
    assign ``array_name``_axi_bresp   = {``bus_name4``_axi_bresp      ,``bus_name3``_axi_bresp      ,``bus_name2``_axi_bresp      , ``bus_name1``_axi_bresp      , ``bus_name0``_axi_bresp    }; \
    assign ``array_name``_axi_bvalid  = {``bus_name4``_axi_bvalid     ,``bus_name3``_axi_bvalid     ,``bus_name2``_axi_bvalid     , ``bus_name1``_axi_bvalid     , ``bus_name0``_axi_bvalid   }; \
    assign ``array_name``_axi_arready = {``bus_name4``_axi_arready    ,``bus_name3``_axi_arready    ,``bus_name2``_axi_arready    , ``bus_name1``_axi_arready    , ``bus_name0``_axi_arready  }; \
    assign ``array_name``_axi_rid     = {``bus_name4``_axi_rid        ,``bus_name3``_axi_rid        ,``bus_name2``_axi_rid        , ``bus_name1``_axi_rid        , ``bus_name0``_axi_rid      }; \
    assign ``array_name``_axi_rdata   = {``bus_name4``_axi_rdata      ,``bus_name3``_axi_rdata      ,``bus_name2``_axi_rdata      , ``bus_name1``_axi_rdata      , ``bus_name0``_axi_rdata    }; \
    assign ``array_name``_axi_rresp   = {``bus_name4``_axi_rresp      ,``bus_name3``_axi_rresp      ,``bus_name2``_axi_rresp      , ``bus_name1``_axi_rresp      , ``bus_name0``_axi_rresp    }; \
    assign ``array_name``_axi_rlast   = {``bus_name4``_axi_rlast      ,``bus_name3``_axi_rlast      ,``bus_name2``_axi_rlast      , ``bus_name1``_axi_rlast      , ``bus_name0``_axi_rlast    }; \
    assign ``array_name``_axi_rvalid  = {``bus_name4``_axi_rvalid     ,``bus_name3``_axi_rvalid     ,``bus_name2``_axi_rvalid     , ``bus_name1``_axi_rvalid     , ``bus_name0``_axi_rvalid   };

// Concatenate 6 slave buses
`define CONCAT_AXI_SLAVES_ARRAY6(array_name, bus_name5, bus_name4, bus_name3, bus_name2, bus_name1, bus_name0) \
    assign {``bus_name5``_axi_awid       , ``bus_name4``_axi_awid       ,``bus_name3``_axi_awid       , ``bus_name2``_axi_awid       , ``bus_name1``_axi_awid       , ``bus_name0``_axi_awid     } = ``array_name``_axi_awid    ; \
    assign {``bus_name5``_axi_awaddr     , ``bus_name4``_axi_awaddr     ,``bus_name3``_axi_awaddr     , ``bus_name2``_axi_awaddr     , ``bus_name1``_axi_awaddr     , ``bus_name0``_axi_awaddr   } = ``array_name``_axi_awaddr  ; \
    assign {``bus_name5``_axi_awlen      , ``bus_name4``_axi_awlen      ,``bus_name3``_axi_awlen      , ``bus_name2``_axi_awlen      , ``bus_name1``_axi_awlen      , ``bus_name0``_axi_awlen    } = ``array_name``_axi_awlen   ; \
    assign {``bus_name5``_axi_awsize     , ``bus_name4``_axi_awsize     ,``bus_name3``_axi_awsize     , ``bus_name2``_axi_awsize     , ``bus_name1``_axi_awsize     , ``bus_name0``_axi_awsize   } = ``array_name``_axi_awsize  ; \
    assign {``bus_name5``_axi_awburst    , ``bus_name4``_axi_awburst    ,``bus_name3``_axi_awburst    , ``bus_name2``_axi_awburst    , ``bus_name1``_axi_awburst    , ``bus_name0``_axi_awburst  } = ``array_name``_axi_awburst ; \
    assign {``bus_name5``_axi_awlock     , ``bus_name4``_axi_awlock     ,``bus_name3``_axi_awlock     , ``bus_name2``_axi_awlock     , ``bus_name1``_axi_awlock     , ``bus_name0``_axi_awlock   } = ``array_name``_axi_awlock  ; \
    assign {``bus_name5``_axi_awcache    , ``bus_name4``_axi_awcache    ,``bus_name3``_axi_awcache    , ``bus_name2``_axi_awcache    , ``bus_name1``_axi_awcache    , ``bus_name0``_axi_awcache  } = ``array_name``_axi_awcache ; \
    assign {``bus_name5``_axi_awprot     , ``bus_name4``_axi_awprot     ,``bus_name3``_axi_awprot     , ``bus_name2``_axi_awprot     , ``bus_name1``_axi_awprot     , ``bus_name0``_axi_awprot   } = ``array_name``_axi_awprot  ; \
    assign {``bus_name5``_axi_awqos      , ``bus_name4``_axi_awqos      ,``bus_name3``_axi_awqos      , ``bus_name2``_axi_awqos      , ``bus_name1``_axi_awqos      , ``bus_name0``_axi_awqos    } = ``array_name``_axi_awqos   ; \
    assign {``bus_name5``_axi_awvalid    , ``bus_name4``_axi_awvalid    ,``bus_name3``_axi_awvalid    , ``bus_name2``_axi_awvalid    , ``bus_name1``_axi_awvalid    , ``bus_name0``_axi_awvalid  } = ``array_name``_axi_awvalid ; \
    assign {``bus_name5``_axi_awregion   , ``bus_name4``_axi_awregion   ,``bus_name3``_axi_awregion   , ``bus_name2``_axi_awregion   , ``bus_name1``_axi_awregion   , ``bus_name0``_axi_awregion } = ``array_name``_axi_awregion; \
    assign {``bus_name5``_axi_wdata      , ``bus_name4``_axi_wdata      ,``bus_name3``_axi_wdata      , ``bus_name2``_axi_wdata      , ``bus_name1``_axi_wdata      , ``bus_name0``_axi_wdata    } = ``array_name``_axi_wdata   ; \
    assign {``bus_name5``_axi_wstrb      , ``bus_name4``_axi_wstrb      ,``bus_name3``_axi_wstrb      , ``bus_name2``_axi_wstrb      , ``bus_name1``_axi_wstrb      , ``bus_name0``_axi_wstrb    } = ``array_name``_axi_wstrb   ; \
    assign {``bus_name5``_axi_wlast      , ``bus_name4``_axi_wlast      ,``bus_name3``_axi_wlast      , ``bus_name2``_axi_wlast      , ``bus_name1``_axi_wlast      , ``bus_name0``_axi_wlast    } = ``array_name``_axi_wlast   ; \
    assign {``bus_name5``_axi_wvalid     , ``bus_name4``_axi_wvalid     ,``bus_name3``_axi_wvalid     , ``bus_name2``_axi_wvalid     , ``bus_name1``_axi_wvalid     , ``bus_name0``_axi_wvalid   } = ``array_name``_axi_wvalid  ; \
    assign {``bus_name5``_axi_bready     , ``bus_name4``_axi_bready     ,``bus_name3``_axi_bready     , ``bus_name2``_axi_bready     , ``bus_name1``_axi_bready     , ``bus_name0``_axi_bready   } = ``array_name``_axi_bready  ; \
    assign {``bus_name5``_axi_araddr     , ``bus_name4``_axi_araddr     ,``bus_name3``_axi_araddr     , ``bus_name2``_axi_araddr     , ``bus_name1``_axi_araddr     , ``bus_name0``_axi_araddr   } = ``array_name``_axi_araddr  ; \
    assign {``bus_name5``_axi_arlen      , ``bus_name4``_axi_arlen      ,``bus_name3``_axi_arlen      , ``bus_name2``_axi_arlen      , ``bus_name1``_axi_arlen      , ``bus_name0``_axi_arlen    } = ``array_name``_axi_arlen   ; \
    assign {``bus_name5``_axi_arsize     , ``bus_name4``_axi_arsize     ,``bus_name3``_axi_arsize     , ``bus_name2``_axi_arsize     , ``bus_name1``_axi_arsize     , ``bus_name0``_axi_arsize   } = ``array_name``_axi_arsize  ; \
    assign {``bus_name5``_axi_arburst    , ``bus_name4``_axi_arburst    ,``bus_name3``_axi_arburst    , ``bus_name2``_axi_arburst    , ``bus_name1``_axi_arburst    , ``bus_name0``_axi_arburst  } = ``array_name``_axi_arburst ; \
    assign {``bus_name5``_axi_arlock     , ``bus_name4``_axi_arlock     ,``bus_name3``_axi_arlock     , ``bus_name2``_axi_arlock     , ``bus_name1``_axi_arlock     , ``bus_name0``_axi_arlock   } = ``array_name``_axi_arlock  ; \
    assign {``bus_name5``_axi_arcache    , ``bus_name4``_axi_arcache    ,``bus_name3``_axi_arcache    , ``bus_name2``_axi_arcache    , ``bus_name1``_axi_arcache    , ``bus_name0``_axi_arcache  } = ``array_name``_axi_arcache ; \
    assign {``bus_name5``_axi_arprot     , ``bus_name4``_axi_arprot     ,``bus_name3``_axi_arprot     , ``bus_name2``_axi_arprot     , ``bus_name1``_axi_arprot     , ``bus_name0``_axi_arprot   } = ``array_name``_axi_arprot  ; \
    assign {``bus_name5``_axi_arqos      , ``bus_name4``_axi_arqos      ,``bus_name3``_axi_arqos      , ``bus_name2``_axi_arqos      , ``bus_name1``_axi_arqos      , ``bus_name0``_axi_arqos    } = ``array_name``_axi_arqos   ; \
    assign {``bus_name5``_axi_arvalid    , ``bus_name4``_axi_arvalid    ,``bus_name3``_axi_arvalid    , ``bus_name2``_axi_arvalid    , ``bus_name1``_axi_arvalid    , ``bus_name0``_axi_arvalid  } = ``array_name``_axi_arvalid ; \
    assign {``bus_name5``_axi_arid       , ``bus_name4``_axi_arid       ,``bus_name3``_axi_arid       , ``bus_name2``_axi_arid       , ``bus_name1``_axi_arid       , ``bus_name0``_axi_arid     } = ``array_name``_axi_arid    ; \
    assign {``bus_name5``_axi_arregion   , ``bus_name4``_axi_arregion   ,``bus_name3``_axi_arregion   , ``bus_name2``_axi_arregion   , ``bus_name1``_axi_arregion   , ``bus_name0``_axi_arregion } = ``array_name``_axi_arregion; \
    assign {``bus_name5``_axi_rready     , ``bus_name4``_axi_rready     ,``bus_name3``_axi_rready     , ``bus_name2``_axi_rready     , ``bus_name1``_axi_rready     , ``bus_name0``_axi_rready   } = ``array_name``_axi_rready  ; \
    assign ``array_name``_axi_awready = {``bus_name5``_axi_awready    ,``bus_name4``_axi_awready    ,``bus_name3``_axi_awready    ,``bus_name2``_axi_awready    , ``bus_name1``_axi_awready    , ``bus_name0``_axi_awready  }; \
    assign ``array_name``_axi_wready  = {``bus_name5``_axi_wready     ,``bus_name4``_axi_wready     ,``bus_name3``_axi_wready     ,``bus_name2``_axi_wready     , ``bus_name1``_axi_wready     , ``bus_name0``_axi_wready   }; \
    assign ``array_name``_axi_bid     = {``bus_name5``_axi_bid        ,``bus_name4``_axi_bid        ,``bus_name3``_axi_bid        ,``bus_name2``_axi_bid        , ``bus_name1``_axi_bid        , ``bus_name0``_axi_bid      }; \
    assign ``array_name``_axi_bresp   = {``bus_name5``_axi_bresp      ,``bus_name4``_axi_bresp      ,``bus_name3``_axi_bresp      ,``bus_name2``_axi_bresp      , ``bus_name1``_axi_bresp      , ``bus_name0``_axi_bresp    }; \
    assign ``array_name``_axi_bvalid  = {``bus_name5``_axi_bvalid     ,``bus_name4``_axi_bvalid     ,``bus_name3``_axi_bvalid     ,``bus_name2``_axi_bvalid     , ``bus_name1``_axi_bvalid     , ``bus_name0``_axi_bvalid   }; \
    assign ``array_name``_axi_arready = {``bus_name5``_axi_arready    ,``bus_name4``_axi_arready    ,``bus_name3``_axi_arready    ,``bus_name2``_axi_arready    , ``bus_name1``_axi_arready    , ``bus_name0``_axi_arready  }; \
    assign ``array_name``_axi_rid     = {``bus_name5``_axi_rid        ,``bus_name4``_axi_rid        ,``bus_name3``_axi_rid        ,``bus_name2``_axi_rid        , ``bus_name1``_axi_rid        , ``bus_name0``_axi_rid      }; \
    assign ``array_name``_axi_rdata   = {``bus_name5``_axi_rdata      ,``bus_name4``_axi_rdata      ,``bus_name3``_axi_rdata      ,``bus_name2``_axi_rdata      , ``bus_name1``_axi_rdata      , ``bus_name0``_axi_rdata    }; \
    assign ``array_name``_axi_rresp   = {``bus_name5``_axi_rresp      ,``bus_name4``_axi_rresp      ,``bus_name3``_axi_rresp      ,``bus_name2``_axi_rresp      , ``bus_name1``_axi_rresp      , ``bus_name0``_axi_rresp    }; \
    assign ``array_name``_axi_rlast   = {``bus_name5``_axi_rlast      ,``bus_name4``_axi_rlast      ,``bus_name3``_axi_rlast      ,``bus_name2``_axi_rlast      , ``bus_name1``_axi_rlast      , ``bus_name0``_axi_rlast    }; \
    assign ``array_name``_axi_rvalid  = {``bus_name5``_axi_rvalid     ,``bus_name4``_axi_rvalid     ,``bus_name3``_axi_rvalid     ,``bus_name2``_axi_rvalid     , ``bus_name1``_axi_rvalid     , ``bus_name0``_axi_rvalid   };



//////////////////
//  Bus Ports   //
//////////////////

// AXI4 MASTER PORTS
`define DEFINE_AXI_MASTER_PORTS(master_name)          \
    // AW channel                                     \
    output axi_id_t     ``master_name``_axi_awid,     \
    output axi_addr_t   ``master_name``_axi_awaddr,   \
    output axi_len_t    ``master_name``_axi_awlen,    \
    output axi_size_t   ``master_name``_axi_awsize,   \
    output axi_burst_t  ``master_name``_axi_awburst,  \
    output axi_lock_t   ``master_name``_axi_awlock,   \
    output axi_cache_t  ``master_name``_axi_awcache,  \
    output axi_prot_t   ``master_name``_axi_awprot,   \
    output axi_qos_t    ``master_name``_axi_awqos,    \
    output axi_valid_t  ``master_name``_axi_awvalid,  \
    input  axi_ready_t  ``master_name``_axi_awready,  \
    output axi_region_t ``master_name``_axi_awregion, \
    // W channel                                      \
    output axi_data_t   ``master_name``_axi_wdata,    \
    output axi_strb_t   ``master_name``_axi_wstrb,    \
    output axi_last_t   ``master_name``_axi_wlast,    \
    output axi_valid_t  ``master_name``_axi_wvalid,   \
    input  axi_ready_t  ``master_name``_axi_wready,   \
    // B channel                                      \
    input  axi_id_t     ``master_name``_axi_bid,      \
    input  axi_resp_t   ``master_name``_axi_bresp,    \
    input  axi_valid_t  ``master_name``_axi_bvalid,   \
    output axi_ready_t  ``master_name``_axi_bready,   \
    // AR channel                                     \
    output axi_addr_t   ``master_name``_axi_araddr,   \
    output axi_len_t    ``master_name``_axi_arlen,    \
    output axi_size_t   ``master_name``_axi_arsize,   \
    output axi_burst_t  ``master_name``_axi_arburst,  \
    output axi_lock_t   ``master_name``_axi_arlock,   \
    output axi_cache_t  ``master_name``_axi_arcache,  \
    output axi_prot_t   ``master_name``_axi_arprot,   \
    output axi_qos_t    ``master_name``_axi_arqos,    \
    output axi_valid_t  ``master_name``_axi_arvalid,  \
    input  axi_ready_t  ``master_name``_axi_arready,  \
    output axi_id_t     ``master_name``_axi_arid,     \
    output axi_region_t ``master_name``_axi_arregion, \
    // R channel                                      \
    input  axi_id_t     ``master_name``_axi_rid,      \
    input  axi_data_t   ``master_name``_axi_rdata,    \
    input  axi_resp_t   ``master_name``_axi_rresp,    \
    input  axi_last_t   ``master_name``_axi_rlast,    \
    input  axi_valid_t  ``master_name``_axi_rvalid,   \
    output axi_ready_t  ``master_name``_axi_rready


// AXI4 SLAVE PORTS
`define DEFINE_AXI_SLAVE_PORTS(slave_name)           \
  // AW channel                                    \
  input  axi_id_t     ``slave_name``_axi_awid,     \
  input  axi_addr_t   ``slave_name``_axi_awaddr,   \
  input  axi_len_t    ``slave_name``_axi_awlen,    \
  input  axi_size_t   ``slave_name``_axi_awsize,   \
  input  axi_burst_t  ``slave_name``_axi_awburst,  \
  input  axi_lock_t   ``slave_name``_axi_awlock,   \
  input  axi_cache_t  ``slave_name``_axi_awcache,  \
  input  axi_prot_t   ``slave_name``_axi_awprot,   \
  input  axi_qos_t    ``slave_name``_axi_awqos,    \
  input  axi_valid_t  ``slave_name``_axi_awvalid,  \
  output axi_ready_t  ``slave_name``_axi_awready,  \
  input  axi_region_t ``slave_name``_axi_awregion, \
  // W channel                                     \
  input  axi_data_t   ``slave_name``_axi_wdata,    \
  input  axi_strb_t   ``slave_name``_axi_wstrb,    \
  input  axi_last_t   ``slave_name``_axi_wlast,    \
  input  axi_valid_t  ``slave_name``_axi_wvalid,   \
  output axi_ready_t  ``slave_name``_axi_wready,   \
  // B channel                                     \
  output axi_id_t     ``slave_name``_axi_bid,      \
  output axi_resp_t   ``slave_name``_axi_bresp,    \
  output axi_valid_t  ``slave_name``_axi_bvalid,   \
  input  axi_ready_t  ``slave_name``_axi_bready,   \
  // AR channel                                    \
  input  axi_addr_t   ``slave_name``_axi_araddr,   \
  input  axi_len_t    ``slave_name``_axi_arlen,    \
  input  axi_size_t   ``slave_name``_axi_arsize,   \
  input  axi_burst_t  ``slave_name``_axi_arburst,  \
  input  axi_lock_t   ``slave_name``_axi_arlock,   \
  input  axi_cache_t  ``slave_name``_axi_arcache,  \
  input  axi_prot_t   ``slave_name``_axi_arprot,   \
  input  axi_qos_t    ``slave_name``_axi_arqos,    \
  input  axi_valid_t  ``slave_name``_axi_arvalid,  \
  output axi_ready_t  ``slave_name``_axi_arready,  \
  input  axi_id_t     ``slave_name``_axi_arid,     \
  input  axi_region_t ``slave_name``_axi_arregion, \
  // R channel                                     \
  output axi_id_t     ``slave_name``_axi_rid,      \
  output axi_data_t   ``slave_name``_axi_rdata,    \
  output axi_resp_t   ``slave_name``_axi_rresp,    \
  output axi_last_t   ``slave_name``_axi_rlast,    \
  output axi_valid_t  ``slave_name``_axi_rvalid,   \
  input  axi_ready_t  ``slave_name``_axi_rready

// AXI4 LITE SLAVE PORTS
`define DEFINE_AXILITE_SLAVE_PORTS(slave_name)           \
    // AW channel                                        \
    input  axi_addr_t   ``slave_name``_axilite_awaddr,   \
    input  axi_prot_t   ``slave_name``_axilite_awprot,   \
    input  axi_valid_t  ``slave_name``_axilite_awvalid,  \
    output axi_ready_t  ``slave_name``_axilite_awready,  \
    // W channel                                         \
    input  axi_data_t   ``slave_name``_axilite_wdata,    \
    input  axi_strb_t   ``slave_name``_axilite_wstrb,    \
    input  axi_valid_t  ``slave_name``_axilite_wvalid,   \
    output axi_ready_t  ``slave_name``_axilite_wready,   \
    // B channel                                         \
    output axi_resp_t   ``slave_name``_axilite_bresp,    \
    output axi_valid_t  ``slave_name``_axilite_bvalid,   \
    input  axi_ready_t  ``slave_name``_axilite_bready,   \
    // AR channel                                        \
    input  axi_addr_t   ``slave_name``_axilite_araddr,   \
    input  axi_prot_t   ``slave_name``_axilite_arprot,   \
    input  axi_valid_t  ``slave_name``_axilite_arvalid,  \
    output axi_ready_t  ``slave_name``_axilite_arready,  \
    // R channel                                         \
    output axi_data_t   ``slave_name``_axilite_rdata,    \
    output axi_resp_t   ``slave_name``_axilite_rresp,    \
    output axi_valid_t  ``slave_name``_axilite_rvalid,   \
    input  axi_ready_t  ``slave_name``_axilite_rready



`endif // UNINASOC_AXI_SVH__
