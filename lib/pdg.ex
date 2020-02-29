defmodule Pdg.CLI do
  def main(args) do
    options = [
      switches: [from: :integer, to: :integer, name: :string], 
      aliases: [f: :from, t: :to, n: :name]
    ]
    {opts,_,_}= OptionParser.parse(args, options)
    text = generate("", "W", "w", opts) 
    |> generate("O", "0", opts) 
    |> generate("O", "o", opts) 
    |> generate("O", "o0", opts) 
    |> generate("I", "l", opts) 
    |> generate("I", "1", opts) 
    |> generate("I", "1l", opts) 
    |> generate("K", "k", opts) 
    |> generate("U", "u", opts) 
    |> generate("X", "x", opts) 
    |> generate("S", "s", opts) 
    |> generate("M", "m", opts) 
    |> generate("C", "c", opts) 
    |> generate("Z", "z", opts) 
    File.write(opts[:name] || "proguard-dictionary.txt", text)
    |> IO.inspect
  end

  defp generate(acc, first, second, args) do
    from = args[:from] || 6
    to = args[:to] || 30
    generate(acc, first, second, from, to)
  end

  defp generate(acc, first, second, from, to) do
    count = Enum.random(from..to)
    acc <> generate_child(count, first, second, "")
  end

  defp generate_child(count, first, second, acc) do
    if count > 0 do
      length = String.length(second)
      other = if length > 1 do
        generate_random("", second, count)
      else
        String.duplicate(second, count)
      end
      generate_child(count-1, first, second, acc <> first <> other <> "\n")
    else
      acc
    end
  end

  defp generate_random(acc, second, count) do
    if count > 0 do
      generate_random(
        acc <> String.slice(second, Enum.random(0..String.length(second)-1), 1),
        second, count-1)
    else
      acc
    end
  end
end
