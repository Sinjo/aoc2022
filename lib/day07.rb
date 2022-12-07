require "pathname"
require "set"

class Day07
  def part_a(input)
    current_path = Pathname.new("/")
    all_directories = Set.new
    file_sizes = {}

    lines = input.lines.map(&:chomp)

    lines.each do |line|
      if line.start_with?("$")
        case line
        when /^\$ cd (\/.*)/
          current_path = Pathname.new(Regexp.last_match[1])
          all_directories.add(current_path)
        when /^\$ cd \.\./
          current_path = current_path.parent
          all_directories.add(current_path)
        when /^\$ cd (.+)/
          current_path = current_path.join(Regexp.last_match[1])
          all_directories.add(current_path)
        end
      else
        case line
        when /^(\d+) ([a-zA-Z.]+)/
          file_sizes[current_path.join(Regexp.last_match[2])] = Integer(Regexp.last_match[1])
        end
      end

    end

    Hash[all_directories.map { |dir|
      total_size = file_sizes.filter { |file, _|
        file.to_s.start_with?(dir.to_s + "/")
      }.values.sum

      [dir, total_size]
    }].filter { |dir, size|
      size <= 100_000
    }.values.sum
  end

  def part_b(input)
  end
end


# 1963230 - too low
