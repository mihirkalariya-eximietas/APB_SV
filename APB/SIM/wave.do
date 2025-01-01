onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /apb_tb_top/DUT/idle
add wave -noupdate /apb_tb_top/DUT/setup
add wave -noupdate /apb_tb_top/DUT/access
add wave -noupdate /apb_tb_top/DUT/PCLK
add wave -noupdate /apb_tb_top/DUT/RESETn
add wave -noupdate /apb_tb_top/DUT/PADDAR
add wave -noupdate /apb_tb_top/DUT/PSLEx
add wave -noupdate /apb_tb_top/DUT/PENABLE
add wave -noupdate /apb_tb_top/DUT/PWRITE
add wave -noupdate /apb_tb_top/DUT/PWDATA
add wave -noupdate /apb_tb_top/DUT/PREADY
add wave -noupdate /apb_tb_top/DUT/PSLVERR
add wave -noupdate /apb_tb_top/DUT/PRDATA
add wave -noupdate /apb_tb_top/DUT/mem
add wave -noupdate /apb_tb_top/DUT/present_state
add wave -noupdate /apb_tb_top/DUT/next_state
add wave -noupdate /apb_tb_top/DUT/i
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PCLK
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/RESETn
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PADDAR
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PWDATA
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PSLEx
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PENABLE
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PWRITE
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PRDATA
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PREADY
add wave -noupdate -expand -label sim:/apb_tb_top/rif/Group1 -group {Region: sim:/apb_tb_top/rif} /apb_tb_top/rif/PSLVERR
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PSLVERR
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PREADY
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PRDATA
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PENABLE
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PSLEx
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PWRITE
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PWDATA
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/PADDAR
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/RESETn
add wave -noupdate -expand -label sim:/apb_tb_top/rif/mon_cb/Group1 -group {Region: sim:/apb_tb_top/rif/mon_cb} /apb_tb_top/rif/mon_cb/mon_cb_event
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {236 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {551 ns}
