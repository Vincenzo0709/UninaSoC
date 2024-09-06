// Author: Vincenzo Maisto <vincenzo.maisto2@unina.it>
// Description: Utility variables and macros for AXI interconnections in UninaSoC

package uninasoc_pkg_axi;

    // AXI4 bus parameters
    localparam int unsigned AXI_DATA_WIDTH   = 32;
    localparam int unsigned AXI_ADDR_WIDTH   = 32;
    localparam int unsigned AXI_STRB_WIDTH   = AXI_ADDR_WIDTH / 8;
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
    
    // AXI signal types
    typedef logic [AXI_DATA_WIDTH    -1 : 0] axi_data_t;
    typedef logic [AXI_ADDR_WIDTH    -1 : 0] axi_addr_t;
    typedef logic [AXI_STRB_WIDTH    -1 : 0] axi_strb_t;
    typedef logic [AXI_ID_WIDTH      -1 : 0] axi_id_t;
    typedef logic [AXI_LEN_WIDTH     -1 : 0] axi_len_t;
    typedef logic [AXI_SIZE_WIDTH    -1 : 0] axi_size_t;
    typedef logic [AXI_BURST_WIDTH   -1 : 0] axi_burst_t;
    typedef logic [AXI_LOCK_WIDTH    -1 : 0] axi_lock_t;
    typedef logic [AXI_CACHE_WIDTH   -1 : 0] axi_cache_t;
    typedef logic [AXI_PROT_WIDTH    -1 : 0] axi_prot_t;
    typedef logic [AXI_QOS_WIDTH     -1 : 0] axi_qos_t;
    typedef logic [AXI_VALID_WIDTH   -1 : 0] axi_valid_t;
    typedef logic [AXI_READY_WIDTH   -1 : 0] axi_ready_t;
    typedef logic [AXI_LAST_WIDTH    -1 : 0] axi_last_t;
    typedef logic [AXI_RESP_WIDTH    -1 : 0] axi_resp_t;
    typedef logic [AXI_REGION_WIDTH  -1 : 0] axi_region_t;

    // Single define for whole AXI4 bus
    `define DEFINE_AXI_BUS(bus_name)            \
        // AW channel                           \
        axi_id_t     ``bus_name``_axi_awid;     \
        axi_addr_t   ``bus_name``_axi_awaddr;   \
        axi_len_t    ``bus_name``_axi_awlen;    \
        axi_size_t   ``bus_name``_axi_awsize;   \
        axi_burst_t  ``bus_name``_axi_awburst;  \
        axi_lock_t   ``bus_name``_axi_awlock;   \
        axi_cache_t  ``bus_name``_axi_awcache;  \
        axi_prot_t   ``bus_name``_axi_awprot;   \
        axi_qos_t    ``bus_name``_axi_awqos;    \
        axi_valid_t  ``bus_name``_axi_awvalid;  \
        axi_ready_t  ``bus_name``_axi_awready;  \
        axi_region_t ``bus_name``_axi_awregion; \
        // W channel                            \
        axi_data_t   ``bus_name``_axi_wdata;    \
        axi_strb_t   ``bus_name``_axi_wstrb;    \
        axi_last_t   ``bus_name``_axi_wlast;    \
        axi_valid_t  ``bus_name``_axi_wvalid;   \
        axi_ready_t  ``bus_name``_axi_wready;   \
        // B channel                            \
        axi_id_t     ``bus_name``_axi_bid;      \
        axi_resp_t   ``bus_name``_axi_bresp;    \
        axi_valid_t  ``bus_name``_axi_bvalid;   \
        axi_ready_t  ``bus_name``_axi_bready;   \
        // AR channel                           \
        axi_addr_t   ``bus_name``_axi_araddr;   \
        axi_len_t    ``bus_name``_axi_arlen;    \
        axi_size_t   ``bus_name``_axi_arsize;   \
        axi_burst_t  ``bus_name``_axi_arburst;  \
        axi_lock_t   ``bus_name``_axi_arlock;   \
        axi_cache_t  ``bus_name``_axi_arcache;  \
        axi_prot_t   ``bus_name``_axi_arprot;   \
        axi_qos_t    ``bus_name``_axi_arqos;    \
        axi_valid_t  ``bus_name``_axi_arvalid;  \
        axi_ready_t  ``bus_name``_axi_arready;  \
        axi_id_t     ``bus_name``_axi_arid;     \
        axi_region_t ``bus_name``_axi_arregion; \
        // R channel                            \
        axi_id_t     ``bus_name``_axi_rid;      \
        axi_data_t   ``bus_name``_axi_rdata;    \
        axi_resp_t   ``bus_name``_axi_rresp;    \
        axi_last_t   ``bus_name``_axi_rlast;    \
        axi_valid_t  ``bus_name``_axi_rvalid;   \
        axi_ready_t  ``bus_name``_axi_rready;

    // Single define for whole AXI4-LITE bus
    `define DEFINE_AXILITE_BUS(bus_name)            \
        // AW channel                               \
        axi_addr_t  ``bus_name``_axilite_awaddr;    \
        axi_prot_t  ``bus_name``_axilite_awprot;    \
        axi_valid_t ``bus_name``_axilite_awvalid;   \
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

endpackage : uninasoc_pkg_axi
