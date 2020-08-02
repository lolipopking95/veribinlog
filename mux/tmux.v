module test_mux;

reg a, b, sel;
wire q;

//устанавливаем экземпляр тестируемого модуля
mux mux_inst(a, b, sel, q);

	initial begin
		// Initialize Inputs
	a = 0;
	b = 1;
	sel = 0;
 
	#20 sel = 1;
	#20 sel = 0;
	#20 sel = 1;	
	#20 sel = 0;	  
	#40;
    end  



//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,test_mux);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, a,, b,,, sel,, q);

endmodule

