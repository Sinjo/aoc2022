class Day01
  def part_a(input)
    result = input.
      lines.
      map(&:chomp).
      reduce([[]]) { |res, line|
        if line == ""
          next res.append([])
        else
          next res[0...-1].append(res.last.append(Integer(line)))
        end
      }.
      map(&:sum).
      max

  end
end
