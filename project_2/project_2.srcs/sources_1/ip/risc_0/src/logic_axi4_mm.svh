/* Copyright 2020 Jakub Wiczynski
 * MSc thesis - Implementation of DSP co-processor in Xilinx Zynq Soc - Politechnika Gdanska
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

`ifndef LOGIC_AXI4_MM_SVH
`define LOGIC_AXI4_MM_SVH

/* Define: LOGIC_AXI4_MM_IF_ASSIGN
 *
 * Assign SystemVerilog interface to another SystemVerilog interface.
 *
 * Parameters:
 *  lhs       - SystemVerilog interface.
 *  rhs       - SystemVerilog interface.
 */

`define LOGIC_AXI4_MM_IF_ASSIGN(lhs, rhs)         \
    assign lhs``.awid      = rhs``.awid;       \
    assign lhs``.awaddr    = rhs``.awaddr;     \
    assign lhs``.awlen     = rhs``.awlen;      \
    assign lhs``.awsize    = rhs``.awsize;     \
    assign lhs``.awburst   = rhs``.awburst;    \
    assign lhs``.awlock    = rhs``.awlock;     \
    assign lhs``.awcache   = rhs``.awcache;    \
    assign lhs``.awprot    = rhs``.awprot;     \
    assign lhs``.awqos     = rhs``.awqos;      \
    assign lhs``.awregion  = rhs``.awregion;   \
    assign lhs``.awuser    = rhs``.awuser;     \
    assign lhs``.awvalid   = rhs``.awvalid;    \
    assign rhs``.awready   = lhs``.awready;    \
    assign lhs``.wid       = rhs``.wid;        \
    assign lhs``.wdata     = rhs``.wdata;      \
    assign lhs``.wstrb     = rhs``.wstrb;      \
    assign lhs``.wlast     = rhs``.wlast;      \
    assign lhs``.wuser     = rhs``.wuser;      \
    assign lhs``.wvalid    = rhs``.wvalid;     \
    assign rhs``.wready    = lhs``.wready;     \
    assign rhs``.bid       = lhs``.bid;        \
    assign rhs``.bresp     = lhs``.bresp;      \
    assign rhs``.buser     = lhs``.buser;      \
    assign rhs``.bvalid    = lhs``.bvalid;     \
    assign lhs``.bready    = rhs``.bready;     \
    assign lhs``.arid      = rhs``.arid;       \
    assign lhs``.araddr    = rhs``.araddr;     \
    assign lhs``.arlen     = rhs``.arlen;      \
    assign lhs``.arsize    = rhs``.arsize;     \
    assign lhs``.arburst   = rhs``.arburst;    \
    assign lhs``.arlock    = rhs``.arlock;     \
    assign lhs``.arcache   = rhs``.arcache;    \
    assign lhs``.arprot    = rhs``.arprot;     \
    assign lhs``.arqos     = rhs``.arqos;      \
    assign lhs``.arregion  = rhs``.arregion;   \
    assign lhs``.aruser    = rhs``.aruser;     \
    assign lhs``.arvalid   = rhs``.arvalid;    \
    assign rhs``.arready   = lhs``.arready;    \
    assign rhs``.rid       = lhs``.rid;        \
    assign rhs``.rdata     = lhs``.rdata;      \
    assign rhs``.rresp     = lhs``.rresp;      \
    assign rhs``.rlast     = lhs``.rlast;      \
    assign rhs``.ruser     = lhs``.ruser;      \
    assign rhs``.rvalid    = lhs``.rvalid;     \
    assign lhs``.rready    = rhs``.rready;     


/* Define: LOGIC_AXI4_MM_IF_SLAVE_ASSIGN
 *
 * Assign standalone signals to signals in SystemVerilog interface.
 *
 * Parameters:
 *  lhs       - SystemVerilog interface.
 *  rhs       - Standalone SystemVerilog signals.
 */
`define LOGIC_AXI4_MM_IF_SLAVE_ASSIGN(lhs, rhs)   \
    assign lhs``.awid      = rhs``.__awid;     \
    assign lhs``.awaddr    = rhs``._awaddr;    \
    assign lhs``.awlen     = rhs``._awlen;     \
    assign lhs``.awsize    = rhs``._awsize;    \
    assign lhs``.awburst   = rhs``._awburst;   \
    assign lhs``.awlock    = rhs``._awlock;    \
    assign lhs``.awcache   = rhs``._awcache;   \
    assign lhs``.awprot    = rhs``._awprot;    \
    assign lhs``.awqos     = rhs``._awqos;     \
    assign lhs``.awregion  = rhs``._awregion;  \
    assign lhs``.awuser    = rhs``._awuser;    \
    assign lhs``.awvalid   = rhs``._awvalid;   \
    assign rhs``._awready  = lhs``.awready;    \
    assign lhs``.wid       = rhs``._wid;       \
    assign lhs``.wdata     = rhs``._wdata;     \
    assign lhs``.wstrb     = rhs``._wstrb;     \
    assign lhs``.wlast     = rhs``._wlast;     \
    assign lhs``.wuser     = rhs``._wuser;     \
    assign lhs``.wvalid    = rhs``._wvalid;    \
    assign rhs``._wready   = lhs``.wready;     \
    assign rhs``._bid      = lhs``.bid;        \
    assign rhs``._bresp    = lhs``.bresp;      \
    assign rhs``._buser    = lhs``.buser;      \
    assign rhs``._bvalid   = lhs``.bvalid;     \
    assign lhs``.bready    = rhs``._bready;    \
    assign lhs``.arid      = rhs``._arid;      \
    assign lhs``.araddr    = rhs``._araddr;    \
    assign lhs``.arlen     = rhs``._arlen;     \
    assign lhs``.arsize    = rhs``._arsize;    \
    assign lhs``.arburst   = rhs``._arburst;   \
    assign lhs``.arlock    = rhs``._arlock;    \
    assign lhs``.arcache   = rhs``._arcache;   \
    assign lhs``.arprot    = rhs``._arprot;    \
    assign lhs``.arqos     = rhs``._arqos;     \
    assign lhs``.arregion  = rhs``._arregion;  \
    assign lhs``.aruser    = rhs``._aruser;    \
    assign lhs``.arvalid   = rhs``._arvalid;   \
    assign rhs``._arready  = lhs``.arready;    \
    assign rhs``._rid      = lhs``.rid;        \
    assign rhs``._rdata    = lhs``.rdata;      \
    assign rhs``._rresp    = lhs``.rresp;      \
    assign rhs``._rlast    = lhs``.rlast;      \
    assign rhs``._ruser    = lhs``.ruser;      \
    assign rhs``._rvalid   = lhs``.rvalid;     \
    assign lhs``.rready    = rhs``._rready;     

/* Define: LOGIC_AXI4_MM_IF_MASTER_ASSIGN
 *
 * Assign signals in SystemVerilog interface to standalone signals.
 *
 * Parameters:
 *  lhs       - Standalone SystemVerilog signals.
 *  rhs       - SystemVerilog interface.
 */
`define LOGIC_AXI4_MM_IF_MASTER_ASSIGN(lhs, rhs)  \
    assign lhs``._awid     = rhs``.awid;       \
    assign lhs``._awaddr   = rhs``.awaddr;     \
    assign lhs``._awlen    = rhs``.awlen;      \
    assign lhs``._awsize   = rhs``.awsize;     \
    assign lhs``._awburst  = rhs``.awburst;    \
    assign lhs``._awlock   = rhs``.awlock;     \
    assign lhs``._awcache  = rhs``.awcache;    \
    assign lhs``._awprot   = rhs``.awprot;     \
    assign lhs``._awqos    = rhs``.awqos;      \
    assign lhs``._awregion = rhs``.awregion;   \
    assign lhs``._awuser   = rhs``.awuser;     \
    assign lhs``._awvalid  = rhs``.awvalid;    \
    assign rhs``.awready   = lhs``._awready;   \
    assign lhs``._wid      = rhs``.wid;        \
    assign lhs``._wdata    = rhs``.wdata;      \
    assign lhs``._wstrb    = rhs``.wstrb;      \
    assign lhs``._wlast    = rhs``.wlast;      \
    assign lhs``._wuser    = rhs``.wuser;      \
    assign lhs``._wvalid   = rhs``.wvalid;     \
    assign rhs``.wready    = lhs``._wready;    \
    assign rhs``.bid       = lhs``._bid;       \
    assign rhs``.bresp     = lhs``._bresp;     \
    assign rhs``.buser     = lhs``._buser;     \
    assign rhs``.bvalid    = lhs``._bvalid;    \
    assign lhs``._bready   = rhs``.bready;     \
    assign lhs``._arid     = rhs``.arid;       \
    assign lhs``._araddr   = rhs``.araddr;     \
    assign lhs``._arlen    = rhs``.arlen;      \
    assign lhs``._arsize   = rhs``.arsize;     \
    assign lhs``._arburst  = rhs``.arburst;    \
    assign lhs``._arlock   = rhs``.arlock;     \
    assign lhs``._arcache  = rhs``.arcache;    \
    assign lhs``._arprot   = rhs``.arprot;     \
    assign lhs``._arqos    = rhs``.arqos;      \
    assign lhs``._arregion = rhs``.arregion;   \
    assign lhs``._aruser   = rhs``.aruser;     \
    assign lhs``._arvalid  = rhs``.arvalid;    \
    assign rhs``.arready   = lhs``._arready;   \
    assign rhs``.rid       = lhs``._rid;       \
    assign rhs``.rdata     = lhs``._rdata;     \
    assign rhs``.rresp     = lhs``._rresp;     \
    assign rhs``.rlast     = lhs``._rlast;     \
    assign rhs``.ruser     = lhs``._ruser;     \
    assign rhs``.rvalid    = lhs``._rvalid;    \
    assign lhs``._rready   = rhs``.rready;     

/* Define: LOGIC_AXI4_MM_IF_SLAVE_ASSIGN_ARRAY
 *
 * Assign standalone signals to signals in SystemVerilog interface.
 *
 * Parameters:
 *  lhs       - SystemVerilog interface.
 *  rhs       - Standalone SystemVerilog signals.
 *  index     - Array index for rhs.
 */
`define LOGIC_AXI4_MM_IF_SLAVE_ASSIGN_ARRAY(lhs, rhs, index)      \
    assign lhs``.awid              = rhs``.__awid[index];      \
    assign lhs``.awaddr            = rhs``._awaddr[index];     \
    assign lhs``.awlen             = rhs``._awlen[index];      \
    assign lhs``.awsize            = rhs``._awsize[index];     \
    assign lhs``.awburst           = rhs``._awburst[index];    \
    assign lhs``.awlock            = rhs``._awlock[index];     \
    assign lhs``.awcache           = rhs``._awcache[index];    \
    assign lhs``.awprot            = rhs``._awprot[index];     \
    assign lhs``.awqos             = rhs``._awqos[index];      \
    assign lhs``.awregion          = rhs``._awregion[index];   \
    assign lhs``.awuser            = rhs``._awuser[index];     \
    assign lhs``.awvalid           = rhs``._awvalid[index];    \
    assign rhs``._awready[index]   = lhs``.awready;            \
    assign lhs``.wid               = rhs``._wid[index];        \
    assign lhs``.wdata             = rhs``._wdata[index];      \
    assign lhs``.wstrb             = rhs``._wstrb[index];      \
    assign lhs``.wlast             = rhs``._wlast[index];      \
    assign lhs``.wuser             = rhs``._wuser[index];      \
    assign lhs``.wvalid            = rhs``._wvalid[index];     \
    assign rhs``._wready[index]    = lhs``.wready;             \
    assign rhs``._bid[index]       = lhs``.bid;                \
    assign rhs``._bresp[index]     = lhs``.bresp;              \
    assign rhs``._buser[index]     = lhs``.buser;              \
    assign rhs``._bvalid[index]    = lhs``.bvalid;             \
    assign lhs``.bready            = rhs``._bready[index];     \
    assign lhs``.arid              = rhs``._arid[index];       \
    assign lhs``.araddr            = rhs``._araddr[index];     \
    assign lhs``.arlen             = rhs``._arlen[index];      \
    assign lhs``.arsize            = rhs``._arsize[index];     \
    assign lhs``.arburst           = rhs``._arburst[index];    \
    assign lhs``.arlock            = rhs``._arlock[index];     \
    assign lhs``.arcache           = rhs``._arcache[index];    \
    assign lhs``.arprot            = rhs``._arprot[index];     \
    assign lhs``.arqos             = rhs``._arqos[index];      \
    assign lhs``.arregion          = rhs``._arregion[index];   \
    assign lhs``.aruser            = rhs``._aruser[index];     \
    assign lhs``.arvalid           = rhs``._arvalid[index];    \
    assign rhs``._arready[index]   = lhs``.arready;            \
    assign rhs``._rid[index]       = lhs``.rid;                \
    assign rhs``._rdata[index]     = lhs``.rdata;              \
    assign rhs``._rresp[index]     = lhs``.rresp;              \
    assign rhs``._rlast[index]     = lhs``.rlast;              \
    assign rhs``._ruser[index]     = lhs``.ruser;              \
    assign rhs``._rvalid[index]    = lhs``.rvalid;             \
    assign lhs``.rready            = rhs``._rready[index];     \


/* Define: LOGIC_AXI4_MM_IF_MASTER_ASSIGN_ARRAY
 *
 * Assign signals in SystemVerilog interface to standalone signals.
 *
 * Parameters:
 *  lhs       - Standalone SystemVerilog signals.
 *  rhs       - SystemVerilog interface.
 *  index     - Array index for lhs.
 */
`define LOGIC_AXI4_MM_IF_MASTER_ASSIGN_ARRAY(lhs, index, rhs)     \
    assign lhs``._awid[index]      = rhs``.awid;               \
    assign lhs``._awaddr[index]    = rhs``.awaddr;             \
    assign lhs``._awlen[index]     = rhs``.awlen;              \
    assign lhs``._awsize[index]    = rhs``.awsize;             \
    assign lhs``._awburst[index]   = rhs``.awburst;            \
    assign lhs``._awlock[index]    = rhs``.awlock;             \
    assign lhs``._awcache[index]   = rhs``.awcache;            \
    assign lhs``._awprot[index]    = rhs``.awprot;             \
    assign lhs``._awqos[index]     = rhs``.awqos;              \
    assign lhs``._awregion[index]  = rhs``.awregion;           \
    assign lhs``._awuser[index]    = rhs``.awuser;             \
    assign lhs``._awvalid[index]   = rhs``.awvalid;            \
    assign rhs``.awready           = lhs``._awready[index];    \
    assign lhs``._wid[index]       = rhs``.wid;                \
    assign lhs``._wdata[index]     = rhs``.wdata;              \
    assign lhs``._wstrb[index]     = rhs``.wstrb;              \
    assign lhs``._wlast[index]     = rhs``.wlast;              \
    assign lhs``._wuser[index]     = rhs``.wuser;              \
    assign lhs``._wvalid[index]    = rhs``.wvalid;             \
    assign rhs``.wready            = lhs``._wready[index];     \
    assign rhs``.bid               = lhs``._bid[index];        \
    assign rhs``.bresp             = lhs``._bresp[index];      \
    assign rhs``.buser             = lhs``._buser[index];      \
    assign rhs``.bvalid            = lhs``._bvalid[index];     \
    assign lhs``._bready[index]    = rhs``.bready;             \
    assign lhs``._arid[index]      = rhs``.arid;               \
    assign lhs``._araddr[index]    = rhs``.araddr;             \
    assign lhs``._arlen[index]     = rhs``.arlen;              \
    assign lhs``._arsize[index]    = rhs``.arsize;             \
    assign lhs``._arburst[index]   = rhs``.arburst;            \
    assign lhs``._arlock[index]    = rhs``.arlock;             \
    assign lhs``._arcachev         = rhs``.arcache;            \
    assign lhs``._arprot[index]    = rhs``.arprot;             \
    assign lhs``._arqos[index]     = rhs``.arqos;              \
    assign lhs``._arregion[index]  = rhs``.arregion;           \
    assign lhs``._aruser[index]    = rhs``.aruser;             \
    assign lhs``._arvalid[index]   = rhs``.arvalid;            \
    assign rhs``.arready           = lhs``._arready[index];    \
    assign rhs``.rid               = lhs``._rid[index];        \
    assign rhs``.rdata             = lhs``._rdata[index];      \
    assign rhs``.rresp             = lhs``._rresp[index];      \
    assign rhs``.rlast             = lhs``._rlast[index];      \
    assign rhs``.ruser             = lhs``._ruser[index];      \
    assign rhs``.rvalid            = lhs``._rvalid[index];     \
    assign lhs``._rready[index]    = rhs``.rready;

`endif /* LOGIC_AXI4_MM_SVH */
