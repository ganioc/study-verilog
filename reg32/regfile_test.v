/** Time scale **/
`timescale 1ns/1ps

/** header file **/
`include "regfile.h"

/** 模块  **/
module regfile_test; // 声明模块,
    /** 输入输出端口信号  **/
    // 时钟&复位
    reg    clk;  // 时钟
    reg    reset_; // 复位逻辑
    // 访问接口
    reg [`AddrBus] addr;
    reg [`DataBus] d_in; // 输入数据
    reg            we_;  // 写入使能，负逻辑
    wire [`DataBus] d_out;  // 输出数据
    /** 内部变量 **/
    integer        i;
    parameter     STEP = 100.0000; // 10M

    /** 生成时钟 **/
    always #(STEP /2 ) begin
        clk <= ~clk;
    end

    /** 实例化测试模块  **/
    regfile regfile (
        .clk     (clk),
        .reset_  (reset_),
        .addr    (addr),
        .d_in    (d_in),
        .we_     (we_),
        .d_out   (d_out)
    );

    /** 测试用例  **/
    initial begin
        # 0 begin
            clk     <= `HIGH;
            reset_  <= `ENABLE_;
            addr    <= {`ADDR_W{1'b0}};
            d_in    <= {`DATA_W{1'b0}};
            we_     <= `DISABLE_;
        end

        # (STEP *3 / 4)
        # STEP begin
            reset_  <=  `DISABLE_; // 解除复位
        end 

        # STEP begin
            for (i = 0; i< `DATA_D; i= i+1) begin
                # STEP begin
                    addr   <=  i;
                    d_in   <=  i;
                    we_    <=  `ENABLE_;
                end
                # STEP begin
                    addr  <=  {`ADDR_W{1'b0}};
                    d_in  <=  {`DATA_W{1'b0}};
                    we_   <=  `DISABLE_;
                    if (d_out == i) begin
                        $display($time, " ff[%d] Read/Write Check OK !", i);
                    end else begin
                        $display($time, " ff[%d] Read/Write Check NG !", i);
                    end
                end
            end
        end
        # STEP begin
            $finish;
        end
    end
    /** 输出波形  **/
    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, regfile);
    end
endmodule
