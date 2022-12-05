class Day05
  MOVE_REGEX = /move (\d+) from (\d+) to (\d+)/
  Move = Struct.new(:count, :from, :to)

  def part_a(input)
    input_lines = input.lines.map(&:chomp)
    split_index = input_lines.index("")

    stack_lines = input_lines[0...split_index]
    stack_lines.reverse!
    move_lines = input_lines[split_index+1..-1]

    stacks = parse_stacks(stack_lines)
    moves = parse_moves(move_lines)

    moves.each do |move|
      move.count.times do
        stacks[move.to].push(stacks[move.from].pop)
      end
    end

    stacks[1..-1].map(&:last).join
  end

  def part_b(input)
  end

  private

  def parse_stacks(stack_lines)
    # TODO: regex this out if it doesn't work on proper input
    max_column = Integer(stack_lines.first[-2])
    # Discard the column numbering
    stack_lines.shift

    stacks = Array.new(max_column) { [] }
    # The whole problem is 1-indexed, so let's be lazy and make our state pseudo-1-indexed
    stacks.unshift(nil)

    stack_lines.each do |line|
      (1..max_column).each do |stack|
        position = (stack * 4) - 3
        contents = line[position] 
        if contents != " "
          stacks[stack] << contents
        end
      end
    end

    stacks
  end

  def parse_moves(move_lines)
    move_lines.map { |line|
      MOVE_REGEX.match(line)
    }.map { |line|
      Move.new(Integer(line[1]), Integer(line[2]), Integer(line[3]))
    }
  end
end
