defmodule AOC.Day18 do
  @moduledoc false

  def part1(input) do
    precedence = [{?+, 0}, {?*, 0}]

    input
    |> parse()
    |> Enum.map(&shunting_yard(&1, precedence))
    |> Enum.map(&eval_expression(&1))
    |> Enum.sum()
  end

  def part2(input) do
    precedence = [{?+, 1}, {?*, 0}]

    input
    |> parse()
    |> Enum.map(&shunting_yard(&1, precedence))
    |> Enum.map(&eval_expression(&1))
    |> Enum.sum()
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_expression/1)
  end

  def parse_expression(expression) do
    expression
    |> String.to_charlist()
    |> Enum.reject(&(&1 == ?\s))
  end

  def eval(expression, precedence \\ []) do
    expression
    |> shunting_yard(precedence)
    |> eval_expression()
  end

  def eval_expression(expression), do: eval_expression(expression, [])

  def eval_expression([], [result]), do: result
  def eval_expression([?+ | output], [a, b | stack]), do: eval_expression(output, [a + b | stack])
  def eval_expression([?* | output], [a, b | stack]), do: eval_expression(output, [a * b | stack])
  def eval_expression([n | output], stack), do: eval_expression(output, [n | stack])

  def shunting_yard(expression, precedence),
    do: shunting_yard(expression, precedence, [], [])

  def shunting_yard([], _precedence, output, ops),
    do: pop_operators(output, ops) |> elem(1)

  def shunting_yard([char | expression], precedence, output, ops) do
    case char do
      ?( ->
        shunting_yard(expression, precedence, output, [?( | ops])

      ?) ->
        {[?( | ops], output} = pop_operators(ops, output)
        shunting_yard(expression, precedence, output, ops)

      ?+ ->
        {ops, output} = pop_precedence(ops, ?+, precedence, output)
        shunting_yard(expression, precedence, output, [?+ | ops])

      ?* ->
        {ops, output} = pop_precedence(ops, ?*, precedence, output)
        shunting_yard(expression, precedence, output, [?* | ops])

      n ->
        shunting_yard(expression, precedence, [n - ?0 | output], ops)
    end
  end

  def pop_operators([], output), do: {[], output}

  def pop_operators([?( | _] = ops, output), do: {ops, output}
  def pop_operators([op | ops], output), do: pop_operators(ops, [op | output])

  def pop_precedence([], _op, _precedence, output), do: {[], output}
  def pop_precedence([?( | _] = ops, _op, _precedence, output), do: {ops, output}

  def pop_precedence([op_on_stack | ops], op, precedence, output) do
    op_on_stack_precedence = get_op_precedence(precedence, op_on_stack)
    op_precedence = get_op_precedence(precedence, op)

    if op_on_stack_precedence >= op_precedence,
      do: pop_precedence(ops, op, precedence, [op_on_stack | output]),
      else: {[op_on_stack | ops], output}
  end

  def get_op_precedence(precedence, op),
    do: List.keyfind(precedence, op, 0, {op, 0}) |> elem(1)
end
