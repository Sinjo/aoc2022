class Day06
  def part_a(input)
    input.chars.each_cons(4).with_index { |slice, index|
      if slice.size == slice.uniq.size
        break index + 4
      end
    }
  end

  def part_b(input)
    input.chars.each_cons(14).with_index { |slice, index|
      if slice.size == slice.uniq.size
        break index + 14
      end
    }
  end
end
