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
    visible_trees = Set.new()

    grid = input.lines.map(&:chomp).map { |line|
      line.chars.map { |height| Integer(height) }
    }
    width = grid.first.size
    height = grid.size

    scenic_scores = []

    (0...height).each do |y|
      (0...width).each do |x|
        # Any tree on the edge has a scenic score of 0
        if x == 0 || y == 0 || x == width - 1 || y == height - 1
          next
        end

        left_score = right_score = up_score = down_score = 0
        (x - 1).downto(0).each_with_index { |inspect_x, distance|
          if grid[y][inspect_x] >= grid[y][x] || inspect_x == 0
            left_score = distance + 1
            break
          end
        }
        ((x + 1)...width).each_with_index { |inspect_x, distance|
          if grid[y][inspect_x] >= grid[y][x] || inspect_x == (width - 1)
            right_score = distance + 1
            break
          end
        }
        (y - 1).downto(0).each_with_index { |inspect_y, distance|
          if grid[inspect_y][x] >= grid[y][x] || inspect_y == 0
            up_score = distance + 1
            break
          end
        }
        ((y + 1)...height).each_with_index { |inspect_y, distance|
          if grid[inspect_y][x] >= grid[y][x] || inspect_y == (height - 1)
            down_score = distance + 1
            break
          end
        }

        scenic_scores << (left_score * right_score * up_score * down_score)
      end
    end

    scenic_scores.max
  end
end
