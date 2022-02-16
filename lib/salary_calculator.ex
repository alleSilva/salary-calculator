defmodule SalaryCalculator do
  def calc do
    IO.puts("Digite o valor da hora trabalhada: ")
    h_value = IO.read(:stdio, :line)
    {f_h_value, _} = Float.parse(String.trim(h_value))

    IO.puts("Quantos dias tem o mês: ?")
    n_days = IO.read(:stdio, :line)
    {i_n_days, _} = Integer.parse(String.trim(n_days))

    IO.puts("Quantas horas extras 60 %: ")
    extra_60 = IO.read(:stdio, :line)
    {f_extra_60, _} = Float.parse(String.trim(extra_60))
    IO.puts("Quantas horas extras 110 %: ")
    extra_110 = IO.read(:stdio, :line)
    {f_extra_110, _} = Float.parse(String.trim(extra_110))

    IO.puts("Quantos dependentes vc tem?: ")
    dependents = IO.read(:stdio, :line)
    {f_deps, _} = Float.parse(String.trim(dependents))

    IO.puts("-------------------------------------------------------")
    total_extra_60 = 
      extra_hour(f_extra_60, f_h_value, 60)
    total_extra_110 = 
      extra_hour(f_extra_110, f_h_value, 110)
    total_extra = total_extra_60 + total_extra_110
    total = 
      salary_base(i_n_days, f_h_value) + total_extra
    inss = calc_inss(total)
    irpf = calc_ir(total, inss, f_deps)
    quinz = quinzena(f_h_value)
    total_extra_110 = 
      extra_hour(f_extra_110, f_h_value, 110)
    liquido =
      Float.round(total - inss - irpf - quinz - 26.40, 2)

    IO.puts("Quinzena: " <> Float.to_string(quinz))
    IO.puts("Desconto inss: " <> Float.to_string(inss))
    IO.puts("Desconto irpf: " <> Float.to_string(irpf))
    IO.puts("Extra 60%: " <> Float.to_string(total_extra_60))
    IO.puts("Extra 110%: " <> Float.to_string(total_extra_110))

    IO.puts("Salario a receber no final do mês: " <> Float.to_string(liquido))
    IO.puts("-------------------------------------------------------")
    
  end

  def salary_base(days, hour_value) do
    s = (220/30) * days * hour_value

    Float.round(s, 2)
  end

  def extra_hour(quantity, hour_value, percent) do
    cond do
      percent == 60 -> 
        Float.round(quantity * hour_value * 1.6, 2)
      percent == 110 ->
        Float.round(quantity * hour_value * 2.1, 2)
    end


  end

  def quinzena(hour_value) do
    Float.round(220 * hour_value * 0.4, 2)
  end

  def calc_inss(salary) do
    cond do
      salary <= 1212.00 -> 
        Float.round(salary * 0.075, 2)
      salary >= 1212.01 && salary <= 2427.35 -> 
        Float.round((salary - 1212.01) * 0.09 + 90.9, 2)
      salary >= 2427.36 && salary <= 3641.03 ->
        Float.round((salary - 2427.36) * 0.12 + 200.28, 2)
      salary >= 3641.04 && salary <= 7087.22 ->
        Float.round((salary - 3641.04) * 0.14 + 345.92, 2)
      salary >= 7087.23 -> 828.39
    end
  end

  def calc_ir(salary, inss, deps) do
    base = salary - inss - deps * 189.59

    cond do
      base <= 1903.98 -> 0
      base >= 1903.99 && base <= 2826.65 ->
        Float.round(base * 0.075 - 142.8, 2)
      base >= 2826.66 && base <= 3751.05 ->
        Float.round(base * 0.15 - 354.8, 2)
      base >= 3751.06 && base <= 4664.68 ->
        Float.round(base * 0.225 - 636.13, 2)
      base >= 4664.69 ->
        Float.round(base * 0.275 - 869.36, 2)
    end
  end
end
