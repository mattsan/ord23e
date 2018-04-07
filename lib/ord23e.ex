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
      {_, _, direction} =
        rules
        |> Enum.reduce({index - 1, total_length, 0}, fn rule, {index, length, direction} ->
          case rule do
            ?a ->
              length = div(length, 4)

              direction =
                case div(index, length) do
                  0 -> direction
                  1 -> direction + 1
                  2 -> direction - 1
                  3 -> direction
                end

              {rem(index, length), length, direction}

            ?b ->
              length = div(length, 5)

              direction =
                case div(index, length) do
                  0 -> direction
                  1 -> direction + 1
                  2 -> direction
                  3 -> direction - 1
                  4 -> direction
                end

              {rem(index, length), length, direction}
          end
        end)

      case rem(direction, 6) do
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
