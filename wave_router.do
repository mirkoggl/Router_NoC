onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_router/clk
add wave -noupdate /tb_router/reset
add wave -noupdate -radix unsigned /tb_router/Data_In
add wave -noupdate -divider {Input 0}
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/shft
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/ack
add wave -noupdate /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/empty
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/Data_Out
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(0)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 1}
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/shft
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/ack
add wave -noupdate /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/empty
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/Data_Out
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(1)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 2}
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/shft
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/ack
add wave -noupdate /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/empty
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/Data_Out
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(2)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 3}
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/shft
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/ack
add wave -noupdate /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/empty
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/Data_Out
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(3)/InputInterfaceX/fifo_memory
add wave -noupdate -divider {Input 4}
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/shft
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/ack
add wave -noupdate /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/empty
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/Data_Out
add wave -noupdate -radix unsigned /tb_router/uut/Input_Interface_GEN(4)/InputInterfaceX/fifo_memory
add wave -noupdate -divider CU
add wave -noupdate -radix unsigned /tb_router/uut/CU_inst/Data_In
add wave -noupdate /tb_router/uut/CU_inst/Empty_Out
add wave -noupdate /tb_router/uut/CU_inst/Full_Out
add wave -noupdate /tb_router/uut/CU_inst/Sdone_In
add wave -noupdate /tb_router/uut/CU_inst/Sdone_Out
add wave -noupdate /tb_router/uut/CU_inst/Shft_In
add wave -noupdate /tb_router/uut/CU_inst/Wr_En_Out
add wave -noupdate -radix unsigned /tb_router/uut/CU_inst/Cross_Sel
add wave -noupdate /tb_router/uut/CU_inst/current_s
add wave -noupdate -radix unsigned /tb_router/uut/CU_inst/xy_data_in
add wave -noupdate -radix unsigned /tb_router/uut/CU_inst/xy_chan_in
add wave -noupdate -divider Crossbar
add wave -noupdate -radix unsigned /tb_router/uut/Crossbar_inst/sel
add wave -noupdate -radix unsigned /tb_router/uut/Crossbar_inst/Data_In
add wave -noupdate -radix unsigned -childformat {{/tb_router/uut/Crossbar_inst/Data_Out(0) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(1) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(2) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(3) -radix unsigned} {/tb_router/uut/Crossbar_inst/Data_Out(4) -radix unsigned}} -subitemconfig {/tb_router/uut/Crossbar_inst/Data_Out(0) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(1) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(2) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(3) {-height 15 -radix unsigned} /tb_router/uut/Crossbar_inst/Data_Out(4) {-height 15 -radix unsigned}} /tb_router/uut/Crossbar_inst/Data_Out
add wave -noupdate -divider {Output 0}
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/ack
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/wren
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/full
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/empty
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/valid
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/current_s
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(0)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 1}
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/ack
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/wren
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/full
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/empty
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/valid
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/current_s
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(1)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 2}
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/ack
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/wren
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/full
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/empty
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/valid
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/current_s
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(2)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 3}
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/ack
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/wren
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/full
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/empty
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/valid
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/current_s
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(3)/OutputInterfaceX/fifo_memory
add wave -noupdate -divider {Output 4}
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Data_In
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/ack
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/wren
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/sdone
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/full
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/empty
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/valid
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/Data_Out
add wave -noupdate /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/current_s
add wave -noupdate -radix unsigned /tb_router/uut/Output_Interface_GEN(4)/OutputInterfaceX/fifo_memory
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {282951 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 430
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1050 ns}
