force -drive sim:/countOneASM/start 0 0 -cancel 400
force -freeze sim:/countOneASM/clk 1 0, 0 {50 ps} -r 100
force -deposit sim:/countOneASM/rst_n 0 0 -cancel 199
force -freeze sim:/countOneASM/rst_n 1 200
force -deposit sim:/countOneASM/A 10110011 0 -cancel 600
force -deposit sim:/countOneASM/A 11000010 601
force -drive sim:/countOneASM/start 1 401 -cancel 1200
force -drive sim:/countOneASM/start 0 1201 -cancel 2000
force -drive sim:/countOneASM/start 1 2001 -cancel 5000
run 3000
log -r ./*