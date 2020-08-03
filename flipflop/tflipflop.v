module test_flipflop;

reg reset, clk, enable, set, d;
wire q;

//устанавливаем экземпляр тестируемого модуля
flipflop flipflop_inst(reset, clk, set, enable, d, q);

//моделируем сигнал тактовой частоты
always
  #5 clk = ~clk;

//от начала времени...

initial
begin
  clk = 0;
  reset = 0;
  d = 0;
  set = 0;
  enable = 0;

//через временной интервал "50" подаем сигнал сброса
  #50 reset = 1;

//еще через время "4" снимаем сигнал сброса

  #4 reset = 0;

//пауза длительностью "50"
  #50;

//ждем фронта тактовой частоты и сразу после нее подаем сигнал записи
  @(posedge clk)
  #0    
      d = 1'b1;
  #50 
//по следующему фронту снимаем сигнал записи
  @(posedge clk)
  #0
      enable = 1;
  #40  
      reset = 1;
  #5  reset = 0;	  
  #40
  @(posedge clk)
  begin
  enable = 0;
  #20
  d = 0;
  end
  #20
  enable = 1;
  #40
  @(posedge clk)
  begin
  set = 1;
  #3
  set = 0;
  end
  
  
  
end

//заканчиваем симуляцию в момент времени "400"
initial
begin
  #1000 $finish;
end

//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,test_flipflop);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, reset,, clk,,, d,, enable,, q,, set);

endmodule

