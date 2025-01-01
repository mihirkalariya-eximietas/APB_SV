vlog ../RTL/amba_apb.sv ../TEST/apb_pkg.sv ../TOP/apb_tb_top.sv +incdir+../ENV +incdir+../TEST
vsim -voptargs=+acc apb_tb_top
do wave.do
run -all