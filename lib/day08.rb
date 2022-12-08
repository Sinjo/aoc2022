require "set"

class Day08
  Point = Struct.new(:x, :y)

  def part_a(input)
    visible_trees = Set.new()

    grid = input.lines.map(&:chomp).map { |line|
      line.chars.map { |height| Integer(height) }
    }
    width = grid.first.size
    height = grid.size

    (0...height).each do |y|
      (0...width).each do |x|
        if x == 0 || y == 0 || x == width - 1 || y == height - 1
          visible_trees.add(Point.new(x,y))

          next
        end

        visible = (0...x).map { |proposed_x| Point.new(proposed_x, y) }.all? { |proposed|
          grid[proposed.y][proposed.x] < grid[y][x]
        } ||
        ((x + 1)...width).map { |proposed_x| Point.new(proposed_x, y) }.all? { |proposed|
          grid[proposed.y][proposed.x] < grid[y][x]
        } ||
        (0...y).map { |proposed_y| Point.new(x, proposed_y) }.all? { |proposed|
          grid[proposed.y][proposed.x] < grid[y][x]
        } ||
        ((y + 1)...height).map { |proposed_y| Point.new(x, proposed_y) }.all? { |proposed|
          grid[proposed.y][proposed.x] < grid[y][x]
        }

        if visible
          visible_trees.add(Point.new(x, y))
        end
      end
    end

    visible_trees.size
  end

  def part_b(input)
  end
end
