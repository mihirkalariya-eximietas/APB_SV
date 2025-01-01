#makefile

lib :
	vlib work
	
cmp : 
	vlog ../RTL/amba_apb.sv ../TEST/apb_pkg.sv ../TOP/apb_tb_top.sv +incdir+../ENV +incdir+../TEST

sim : 
	vsim -voptargs=+acc apb_tb_top -c -do "run -all; exit" +B2B
	
wave :
	vsim -voptargs=+acc apb_tb_top +RD_ONLY
	
regress:
		vlib work
		vlog -coveropt 3 +cover +acc ../RTL/amba_apb.sv ../TEST/apb_pkg.sv ../TOP/apb_tb_top.sv +incdir+../ENV +incdir+../TEST
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall write.ucdb;run -all;exit" +WR_ONLY
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall read.ucdb;run -all;exit" +RD_ONLY
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall b2b.ucdb;run -all;exit" +B2B
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall sim_wr.ucdb;run -all;exit" +IBR
		vcover merge merge.ucdb write.ucdb read.ucdb b2b.ucdb sim_wr.ucdb 
		vcover report -details -html merge.ucdb