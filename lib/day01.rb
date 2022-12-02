class Day01
  def part_a(input)
    calories_per_elf(input).max
  end

  def part_b(input)
    calories_per_elf(input).sort_by { |v| -v }.first(3).sum
  end

  private

  def calories_per_elf(input)
    input.
      lines.
      map(&:chomp).
      reduce([[]]) { |res, line|
        if line == ""
          next res.append([])
        else
          next res[0...-1].append(res.last.append(Integer(line)))
        end
      }.
      map(&:sum)
  end
end
