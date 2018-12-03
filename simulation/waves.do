onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /countOneASM/clk
add wave -noupdate /countOneASM/rst_n
add wave -noupdate /countOneASM/start
add wave -noupdate /countOneASM/A
add wave -noupdate -divider Output
add wave -noupdate -radix decimal /countOneASM/result
add wave -noupdate /countOneASM/done
add wave -noupdate -divider {State Machine}
add wave -noupdate /countOneASM/start_sync
add wave -noupdate /countOneASM/next_state
add wave -noupdate /countOneASM/curr_state
add wave -noupdate /countOneASM/load
add wave -noupdate /countOneASM/shift
add wave -noupdate /countOneASM/empty
add wave -noupdate /countOneASM/restart
add wave -noupdate /countOneASM/count_clr
add wave -noupdate /countOneASM/count_en
add wave -noupdate /countOneASM/count
add wave -noupdate /countOneASM/shift_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1533 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 193
configure wave -valuecolwidth 80
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
WaveRestoreZoom {0 ps} {1536 ps}
