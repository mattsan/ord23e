defmodule Ord23e do
  def solve(input) do
    {index, rules} =
      input
      |> String.split(",")
      |> conv()

    total_length = total_length(rules)

    if total_length < index do
      "x"
    else
      {_, _, d} =
        rules
        |> Enum.reduce({index - 1, total_length, 0}, fn rule, {index, length, d} ->
          case rule do
            ?a ->
              length = div(length, 4)

              d =
                case div(index, length) do
                  0 -> d
                  1 -> d + 1
                  2 -> d - 1
                  3 -> d
                end

              {rem(index, length), length, d}

            ?b ->
              length = div(length, 5)

              d =
                case div(index, length) do
                  0 -> d
                  1 -> d + 1
                  2 -> d
                  3 -> d - 1
                  4 -> d
                end

              {rem(index, length), length, d}
          end
        end)

      case rem(d, 6) do
        -4 -> "-"
        -3 -> "0"
        -2 -> "+"
        -1 -> "-"
        0 -> "0"
        1 -> "+"
        2 -> "-"
        3 -> "0"
        4 -> "+"
      end
    end
  end

  def conv([index, rules]) do
    {
      String.to_integer(index),
      String.to_charlist(rules)
    }
  end

  def total_length(rules) do
    rules
    |> Enum.reduce(1, fn rule, acc ->
      case rule do
        ?a -> acc * 4
        ?b -> acc * 5
      end
    end)
  end
end
