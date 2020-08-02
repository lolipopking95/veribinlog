module test_drebezg;

reg rst_1, clk_i, sw_i;
wire sw_state_o, sw_down_o, sw_up_o;

//устанавливаем экземпляр тестируемого модуля
drebezg drebezg_inst(rst_1, clk_i, sw_i,sw_state_o, sw_down_o, sw_up_o);

//моделируем сигнал тактовой частоты
always
  #10 clk_i = ~clk_i;

//от начала времени...

initial
begin
  clk_i = 0;
  rst_1 = 0;
  wdata = 8'h00;
  wr = 1'b0;

//через временной интервал "50" подаем сигнал сброса
  #50 rst_1 = 1;

//еще через время "4" снимаем сигнал сброса

  #4 rst_1 = 0;

//пауза длительностью "50"
  #50;

//ждем фронта тактовой частоты и сразу после нее подаем сигнал записи
  @(posedge clk)
  #0
    begin
      wdata = 8'h55;
      wr = 1'b1;
    end

//по следующему фронту снимаем сигнал записи
  @(posedge clk)
  #0
    begin
      wdata = 8'h00;
      wr = 1'b0;
    end
end

//заканчиваем симуляцию в момент времени "400"
initial
begin
  #400 $finish;
end

//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,test_counter);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, reset,, clk,,, wdata,, wr,, data_cnt);

endmodule

