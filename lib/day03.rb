require "set"

class Day03
  def part_a(input)
    input.
      lines.
      map(&:chomp).
      map(&:chars).
      map { |line| [line[0...(line.size/2)].to_set, line[(line.size/2)..-1].to_set] }.
      map { |line| line.first.intersection(line.last) }.
      map(&:first).
      map { |common_item|
        case common_item
        when /[A-Z]/
          common_item.ord - 38
        when /[a-z]/
          common_item.ord - 96
        end
      }.
      sum
  end

  def part_b(input)
    input.
      lines.
      map(&:chomp).
      map(&:chars).
      map(&:to_set).
      each_slice(3).
      map { |group| group[0].intersection(group[1]).intersection(group[2]) }.
      map(&:first).
      map { |common_item|
        case common_item
        when /[A-Z]/
          common_item.ord - 38
        when /[a-z]/
          common_item.ord - 96
        end
      }.
      sum
  end
end