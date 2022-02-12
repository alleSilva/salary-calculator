defmodule SalaryCalculatorTest do
  use ExUnit.Case
  doctest SalaryCalculator

  test "greets the world" do
    assert SalaryCalculator.hello() == :world
  end
end
