require "set"

class Day09
  Move = Struct.new(:direction, :distance)
  Point = Struct.new(:x, :y)

  MOVE_TRANSLATIONS = {
    "R" => [1, 0],
    "L" => [-1, 0],
    "U" => [0, 1],
    "D" => [0, -1],
  }

  def part_a(input)
    tail_visited = Set.new()
    tail_visited.add(Point.new(0,0))

    moves = input.lines.map(&:chomp).map(&:split).map { |line|
      Move.new(line.first, Integer(line.last))
    }

    head_position = Point.new(0, 0)
    tail_position = Point.new(0, 0)

    moves.each do |move|
      move.distance.times do
        new_head_x = head_position.x + MOVE_TRANSLATIONS[move.direction].first
        new_head_y = head_position.y + MOVE_TRANSLATIONS[move.direction].last

        head_position = Point.new(new_head_x, new_head_y)

        # The tail doesn't move if we're already within one square of the head (or in the same square)
        if (head_position.x - tail_position.x).abs <= 1 && (head_position.y - tail_position.y).abs <= 1
          next
        end

        # We're aligned on one of the two axes, so the move is simple
        if head_position.x == tail_position.x 
          new_tail_y = (head_position.y + tail_position.y) / 2
          tail_position = Point.new(tail_position.x, new_tail_y)

          tail_visited.add(tail_position)

          next
        elsif head_position.y == tail_position.y
          new_tail_x = (head_position.x + tail_position.x) / 2
          tail_position = Point.new(new_tail_x, tail_position.y)

          tail_visited.add(tail_position)

          next
        end

        # We need to move diagonally
        # If we're moving horizontally, the tail gets the same y coordinate
        if ["L", "R"].include?(move.direction)
          new_tail_x = (head_position.x + tail_position.x) / 2
          new_tail_y = head_position.y
        # Otherwise it gets the same x coordinate
        else
          new_tail_x = head_position.x
          new_tail_y = (head_position.y + tail_position.y) / 2
        end

        tail_position = Point.new(new_tail_x, new_tail_y)
        tail_visited.add(tail_position)
      end
    end

    tail_visited.size
  end

  def part_b(input)
  end
end
