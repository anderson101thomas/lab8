transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Ben\ Nguyen/Desktop/EE\ 271/Labs/lab2 {C:/Users/Ben Nguyen/Desktop/EE 271/Labs/lab2/lastTwoDigits.sv}

