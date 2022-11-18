`ifndef __REGFILE_HEADER__
    `define __REGFILE_HEADER__

    /**** 信号电平  ***/
    `define HIGH   1'b1
    `define LOW    1`b0

    /** Logical Value **/
    `define ENABLE_   1'b0
    `define DISABLE_  1'b1

    /**  data **/
    `define DATA_W     32 // 宽度
    `define DataBus    31:0
    `define DATA_D     32 // 深度,数量

    /**  地址  **/
    `define ADDR_W      5 // 地址宽度
    `define AddrBus     4:0

`endif
